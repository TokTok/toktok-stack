const std = @import("std");

const c = @cImport({
        @cInclude("third_party/zig/csource.h");
});

test {
    try std.io.getStdOut().writer().print("{d}\n", .{c.get_answer(4)});
}
