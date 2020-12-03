module parses

import std/os/path
import std/os/file

// Parse a file into a list of int
public fun parse-input-ints(p: string): _e list<int> {
    p.path()
        .read-text-file()
        .lines()
        .flatmap-maybe fn(l) { parse-int(l) }
}
