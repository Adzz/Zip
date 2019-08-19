defprotocol Filter do
  @moduledoc """
  Filter.apply([1, 2, 3, 4, 5], %LessThan{value: 3})
  [3,4,5]

  Filter.apply([1, 2, 3, 4, 5], %IsOdd{})
  [2,4]
  """
  def apply(x, operation)
end
