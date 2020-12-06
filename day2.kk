module day2

import aoc/effects
import aoc/lists
import aoc/parses
import aoc/tests
import aoc/types

import std/time/timer
import std/text/parse

public fun main() {
    print-elapsed fn() {
        val input = parse-input-lines("./day2/data1.txt")
        
        // Task 1
        with fun read() { input }
        with fun compute() { compute1() }
        eval()

        // Task 2
        with fun read() { input }
        with fun compute() { compute2() }
        eval()
    }
}

struct password (
  start: int,
  end: int,
  ch: char,
  s: string
)

fun password-parser(): parse password
{
    val start = pint()
    char('-')
    val end = pint()
    char(' ')
    val c = alpha()
    char(':')
    char(' ')
    val s = string()

    Password(start, end, c, s)
}

fun parse-line(line: string) : maybe<password>
{
    line.slice
        .parse-eof(password-parser)
        .maybe
}

fun string() : parse string
{
    many(alpha)
        .foldl("") fn(acc, c) { acc + c.string }
}

fun is-valid-fst(pwd: password): bool
{
    val count = pwd.s.count fn(c) { c == pwd.ch }
    count >= pwd.start && count <= pwd.end
}

fun is-valid-snd(pwd: password): bool
{
    try-default(False) {
        val chars = pwd.s.vector
        val test1 = chars[pwd.start - 1] == pwd.ch
        val test2 = chars[pwd.end - 1] == pwd.ch
        test1.xor(test2)
    }
}

fun compute1()
{
    val count = read()
        .flatmap-maybe(parse-line)
        .filter(is-valid-fst)
        .length()
        
    Just(count)
}

fun compute2()
{
    val count = read()
        .flatmap-maybe(parse-line)
        .filter(is-valid-snd)
        .length()

    Just(count)
}

// Tests

public fun tests()
{
    val input = [ "1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc" ]

    test("Task 1") fn() {
        with fun read() { input }
        val result = compute1()
        result.should-be-just(2)
    }

    test("Task 2") fn() {
        with fun read() { input }
        val result = compute2()
        result.should-be-just(1)
    }

}