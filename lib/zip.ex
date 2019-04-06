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

  @doc """
  Adds each element in the two collections pairwise, meaning, the first element in `a`
  and the first element in `b` are added together. Then the second element in each
  are, and so on. Returns the result of those additions. You can implement this for any collection
  that has some sense of order. Below is an example of what the function returns if we were to
  implement it for lists:

  ### Examples

      iex> Zip.add([1], [1])
      [2]

      iex> Zip.add([2,3,4,5,6], [1,2,3,4,5])
      [3, 5, 7, 9, 11]
  """
  def add(a, b)

  @doc """
  Multiplies each element in the two collections pairwise, meaning, the first element in `a`
  and the first element in `b` are multiplied together. Then the second element in each
  are and so on. Returns a list of the result of those multiplications

  Below is an example of what the function returns if we were to
  implement it for lists:

  ### Examples

      iex> Zip.multiply([1], [1])
      [1]

      iex> Zip.multiply([10,5,4], [2,2,2])
      [20, 10, 8]
  """
  def multiply(a, b)

  @doc """
  Subtracts each element in the two collections pairwise, meaning, the first element in `a`
  gets the first element in `b` subtracted from it. Then the second element in `a` gets the second
  element from `b` subtracted from it, and so on. Returns a collection of the result of those subtractions.

  Below is an example of what the function returns if we were to implement it for lists:

  ### Examples

      iex> Zip.subtract([1], [1])
      [0]

      iex> Zip.subtract([10,5,4], [2,2,2])
      [8, 3, 2]
  """
  def subtract(a, b)

  @doc """
  Divides each element in the two collections pairwise, meaning, the first element in `a`
  is divided by the first element in `b`. Then the second element in `a` is divided by the second
  element in `b`, and so on. Returns a collection of the result of those divisions

  Below is an example of what the function returns if we were to implement it for lists:

  ### Examples

      iex> Zip.divide([1], [1])
      [1.0]

      iex> Zip.divide([10,5,4], [2,2,2])
      [5.0, 2.5, 2.0]
  """
  def divide(a, b)

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
