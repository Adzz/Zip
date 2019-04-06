defimpl Zip, for: List do
  @doc """
  Adds each element in the two lists pairwise, meaning, the first element in a
  and the first element in b are added together. Then the second element in each
  are and so on. Returns a list of the result of those additions
  """
  def add(a, b), do: elementwise(a, b, Kernel, :+)

  @doc """
  Multiplies each element in the two lists pairwise, meaning, the first element in a
  and the first element in b are multiplied together. Then the second element in each
  are and so on. Returns a list of the result of those multiplications
  """
  def multiply(a, b), do: elementwise(a, b, Kernel, :*)

  @doc """
  Subtracts each element in the two lists pairwise, meaning, the first element in a
  and the first element in b are subtracted together. Then the second element in each
  are and so on. Returns a list of the result of those subtractions
  """
  def subtract(a, b), do: elementwise(a, b, Kernel, :-)

  @doc """
  Divides each element in the two lists pairwise, meaning, the first element in a
  and the first element in b are divided. Then the second element in each
  are and so on. Returns a list of the result of those divisions
  """
  def divide(a, b), do: elementwise(a, b, Kernel, :/)

  @doc """
  Calls the given fun with each element in the two lists pairwise, meaning, fun is first called with
  the first element in a and the first element in b. Then it is called with the second element in each
  list, then the third and so on.
  """
  def apply(a, b, fun), do: elementwise(a, b, fun)

  @doc """
  Calls the given mod / fun with each element in the two lists pairwise, meaning, the mod / fun is
  first called with the first element in a and the first element in b. Then it is called with the
  second element in each list, then the third and so on.
  """
  def apply(a, b, mod, fun), do: elementwise(a, b, mod, fun)

  @doc """
  Calls the given mod / fun with each element in the two lists pairwise, meaning, the mod / fun is
  first called with the first element in a as the first argument to the mod / fun, and the first element
  in b as the second argument to the mod / fun. Then it is called with the second element in each list
  as arguments 1 and 2, and so on down the lists.

  The extra args are appended to the end of the argument list.
  """
  def apply(a, b, mod, fun, args), do: elementwise(a, b, mod, fun, args)

  defp elementwise(a, b, fun) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    a
    |> Enum.with_index()
    |> Enum.map(fn {item, index} ->
      fun.(item, Enum.at(b, index))
    end)
  end

  defp elementwise(a, b, mod, fun, args) do
    if length(a) !== length(b) do
      raise(Zip.CollectionsOfDifferentSizes, {a, b})
    end

    a
    |> Enum.with_index()
    |> Enum.map(fn {item, index} ->
      Kernel.apply(mod, fun, [item, Enum.at(b, index)] ++ args)
    end)
  end

  defp elementwise(a, b, mod, fun) do
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
