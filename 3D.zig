const std = @import("std");

/// Generate a single random number between 1 and 99 (0D).
fn  generate_0D() u8 {
    var rand = std.crypto.random;
    return rand.int(u8) % 99 + 1;
}

/// Generate a heap-allocated one-dimensional array of random numbers.
fn  generate_1D(allocator: std.mem.Allocator, size: usize) ![]u8 {
    // Allocate memory for the array
    const result = try allocator.alloc(u8, size);

    // Fill the array with random numbers using generate_0D
    for (result) |*n| {
        n.* = generate_0D();
    }

    return result;
}
fn  free_1D(allocator: std.mem.Allocator, array: []u8) void {
    allocator.free(array);
}

/// Generate a heap-allocated 2D array (square matrix) of random numbers.
fn  generate_2D(allocator: std.mem.Allocator, size: usize) ![][]u8 {
    // Allocate memory for the outer array (rows)
    const result = try allocator.alloc([]u8, size);

    // Allocate memory for each row and fill with random numbers
    for (result) |*row| {
        row.* = try generate_1D(allocator, size);
    }

    return result;
}
fn  free_2D(allocator: std.mem.Allocator, array: [][]u8) void {
    for (array) |row| {
        free_1D(allocator, row);
    }
    allocator.free(array);
}

/// Generate a heap-allocated 3D array (square matrix) of random numbers.
fn  generate_3D(allocator: std.mem.Allocator, size: usize) ![][][]u8 {
    // Allocate memory for the outer array (rows)
    const result = try allocator.alloc([][]u8, size);

    // Allocate memory for each row and fill with random numbers
    for (result) |*row| {
        row.* = try generate_2D(allocator, size);
    }

    return result;
}
fn  free_3D(allocator: std.mem.Allocator, array: [][][]u8) void {
    for (array) |row| {
        free_2D(allocator, row);
    }
    allocator.free(array);
}

pub fn  main() !void {
    const allocator = std.heap.page_allocator;
    const matrix_2d = try generate_3D(allocator, 500);
    defer free_3D(allocator, matrix_2d); 
    std.debug.print("Done", .{});
}
