# What is the advantage of having the operations be data structures?
# I think I have been "defunctionalizing the continuation" without even realising?
# This is in effect turning functions into data structures. What are the implications of that?

defprotocol Fmap do
  @moduledoc """
  This works like the Enum.map we know and love. We can use it like this, if  we provide the correct
  implementations for lists, addition of integers and decimals:

      iex> Fmap.apply([1, 2, 3], %Add{value: 10})
      [11, 12, 13]

      iex> Fmap.apply([1, 2, Decimal.new(3)], %Add{value: 10})
      [11, 12, #Decimal<13>]

      iex> Fmap.apply([1, 2, Decimal.new(3)], %Add{value: Decimal.new(10)})
      [11, 12, #Decimal<13>]

      iex> Fmap.apply([[1, 2, Decimal.new(3)]], %Add{value: 10})
      [[11, 12, #Decimal<13>]]
  """
  def apply(x, operation)
end
