# High-Dimensional Memory Allocation in Zig

## Overview
This repository demonstrates an elegant approach to allocating and managing memory for higher-dimensional objects in Zig. It provides a scalable and structured method for handling multi-dimensional arrays using dynamic memory allocation.

Additionally, this project serves as a foundation for developing an adjacency matrix generator, designed to efficiently simulate graphs and enable rapid generation of extremely large datasets for CSR semiring experiments.

## Features
- **Recursive Allocation Strategy**: Higher-dimensional arrays are constructed using a recursive approach, treating N-dimensional structures as collections of (N-1)-dimensional substructures.
- **Memory Management**: Explicit deallocation functions ensure proper cleanup and avoid memory leaks.
- **Scalability**: The approach can be extended beyond 3D to allocate tensors of arbitrary dimensions.

## Code Overview

### Generating Higher-Dimensional Arrays
The code provides functions to generate dynamically allocated arrays:
- `generate_0D()` - Generates a single random number.
- `generate_1D(allocator, size)` - Allocates a 1D array of random numbers.
- `generate_2D(allocator, size)` - Allocates a 2D square matrix.
- `generate_3D(allocator, size)` - Allocates a 3D tensor.

### Memory Deallocation
Each allocation function has a corresponding deallocation function:
- `free_1D(allocator, array)`
- `free_2D(allocator, array)`
- `free_3D(allocator, array)`

## Example Usage
```zig
const allocator = std.heap.page_allocator;
const matrix_3d = try generate_3D(allocator, 500);
defer free_3D(allocator, matrix_3d);
std.debug.print("Done", .{});
```

## Conceptual Insights
This code serves as a practical example of:
- **Inductive Type Definitions**: Higher-dimensional objects are built recursively from lower-dimensional ones.
- **Functorial Composition**: Allocation and transformation functions preserve the structure across dimensions.
- **Higher-Dimensional Thinking**: Encodes reasoning techniques used in tensor calculus and multi-dimensional programming.

## Possible Future Improvements
- Implement a generic `generate_ND` function for arbitrary dimensions.
- Optimize memory usage with efficient pooling techniques.
- Explore visualization techniques for multi-dimensional structures.
