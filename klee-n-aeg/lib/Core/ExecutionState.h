//===-- ExecutionState.h ----------------------------------------*- C++ -*-===//
//
//                     The KLEE Symbolic Virtual Machine
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef KLEE_EXECUTIONSTATE_H
#define KLEE_EXECUTIONSTATE_H

#include "AddressSpace.h"
#include "MergeHandler.h"

#include "klee/ADT/TreeStream.h"
#include "klee/Expr/Constraints.h"
#include "klee/Expr/Expr.h"
#include "klee/Module/KInstIterator.h"
#include "klee/System/Time.h"

#include <map>
#include <set>
#include <vector>

namespace klee {
class Array;
class CallPathNode;
struct Cell;
struct KFunction;
struct KInstruction;
class MemoryObject;
class PTreeNode;
struct InstructionInfo;

llvm::raw_ostream &operator<<(llvm::raw_ostream &os, const MemoryMap &mm);

struct StackFrame {
  KInstIterator caller;
  KFunction *kf;
  CallPathNode *callPathNode;

  std::vector<const MemoryObject *> allocas;
  Cell *locals;

  /// Minimum distance to an uncovered instruction once the function
  /// returns. This is not a good place for this but is used to
  /// quickly compute the context sensitive minimum distance to an
  /// uncovered instruction. This value is updated by the StatsTracker
  /// periodically.
  unsigned minDistToUncoveredOnReturn;

  // For vararg functions: arguments not passed via parameter are
  // stored (packed tightly) in a local (alloca) memory object. This
  // is set up to match the way the front-end generates vaarg code (it
  // does not pass vaarg through as expected). VACopy is lowered inside
  // of intrinsic lowering.
  MemoryObject *varargs;

  StackFrame(KInstIterator caller, KFunction *kf);
  StackFrame(const StackFrame &s);
  ~StackFrame();
};

/* Jiaqi */
struct HeapAlloc {
    // llvm::Value* allocSite;
    int req;//1: malloc; 2: free. 
    const MemoryObject* mo;
    unsigned long size; 
    unsigned long alignment;
    unsigned long nativeAddress;
    // bool zeroMemory; 
    bool operator!=(const HeapAlloc &ha) const {
        // return ha.mo == mo && ha.req == req;
        // return ha.req == req && ha.size == size && ha.nativeAddress == nativeAddress;
        return ha.req != req || ha.size != size || ha.mo != mo;
    }
    // HeapAlloc(MemoryObject* mo, int req, u64 size, u64 alignment, bool zeroMemory): mo(mo), req(req), size(size), alignment(alignment), zeroMemory(zeroMemory){};
    HeapAlloc(MemoryObject* MO, int Req, unsigned long Size, unsigned long align, unsigned long NativeAddress){
        mo = MO;
        req = Req;
        size = Size;
        alignment = align;
        // if (NativeAddress != NULL)
        // {
            nativeAddress = NativeAddress;
        // }
        // printf ("NativeAddress: %lx. \n", NativeAddress);
    };
    ~HeapAlloc(){};
};
struct kn_indica {
    int flag; // 0 = no request; 1 = have requests
    int num; // total number of requests
};

//klee sends overflow memory req to nme
struct of_k {
    bool rw; //0 = read; 1 = write
    unsigned long addr;
    unsigned long bytes;
};

//NME split oflow_k into multiple memroy regions, each corresponds to a valid mo
//in KLEE or a null mo. 
struct of_n {
    unsigned long addr_s;
    unsigned long bytes;
    MemoryObject* mo;
};

// struct w_req { 
//     MemoryObject* mo;
//     size_t bytes;
//     ref<Expr> value;
// };
/* /Jiaqi */
/// @brief ExecutionState representing a path under exploration
class ExecutionState {
    public:
        typedef std::vector<StackFrame> stack_ty;
        /* Jiaqi */
        typedef std::vector<HeapAlloc> heap_alloc;
        // heap_alloc heap_allocs;
        // int native_idx; // indicate to which heap_alloc in the vector has been natively executed. 
        /* /Jiaqi */
   
    private:
        // unsupported, use copy constructor
        ExecutionState &operator=(const ExecutionState &);

    public:
        // Execution - Control Flow specific

        /// @brief Pointer to instruction to be executed after the current
        /// instruction
        KInstIterator pc;

        /// @brief Pointer to instruction which is currently executed
        KInstIterator prevPC;

        /// @brief Stack representing the current instruction stream
        stack_ty stack;

        /* Jiaqi */
        heap_alloc heap_allocs;
        /* /Jiaqi */

        /// @brief Remember from which Basic Block control flow arrived
        /// (i.e. to select the right phi values)
        unsigned incomingBBIndex;

        // Overall state of the state - Data specific

        /// @brief Address space used by this state (e.g. Global and Heap)
        AddressSpace addressSpace;

        /// @brief Constraints collected so far
        ConstraintManager constraints;

        /// Statistics and information

        /// @brief Costs for all queries issued for this state, in seconds
        mutable time::Span queryCost;

        /// @brief Exploration depth, i.e., number of times KLEE branched for this state
        unsigned depth;

        /// @brief History of complete path: represents branches taken to
        /// reach/create this state (both concrete and symbolic)
        TreeOStream pathOS;

        /// @brief History of symbolic path: represents symbolic branches
        /// taken to reach/create this state
        TreeOStream symPathOS;

        /// @brief Counts how many instructions were executed since the last new
        /// instruction was covered.
        unsigned instsSinceCovNew;

        /// @brief Whether a new instruction was covered in this state
        bool coveredNew;

        /// @brief Disables forking for this state. Set by user code
        bool forkDisabled;

        /// @brief Set containing which lines in which files are covered by this state
        std::map<const std::string *, std::set<unsigned> > coveredLines;

        /// @brief Pointer to the process tree of the current state
        PTreeNode *ptreeNode;

        /// @brief Ordered list of symbolics: used to generate test cases.
        //
        // FIXME: Move to a shared list structure (not critical).
        std::vector<std::pair<ref<const MemoryObject>, const Array *>> symbolics;

        /// @brief Set of used array names for this state.  Used to avoid collisions.
        std::set<std::string> arrayNames;

        // The objects handling the klee_open_merge calls this state ran through
        std::vector<ref<MergeHandler> > openMergeStack;

        // The numbers of times this state has run through Executor::stepInstruction
        std::uint64_t steppedInstructions;

    private:
        ExecutionState() : ptreeNode(0) {}

    public:
        ExecutionState(KFunction *kf);

        // XXX total hack, just used to make a state so solver can
        // use on structure
        ExecutionState(const std::vector<ref<Expr> > &assumptions);

        ExecutionState(const ExecutionState &state);

        ~ExecutionState();

        ExecutionState *branch();

        void pushFrame(KInstIterator caller, KFunction *kf);
        void popFrame();

        void addSymbolic(const MemoryObject *mo, const Array *array);
        void addConstraint(ref<Expr> e) { constraints.addConstraint(e); }

        bool merge(const ExecutionState &b);
        void dumpStack(llvm::raw_ostream &out) const;
};
}

#endif /* KLEE_EXECUTIONSTATE_H */
