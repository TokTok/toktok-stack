"""Global definitions and macros for genrules using tclsh."""

TCLSH = "TCL_LIBRARY=$$(dirname $(location @tcl//:library)) $(location @tcl//:tclsh)"
