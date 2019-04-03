defprotocol Zip do
  def add(a, b)
  def multiply(a, b)
  def subtract(a, b)
  def divide(a, b)
end

defimpl Zip, for: List do
  def add(a, b), do: elementwise(a, b, Kernel, :+)
  def multiply(a, b), do: elementwise(a, b, Kernel, :*)
  def subtract(a, b), do: elementwise(a, b, Kernel, :-)
  def divide(a, b), do: elementwise(a, b, Kernel, :/)

  def elementwise(a, b, mod, fun) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    a
    |> Enum.with_index()
    |> Enum.map(fn {item, index} ->
      apply(mod, fun, [item, Enum.at(b, index)])
    end)
  end
end

# The combinations are:
# 1. The type of collection you are using (list, stream, whatever)
# 2. The elements of the list - their type (int float decimal)
# 3. The operations on those types (add, subtract, divide, split....)
