#include <stdlib.h>
#include <stdio.h>

#define BIT(r, c) (1ULL << ((r) * 8 + (c)))
#define BIT_IF_VALID(r, c) ((r >= 0 && r <= 7 && c >= 0 && c <= 7) ? BIT(r, c) : 0)

int main()
{
    int r, c;

    // // engine = cgc_malloc(sizeof(engine_t));
    // engine = malloc(sizeof(engine_t));
    // if (engine == NULL)
    //     return 0;
    // cgc_memset(engine, 0, sizeof(engine_t));
    // cgc_memset(engine->mailbox, EMPTY, 64);

    for (r = 0; r < 8; r++)
    for (c = 0; c < 8; c++)
    {
        printf ("r: %d, c: %d. \n", r, c);
        // if (r >= 0 && r <= 7 && (c-1) >= 0 && (c-1) <= 7) 
        //     printf ("%x, \n", ((r) * 8 + (c-1)));
        // if (r >= 0 && r <= 7 && (c-1) >= 0 && (c-1) <= 7) 
        //     printf ("%x, \n", ((r) * 8 + (c-1)));
        // bboard_t moves = 0;
        int64_t moves = 0;
        
        moves |= BIT_IF_VALID(r-2, c-1);
        moves |= BIT_IF_VALID(r-1, c-2);
        moves |= BIT_IF_VALID(r-2, c+1);
        moves |= BIT_IF_VALID(r-1, c+2);
        moves |= BIT_IF_VALID(r+2, c-1);
        moves |= BIT_IF_VALID(r+1, c-2);
        moves |= BIT_IF_VALID(r+2, c+1);
        moves |= BIT_IF_VALID(r+1, c+2);

        // KNIGHT_MOVES[r * 8 + c] = moves;

        moves = 0;
        moves |= BIT_IF_VALID(r-1, c-1);
        moves |= BIT_IF_VALID(r-1, c);
        moves |= BIT_IF_VALID(r-1, c+1);
        /* Jiaqi */
        printf ("moves: %lx. r: %d. c-1: %d. \n", moves, r, c-1);
        if (r >= 0 && r <= 7 && (c-1) >= 0 && (c-1) <= 7) 
            printf ("-------------------  %x, \n", ((r) * 8 + (c-1)));
        /* /Jiaqi */
        moves |= BIT_IF_VALID(r, c-1);
        moves |= BIT_IF_VALID(r, c+1);
        moves |= BIT_IF_VALID(r+1, c-1);
        moves |= BIT_IF_VALID(r+1, c);
        moves |= BIT_IF_VALID(r+1, c+1);

        // KING_MOVES[r * 8 + c] = moves;
    }

}
