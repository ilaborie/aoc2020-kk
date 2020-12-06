module day1

import aoc/effects
import aoc/lists
import aoc/parses
import aoc/tests
import std/time/timer

public fun main() {
    print-elapsed {
        val input = parse-input-ints("./day1/data1.txt")
        
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


fun find-pair(target: int, x: int, lst: list<int>): maybe<(int, int)>
{
    match(lst) {
        Nil -> Nothing
        Cons(head, tail) -> if ((x + head) == target)
                             then Just((x, head))
                             else find-pair(target, x, tail)
    }
}

fun find-triple(target: int, x: int, lst: list<int>): maybe<(int, int, int)>
{
    match(lst) {
        Nil -> Nothing
        Cons(head, tail) -> 
            match(find-pair(target - x, head, tail)) {
                Just((a,b)) -> Just((x, a, b))
                Nothing -> find-triple(target, x, tail)
            }
    }
}


fun compute1()
{
    read()
        .foreach-while-tail fn(head, tail) { find-pair(2020, head, tail) }
        .map fn(p) { p.fst * p.snd }
}

fun compute2()
{
    read()
        .foreach-while-tail fn(head, tail) { find-triple(2020, head, tail) }
        .map fn(t) { t.fst * t.snd * t.thd }
}

// Tests

public fun tests()
{

    test("Task 1") {
        with fun read() { [1721, 979, 366, 299, 675, 1456] }
        val result = compute1()
        result.should-be-just(514579)
    }

    test("Task 2") {
        with fun read() { [1721, 979, 366, 299, 675, 1456] }
        val result = compute2()
        result.should-be-just(241861950)
    }

}