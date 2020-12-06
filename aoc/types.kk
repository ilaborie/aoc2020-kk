module types


public fun xor(b1: bool, b2: bool): bool
{
  (b1 && !b2) || (!b1 && b2)
}