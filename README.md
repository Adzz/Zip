# Zip 🤐

Okay. If you made it to here, you are curious, and I applaud it. This branch is a bit of an experiment but it works to allow you to fully define for yourselves each of the ways that a zipped thing may vary.

The options are:

1. The type of collection you are using (list, stream, whatever)
2. The type of the elements in the list - (int, string, decimal)
3. The operations on those types (add, subtract, divide, split....)

Let me show you some examples:

```elixir
Zip.apply([1], [1], Add) # => [2]
Zip.apply([1], [1], Sutract) # => [0]
Zip.apply([8, 6], [2, 2], Divide) # => [4, 3]
```

Now more interestingly you can define your own operations like so:

```elixir
defprotocol Join do
  def calculate(x, y)
end
```

Then implement it for a type that might make up the element in a list we are zipping:

```elixir
defimpl Join, for: String do
  def string(x, y), do: x <> y
end
```

Then you could use it like this:

```elixir
Zip.apply(["test"], ["ing"], Join) # => ["testing"]
```

So you can:

1. Implement the Zip protocol for your own collections (like streams)
2. Define your own operation protocols
3. Implement them for any type

What's interesting about this approach is that if you define a new implementation for the Zip protocol, you get for free all of the operations you previously defined for that collection.

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
