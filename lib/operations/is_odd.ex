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
