module parses

import std/os/path
import std/os/file

// Parse a file into a list of int
public fun parse-input-ints(p: string): _e list<int> {
    p.parse-input-lines()
        .flatmap-maybe fn(l) { parse-int(l) }
}

// Parse a file into a list of string
public fun parse-input-lines(p: string): _e list<string> {
    p.path()
        .read-text-file()
        .lines()
}
