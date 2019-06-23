# Zip 🤐

Okay. If you made it to here, you are curious, and I applaud it. This branch is a bit of an experiment but it works to allow you to fully define for yourselves each of the ways that a zipped thing may vary.

The options are:

1. The type of collection you are using (list, stream, map)
2. The type of the elements in the list - (int, string, decimal)
3. The operations on those types (add, subtract, divide, split....)

Let me show you some examples:

```elixir
Zip.apply([1], [1], %Add{}) # => [2]
Zip.apply([1], [1], %Subtract{}) # => [0]
Zip.apply([8, 6], [2, 2], %Divide{}) # => [4, 3]
```

What's interesting is this is implemented using protocols, meaning it is extensible in every direction. So what are the directions? You can:

1. Implement the Zip protocol for your own collections (like streams, maps, lists)
2. Define your own operations (like add, join, split)
3. Implement them for any type

## Defining your own implementations

Let's look at a full example. Imagine you implement an RGB data type to represent colours:

```elixir
defmodule RGB do
  defstruct [:red, :green, :blue]
end

red = %RGB{red: 255, green: 0, blue: 0}
blue = %RGB{red: 0, green: 0, blue: 255}
```

Now we want to implement the Zip protocol for that datatype, so we can do things like add them together:

```elixir
defimpl Zip, for: RGB do
  def apply(left, right, %{calculate: calculate}) do
    %RGB{
      red: calculate.(left.red, right.red),
      green: calculate.(left.green, right.green),
      blue: calculate.(left.blue, right.blue)
    }
  end
end
```

Now because we know all of the values will be integers, we can create an operation protocol like `Add` and implement it for integers. An operation protocol should always have a calculate function, and should also define a struct with a calculate key which points to that function. This gives us something to rely on when we implement the Zip protocol - namely that the last arg will be a struct that has a calculate key which will point to the function we want.

```elixir
defprotocol Add do
  defstruct calculate: &__MODULE__.calculate/2
  def calculate(a, b)
end

# Now we can implement it:
defimpl Add, for: Integer do
  def calculate(a, b), do: a + b
end

# And use it:
red = %RGB{red: 255, green: 0, blue: 0}
blue = %RGB{red: 0, green: 0, blue: 255}
Zip.apply(red, blue, %Add{}) #=> %RGB{red: 255, green: 0, blue: 255}

# If we decided to use Decimals instead of integers as RGB values, all we would need to make it work
# is to implement add for the Decimal type:
defimpl Add, for: Decimal do
  def calculate(a, b), do: Decimal.add(a, b)
end

# Now this works too
red = %RGB{red: Decimal.new(255), green: Decimal.new(0), blue: Decimal.new(0)}
blue = %RGB{red: Decimal.new(0), green: Decimal.new(0), blue: Decimal.new(255)}
Zip.apply(red, blue, %Add{}) #=> %RGB{red: Decimal.new(255), green: Decimal.new(0), blue: Decimal.new(255)}
```

What's interesting about this approach is that if you define a new implementation for the Zip protocol, you get for free all of the operations you previously defined. So now we already have `Add` implemented, if we wanted to implement Zip for a new datatype, we could do that like so:

```elixir
defimpl Zip, for: List do
  def apply(a, b, %{calculate: calculate}) do
    Enum.zip(a, b) |> Enum.map(fn {a, b} -> calculate.(a, b) end)
  end
end
```

and for free any `List` elements can be `Add`ed together.

## Available Operations

To see all of the provided operations check out the `lib/operations`. To see the provided Zip implementations look in `lib/collections`

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

<!-- Rando thoughts:
  this is 3 levels deep. Am I making a type system? Would 4 levels make dependant types?
  Also for all of our operations, we could create one struct and use that for the whole of the program
  I wonder if that would be better / worse for performance / clarity
-->
