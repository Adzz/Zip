# Zip 🤐

A simple library to enable elementwise operations on collections. Use it like this:

```elixir
Zip.apply([5], [2], fn x, y -> x + y end)  # => [7]
Zip.apply([5], [2], Integer, :mod)  # => [1]
Zip.apply([[1, 2], [3, 4]], [7, 7], Enum, :intersperse) #=> [[1, 7, 2], [3, 7, 4]]
Zip.apply([[1, 2, 3, 4], [1, 2, 3, 4]], [2, 3], Enum, :map_every, [fn x -> x * 10 end])  # => [[10, 2, 30, 4], [10, 2, 3, 40]]
```

Zip has been implemented as a protocol meaning you can define your own implementations for a given data type. We provide a map implementation, a list implementation and a stream implementation for now.



## Installation

[Available in Hex](https://hex.pm/docs/publish), install by adding `zip` to your list of dependencies in `mix.exs`:

```elixir
def deps, do: [{:zip, "~> 1.0.0"}]
```

Docs can be found here: [https://hexdocs.pm/zip](https://hexdocs.pm/zip) 👩‍⚕️ 👩‍⚕️
