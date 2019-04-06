# Zip 🤐

A simple library to enable elementwise operations on collections. Use it like this:

```elixir
Zip.add([1], [1])      # => [2]
Zip.multiply([1], [1]) # => [1]
Zip.subtract([1], [1]) # => [0]
Zip.divide([10], [2])  # => [5]
Zip.apply([5], [2], Integer, :mod)  # => [1]
Zip.apply([[1, 2], [3, 4]], [7, 7], Enum, :intersperse) #=> [[1, 7, 2], [3, 7, 4]]
Zip.apply([[1, 2, 3, 4], [1, 2, 3, 4]], [2, 3], Enum, :map_every, [fn x -> x * 10 end])  # => [[10, 2, 30, 4], [10, 2, 3, 40]]
```

### Roadmap

1. Enable arbitrary operations - either user defined or callbacks?
2. Enable a wider range of elements in the list - support decimal, e.g.
3. Probably part of 2 - ensure elementwise pairs are of the same type. Do we need to? As long as the function accepts them fine
4. Stream dat data
5. Mad speed gainz?
6. Zip nth? Or interleave / intersperse type functions.

## Installation

[Available in Hex](https://hex.pm/docs/publish), install by adding `zip` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:zip, "~> 0.1.0"}
  ]
end
```

Docs can be found here: [https://hexdocs.pm/zip](https://hexdocs.pm/zip) 👩‍⚕️ 👩‍⚕️
