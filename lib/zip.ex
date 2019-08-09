defprotocol Zip do
  @moduledoc """
  The Zip interface allows all sorts of operations on collections. If you squint you might see an
  applicative.

  The collections need to have some sort of order for this interface to return stable results, so
  a good example is a list. The zip interface allows us, for example, to add elements from two lists
  together pairwise. What does pairwise mean? You take the first element in the first list, and the
  first element in the second list and add them together. Then the second elements in each list get
  added together and so on.

  ### Example

      iex> Zip.apply([1, 2], [1, 2], %Add{})
      [2, 4]
  """
  def apply(collection_1, collection_2, operation)
end

# What is the advantage of having the operations be data structures?
# I think I have been "defunctionalizing the continuation" without even realising?
# This is in effect turning functions into data structures. What are the implications of that?

defprotocol MapM do
  @moduledoc """
  This works like the Enum.map we know and love. We can use it like this, if  we provide the correct
  implementations for lists, addition of integers and decimals:

      iex> MapM.apply([1, 2, 3], %Add{value: 10})
      [11, 12, 13]

      iex> MapM.apply([1, 2, Decimal.new(3)], %Add{value: 10})
      [11, 12, #Decimal<13>]

      iex> MapM.apply([1, 2, Decimal.new(3)], %Add{value: Decimal.new(10)})
      [11, 12, #Decimal<13>]

      iex> MapM.apply([[1, 2, Decimal.new(3)]], %Add{value: 10})
      [[11, 12, #Decimal<13>]]
  """
  def apply(x, operation)
end

defimpl MapM, for: List do
  # Naming the key the same as the action is better for
  # operations that span different actions. So, Add (operation)
  # can be used for Zip and MapM (i dont have a word for these higher order
  # actions), meaning we can't just use calculate, we should use
  # %{zip: zip} for Zip and %{mapm: mapm} for MapM
  def apply(a, operation = %{mapm: mapm}) do
    Enum.map(a, fn x -> mapm.(x, operation) end)
  end

  def apply(a, fun) when is_function(fun) do
    Enum.map(a, fun)
  end
end

# What are the semantics for filter? Realistically you need to filter based on a
# condition, meaning the semantics are a function that returns a boolean.
# Difficulty is that can be with another variable or not, but that can be
# encapsulated by the operation:

defprotocol Filter do
  def apply(x, operation)
end

defimpl Filter, for: List do
  # We don't know if the filtering fun needs to pass
  # the operation along or not. It would need to if the operation
  # has one or more "free variables". That is, if the operation we are trying to
  # perform requires two or more variables. An example is LessThan needing 2 numbers
  # to compare.
  # The only way to tell is if the operation has a value key. This key could
  # become the way that an operation adds any free variables (e.g. if it needs
  # two free variables, values becomes an array)
  def apply(a, operation = %{filter: filter, value: _}) do
    Enum.filter(a, fn x -> filter.(x, operation) end)
  end

  def apply(a, %{filter: filter}) do
    Enum.filter(a, fn x -> filter.(x) end)
  end

  def apply(a, fun) when is_function(fun) do
    Enum.filter(a, fun)
  end
end

defprotocol LessThan do
  defstruct [:value, filter: &__MODULE__.filter/2]
  def filter(a, operation)
end

defprotocol IsOdd do
  defstruct filter: &__MODULE__.filter/1
  def filter(a)
end

defimpl IsOdd, for: Integer do
  def filter(a) do
    require Integer
    Integer.is_odd(a)
  end
end

defimpl LessThan, for: Integer do
  def filter(a, %{value: value}) when is_integer(value), do: a < value
end

# Filter.apply([1, 2, 3, 4, 5], %LessThan{value: 3})
# [3,4,5]

# Filter.apply([1, 2, 3, 4, 5], %IsOdd{})
# [2,4]
