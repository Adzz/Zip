# Zip 🤐

A simple library to enable elementwise operations on collections. Use it like this:

```elixir
Zip.add([1], [1])      # => [2]
Zip.multiply([1], [1]) # => [1]
Zip.subtract([1], [1]) # => [0]
```

### Roadmap

1. Enable arbitrary operations - either user defined or callbacks?
2. Enable a wider range of elements in the list - support decimal, e.g.
3. Probably part of 2 - ensure elementwise pairs are of the same type
4. Mad speed gainz?

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
