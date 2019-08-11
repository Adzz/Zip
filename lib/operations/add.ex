defprotocol Add do
  # I think if you need free variables, that is where the value comes in.
  # For example, to Add, you need two things to add together. If you Zip.add
  # the the two variables come from the lists. If you map, the other one has to
  # come from somewhere else.
  defstruct [:value, zip: &__MODULE__.zip/2, mapm: &__MODULE__.mapm/2]
  def zip(a, b)
  def mapm(x, operation)
end

defimpl Add, for: Integer do
  def zip(a, b) when is_integer(b), do: a + b
  def mapm(x, %{value: value}) when is_integer(value), do: x + value
  def mapm(x, %{value: value = %Decimal{}}), do: Decimal.to_integer(Decimal.round(value)) + x
end

defimpl Add, for: Decimal do
  def zip(decimal, decimal_2 = %Decimal{}), do: Decimal.add(decimal, decimal_2)
  def mapm(x, %{value: value = %Decimal{}}), do: Decimal.add(x, value)
  def mapm(x, %{value: value}) when is_integer(value), do: Decimal.add(x, Decimal.new(value))
end

defimpl Add, for: List do
  def zip(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Add{})
  def mapm(list, operation), do: MapM.apply(list, operation)
end

defimpl Add, for: Map do
  def zip(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Add{})
  def mapm(map, operation), do: MapM.apply(map, operation)
end

defimpl Add, for: PID do
  def zip(pid, pid_2) when is_pid(pid_2), do: Zip.apply(pid, pid_2, %Add{})
  def mapm(pid, operation), do: MapM.apply(pid, operation)
end

# Streams
defimpl Add, for: Function do
  def zip(stream, stream_2) when is_function(stream_2) do
    Zip.apply(stream, stream_2, %Add{})
  end

  def mapm(stream, operation), do: MapM.apply(stream, operation)
end
