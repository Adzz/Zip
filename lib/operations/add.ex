defprotocol Add do
  defstruct [:value, calculate: &__MODULE__.calculate/2, mapm: &__MODULE__.mapm/2]
  def calculate(a, b)
  def mapm(x, operation)
end

defimpl Add, for: Integer do
  def calculate(a, b) when is_integer(b), do: a + b
  def mapm(x, %{value: value}) when is_integer(value), do: x + value
  def mapm(x, %{value: value = %Decimal{}}), do: Decimal.to_integer(Decimal.round(value)) + x
end

defimpl Add, for: Decimal do
  def calculate(decimal, decimal_2 = %Decimal{}), do: Decimal.add(decimal, decimal_2)
  def mapm(x, %{value: value = %Decimal{}}), do: Decimal.add(x, value)
  def mapm(x, %{value: value}) when is_integer(value), do: Decimal.add(x, Decimal.new(value))
end

defimpl Add, for: List do
  def calculate(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Add{})
  def mapm(list, operation), do: MapM.apply(list, operation)
end

defimpl Add, for: Map do
  def calculate(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Add{})
  def mapm(map, operation), do: MapM.apply(map, operation)
end

defimpl Add, for: PID do
  def calculate(pid, pid_2) when is_pid(pid_2), do: Zip.apply(pid, pid_2, %Add{})
  def mapm(pid, operation), do: MapM.apply(pid, operation)
end

# Streams
defimpl Add, for: Function do
  def calculate(stream, stream_2) when is_function(stream_2) do
    Zip.apply(stream, stream_2, %Add{})
  end

  def mapm(stream, operation), do: MapM.apply(stream, operation)
end
