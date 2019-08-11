defprotocol Add do
  @moduledoc """
  Use this Add operation when the action you are doing will provide one variable to the add function.
  You can then provide the other under the value key. An example is map'ing over a list. When maping
  over a list you take each element out of the list and pass that to the adding function. But in
  order to 'add' you need two things to add together. So in this case you would provide the second
  through this adding function:

  MapM.apply([1,2,3,4,5], %Add{value: 10})

  This is in contrast to a Zipping action, which would take the two variables to be added together
  from each of the lists it is adding together.

  Zip.apply([1], [1], %Zip.Add{})
  """
  @enforce_keys [:value]
  defstruct [:value, mapm: &__MODULE__.mapm/2]
  def mapm(x, operation)
end

# Maybe a better name is one that indicates it has no free variables, so that it is generalisable
# to any action that will only provide both, not just to zip? What other actions provide both args?
# something something partial application?
defprotocol Zip.Add do
  @moduledoc """
  Use this Add operation when the action you are doing will provide both variables to the add function.
  An example is zipping two lists together:

  Zip.apply([1], [1], %Zip.Add{})

  This is in contrast to a Mapping action, which would take only one variable from the list being
  mapped over, and would therefore require another variable, which could be provided from the Add
  operation itself.

  MapM.apply([1,2,3,4,5], %Add{value: 10})
  """
  defstruct zip: &__MODULE__.zip/2
  def zip(a, b)
end

defmodule Int do
  def add(a, b) when is_integer(b), do: a + b
end

defimpl Add, for: Integer do
  def mapm(x, %{value: value}) when is_integer(value), do: Int.add(x, value)
  def mapm(x, %{value: value = %Decimal{}}), do: Decimal.to_integer(Decimal.round(value)) + x
end

defimpl Zip.Add, for: Integer do
  def zip(a, b) when is_integer(b), do: Int.add(a, b)
end

defimpl Add, for: Decimal do
  def mapm(x, %{value: value = %Decimal{}}), do: Decimal.add(x, value)
  def mapm(x, %{value: value}) when is_integer(value), do: Decimal.add(x, Decimal.new(value))
end

defimpl Zip.Add, for: Decimal do
  def zip(decimal, decimal_2 = %Decimal{}), do: Decimal.add(decimal, decimal_2)
end

defimpl Add, for: List do
  def mapm(list, operation), do: MapM.apply(list, operation)
end

defimpl Zip.Add, for: List do
  def zip(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Zip.Add{})
end

defimpl Add, for: Map do
  def mapm(map, operation), do: MapM.apply(map, operation)
end

defimpl Zip.Add, for: Map do
  def zip(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Zip.Add{})
end

defimpl Add, for: PID do
  def mapm(pid, operation), do: MapM.apply(pid, operation)
end

defimpl Zip.Add, for: PID do
  def zip(pid, pid_2) when is_pid(pid_2), do: Zip.apply(pid, pid_2, %Zip.Add{})
end

# Streams
defimpl Add, for: Function do
  def mapm(stream, operation), do: MapM.apply(stream, operation)
end

defimpl Zip.Add, for: Function do
  def zip(stream, stream_2) when is_function(stream_2) do
    Zip.apply(stream, stream_2, %Zip.Add{})
  end
end
