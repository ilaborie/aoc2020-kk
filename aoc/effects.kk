module effects

public effect read<a>
{
  fun read() : a
}

public effect compute
{
    fun compute() : maybe<int>
}

public fun eval(): <compute,console> ()
{
    match(compute()) {
      Nothing -> println("😭 Not found")
      Just(i) -> println("Result: " + i.show)
    }   
}
