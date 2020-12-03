module tests

import std/time/instant
import std/time/duration
import std/time/chrono
import std/time/timestamp
import std/time/timer
import std/time/utc
import std/num/ddouble

// Test an expression
public fun test(name: string, test: () -> <console,exn,ndet> error<()>)
{
    try(
        fn() {
            val (t, result) = elapsed fn() { test() }
            report-console(name, t, result)
        },
        fn(ex: exception) { 
            // println("💥 " + name + " - " + ex.show) 
            report-console(name, duration0, Error(ex))
        }
    )
}

/* Assertions

    WIP
*/

fun check(condition: bool, msg: () -> string): error<()>
{
    if (condition) 
     then Ok(())
     else Error(Exception(message = msg(), info = ExnAssert))
}

// Check two int are equals
public fun should-be(x: int, y: int)
{
    check(x == y) fn() {  "Expected: " + y.show + ", but have: " + x.show }
}

// Check a maybe<int>
public fun should-be-just(x: maybe<int>, y: int)
{
    match(x) {
        Nothing -> check(False) fn() { "Expected: Just(" + y.show + "), but have: Nothing" }
        Just(i) -> check(i == y) fn() {  "Expected: Just(" + y.show + "), but have: Just(" + i.show + ")" }
    }
}

/* Reporting

    WIP maybe use an effect?
*/

// Report in console
fun report-console(name: string, t: duration, result: error<()>)
{
    val message = match(result) {
        Ok(_)      -> "✅ " + name + " (⏱ " + t.show(9) + ")"
        Error(err) -> "🚨 " + name + " - " + err.show
    }
    println(message)
}