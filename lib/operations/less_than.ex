defprotocol LessThan do
  defstruct [:value, filter: &__MODULE__.filter/2]
  def filter(a, operation)
end

defimpl LessThan, for: Integer do
  def filter(a, %{value: value}) when is_integer(value), do: a < value
end
