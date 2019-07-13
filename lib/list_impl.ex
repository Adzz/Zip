defimpl Zip, for: List do
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
    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> fun.(a, b) end)
  end

  defp elementwise(a, b, mod, fun) do
    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> Kernel.apply(mod, fun, [a, b]) end)
  end

  defp elementwise(a, b, mod, fun, args) when is_list(args) do
    Enum.zip(a, b)
    |> Enum.map(fn {a, b} -> Kernel.apply(mod, fun, [a, b] ++ args) end)
  end
end
