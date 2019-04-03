defprotocol Zip do
  @moduledoc """
  The Zip interface allows all sorts of operations on collections. If you squint you might see an
  applicative.

  The collections need to have some sort of order for this interface to return stable results, so
  a good example is a list. The zip interface allows us, for example, to add elements from to lists
  together pairwise. What does pairwise mean? You take the first element in the first list, and the
  first element in the second list and add them together. Then the second elements in each list get
  added together and so on.

  ### Example

      iex> Zip.add([1, 2], [1, 2])
      [2, 4]

  """

  def add(a, b)
  def multiply(a, b)
  def subtract(a, b)
  def divide(a, b)
  def apply(a, b, fun)
  def apply(a, b, mod, fun)
  def apply(a, b, mod, fun, args)
end

defimpl Zip, for: List do
  @doc """
  Adds each element in the two lists pairwise, meaning, the first element in a
  and the first element in b are added together. Then the second element
  """
  def add(a, b), do: elementwise(a, b, Kernel, :+)
  def multiply(a, b), do: elementwise(a, b, Kernel, :*)
  def subtract(a, b), do: elementwise(a, b, Kernel, :-)
  def divide(a, b), do: elementwise(a, b, Kernel, :/)
  def apply(a, b, fun), do: elementwise(a, b, fun)
  def apply(a, b, mod, fun), do: elementwise(a, b, mod, fun)
  def apply(a, b, mod, fun, args), do: elementwise(a, b, mod, fun, args)

  def elementwise(a, b, fun) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    a
    |> Enum.with_index()
    |> Enum.map(fn {item, index} ->
      fun.(item, Enum.at(b, index))
    end)
  end

  def elementwise(a, b, mod, fun, args) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    a
    |> Enum.with_index()
    |> Enum.map(fn {item, index} ->
      Kernel.apply(mod, fun, [item, Enum.at(b, index)] ++ args)
    end)
  end

  def elementwise(a, b, mod, fun) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    a
    |> Enum.with_index()
    |> Enum.map(fn {item, index} ->
      Kernel.apply(mod, fun, [item, Enum.at(b, index)])
    end)
  end
end

# The combinations are:
# 1. The type of collection you are using (list, stream, whatever)
# 2. The elements of the list - their type (int float decimal)
# 3. The operations on those types (add, subtract, divide, split....)
