defprotocol Zip do
  @doc """
  Calls the given fun with each element in the two collections pairwise, meaning, fun is first called with
  the first element in `a` as the first argument to `fun` and the first element in `b` as the second
  argument to `fun`. Then it is called with the second element in each list as the first and second
  arguments to `fun` respectively, and so on.

  Below is an example of what the function returns if we were to implement it for lists:

  ### Examples

      iex> Zip.apply([5], [2], fn a, b -> a + b end)
      [7]

      iex> Zip.apply([5], [2], fn a, b -> a * b end)
      [10]
  """
  def apply(a, b, fun)

  @doc """
  Calls the given mod / fun with each element in the two collections pairwise, meaning, the mod / fun is
  first called with the first element in `a` as the first argument to the function described by the
  `mod` / `fun`, and the first element in `b` as the second argument to the function described by
  `mod` / `fun`. Then it is called with the second element in each list as the first and second
  arguments respectively and so on down the collection.

  Below is an example of what the function returns if we were to implement it for lists:

  ### Examples

      iex> Zip.apply([[1, 2], [3, 4]], [7, 7], Enum, :intersperse)
      [[1, 7, 2], [3, 7, 4]]

      iex> Zip.apply([5], [2], Kernel, :+)
      [7]
  """
  def apply(a, b, mod, fun)

  @doc """
  Calls the given `mod` / `fun` / `args` with each element in the two collections pairwise, meaning,
  the `mod` / `fun` / `args` is first called with the first element in `a` as the first argument to
  the function described by the `mod` / `fun` / `args`, and the first element in `b` as the second
  argument to the function described by the `mod` / `fun` / `args`, and with the `args` added as
  the rest of the args for the `mod` / `fun`. Then it is called with the second element in each list
  as the first and second arguments respectively and so on down the collection.

  Below is an example of what the function returns if we were to implement it for lists:

  ### Examples

      iex> Zip.apply([[1, 2, 3, 4], [1, 2, 3, 4]], [2, 3], Enum, :map_every, [fn x -> x * 10 end])
      [[10, 2, 30, 4], [10, 2, 3, 40]]

      iex> Zip.apply([["X","X","X","X"], ["O", "O", "O", "O"]], [1, 2], Enum, :map_every, [fn _ -> "A"  end])
      [["A", "A", "A", "A"], ["A", "O", "A", "O"]]
  """
  def apply(a, b, mod, fun, args)
end
