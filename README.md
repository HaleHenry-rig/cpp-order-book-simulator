# C++ Real-Time Order Book Simulator

A command-line C++ application that simulates a real-time financial order book for a single asset. The system processes buy and sell orders, matches them based on price-time priority, and logs trades automatically.

## Features

- **Real-Time Matching Engine**: Automatically matches buy and sell orders when prices cross
- **Price-Time Priority**: Orders are matched based on best price first, then by time (FIFO)
- **Lazy Deletion**: Efficient order cancellation using lazy deletion technique
- **Partial Fills**: Large orders can be partially filled across multiple trades
- **Interactive CLI**: Simple command-line interface for order management

## Architecture

The system uses efficient data structures for optimal performance:

- **Max-Heap (Priority Queue)**: Stores all BUY orders, with highest price at the top
- **Min-Heap (Priority Queue)**: Stores all SELL orders, with lowest price at the top
- **Hash Map**: Provides O(1) lookup for order cancellation
- **Lazy Deletion**: Canceled orders are marked inactive and cleaned during matching

### Time Complexity Analysis

- **Order Insertion:** `O(log n)` — Inserting an order into the max-heap (bids) or min-heap (asks) takes logarithmic time.
- **Order Cancellation:** `O(1)` amortized — Handled by a fast hash map lookup that marks the order as inactive (lazy deletion).
- **Order Matching:** `O(log n)` amortized — Derived from pulling the top order from the heap and cleaning up lazily deleted orders during the matching process.
- **Order Lookup:** `O(1)` — Executed instantly via the hash map.

### Design Decisions

1. **Why Max-Heap for Bids & Min-Heap for Asks?** We always need to match the highest willing buyer with the lowest willing seller. A max-heap naturally keeps the highest bid price at the root, and a min-heap keeps the lowest ask price at the root, making the matching check an instant `O(1)` operation.

2. **Why a Hash Map for Cancellation?** Standard priority queues do not support efficient searching. If a user cancels an order, scanning the heap to find it would take `O(n)` time. By mapping order IDs to their memory locations via a hash map, we can locate and flag any order instantly in `O(1)` time.

3. **Why Lazy Deletion?** Removing an element from the middle of a heap is an expensive `O(n)` operation. Instead of removing canceled orders immediately, we mark them as `inactive` via the hash map. When the matching engine encounters an inactive order at the top of the heap later, it simply pops and discards it. This keeps the cancellation action strictly `O(1)`.

## Building

### Prerequisites

- C++17 compatible compiler (g++ recommended)
- Make

### Compilation

```bash
make
