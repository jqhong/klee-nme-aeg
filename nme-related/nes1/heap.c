// #include <string.h>
#include <stdio.h>
#include <stdlib.h>
// #include <unistd.h>
#include <errno.h>
// #include <ctype.h>
// #include <sys/mman.h>
// #include <sys/types.h>
// #include <sys/stat.h>
// #include <fcntl.h>
#include "heap.h"

// #include "../../glibc-2.27-klee/glibc-2.27/malloc/malloc.h"
// #include "../../glibc-2.27-klee/glibc-2.27/include/malloc.h"

/* only works for single thread */
void* nme_malloc (size_t size, void* n_ptr)
{
    // asm
    asm volatile ("mov $0xabcdabcd, %rax; \n\t"
            "vmcall; \n\t");
    if (n_ptr == NULL)
        return NULL;

    /* Find &main_arena, search in tcache first, then obtain heap lock and
     * search in fastbins, unsorted bins and so on */
    // mstate ar_ptr = &main_arena;
    // void* victim;

    /* search in tcache with exact size */
    size_t tbytes;
    checked_request2size (size, tbytes);
    size_t tc_idx = csize2tidx (tbytes);

    printf ("tc_idx : %ld, tbytes: %lx. tcache_counts: %d. \n", tc_idx, tbytes, tcache->counts[tc_idx]);

    if (tc_idx < mp_->tcache_bins
            /*&& tc_idx < TCACHE_MAX_BINS*/ /* to appease gcc */
            && tcache
            && tcache->entries[tc_idx] != NULL)
    {
        tcache_entry *e = tcache->entries[tc_idx];
        if (e == n_ptr)
        {
            tcache->entries[tc_idx] = e->next;
            --(tcache->counts[tc_idx]);
            // goto out;
            return (void *) e;
        }
        else
        {
            tcache_entry *e_next = e->next;
            do {
                // printf ("e_next: %p. \n", e_next);
                if (e_next == n_ptr)
                {
                    e->next = e_next->next;
                    --(tcache->counts[tc_idx]);
                    // goto out;
                    return (void *) e_next;
                }
                e = e_next;
                e_next = e_next->next;
            } while (e_next != NULL);
        }
    }

    /* search in fastbins */
    INTERNAL_SIZE_T nb;               /* normalized request size */
    checked_request2size (size, nb);
    
    if ((unsigned long) (nb) <= (unsigned long) (get_max_fast ()))
    {
        int idx = fastbin_index (nb);
        void* mem;
        mfastbinptr *fb = &fastbin (mstate, idx);
        mchunkptr victim = *fb;
        mchunkptr pp = victim;
        mem = chunk2mem(victim);

        // do {
        //     printf ("victim: %p, fd: %p, bk: %p. size: %lx, p_size: %lx. \n", victim, victim->fd, victim->bk, victim->mchunk_size, victim->mchunk_prev_size);
        //     victim = victim->fd;
        //     mem = chunk2mem(victim);
        //     printf ("mem: %p. \n", mem);
        // } while (victim != NULL);
        
        if (mem == n_ptr)
        {
            *fb = victim->fd;
            pp = victim->fd;
            pp->bk = NULL;
            pp->mchunk_prev_size = 0;
            return mem;
        }
        else
        {
            do {
                pp = victim;
                victim = victim->fd;
                if (victim == NULL)//not find in corresponding fastbin
                    break;
                mem = chunk2mem(victim);
                printf ("in fast bin: %p. \n", victim);
                if (mem == n_ptr)
                {
                    // REMOVE_FB (fb, pp, victim);
                    pp->fd = victim->fd;
                    victim = victim->fd;
                    victim->bk = pp;
                    return (void *) mem;
                }
            // } while (victim != NULL);
            } while (1);
        }
    }

    // /* search in unsortedbin */
    // for (;;)
    // {
    //     while (victim = unsorted_chunks(av)->bk != unsorted_chunks (av))//unsortedbin is not empty
    //     {
    //         bck = victim->bk; 
    //     }

    // }
            
    return NULL;
}

// int main (void)
// {
//     nme_malloc (0x0, 0x0);
//     return 1;
// }
