const std = @import("std");

extern fn get_answer() i32;

test {
    try std.io.getStdOut().writer().print("{d}\n", .{get_answer()});
}
