module lists

// Like foreach-while, but it pass the head and the tail to the action
public fun foreach-while-tail(lst : list<a>, action : (a, list<a>) -> e maybe<b> ) : e maybe<b>
{
  match(lst) {
    Nil        -> Nothing
    Cons(head, tail) -> {
      match(action(head, tail)) {
        Nothing -> tail.foreach-while-tail(action)
        just    -> just
      }
    }
  }
}