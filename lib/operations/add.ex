# defmodule Add do
#   defstruct calculate: &__MODULE__.calculate/2
#   @behaviour Operation

#   @impl true
#   def calculate(a, b) when is_integer(a) and is_integer(b), do: a + b
#   @impl true
#   def calculate(a = %Decimal{}, b = %Decimal{}), do: Decimal.add(a, b)
# end

# Alternative with protocols. Using a behaviour allows us to ensure that
# the module implements a function, which we can call in all of the
# implementations of the Zip protocol.But using protocols means we get extension, meaning
# we can define some implementations of the functions, and everyone else can implement their own

defprotocol Add do
  defstruct calculate: &__MODULE__.calculate/2
  def calculate(a, b)
end

defimpl Add, for: Integer do
  def calculate(a, b) when is_integer(b), do: a + b
end

defimpl Add, for: Decimal do
  def calculate(decimal, decimal_2 = %Decimal{}), do: Decimal.add(decimal, decimal_2)
end

# For anything that implements the Zip interface, we can automatically
# implement any operation, as Zip.apply and passing the operation in
# as the last arg.

# That ensures we maintain the structure of whatever we pass in. But is that correct?
# Only if you want to operate on the values in the container. If you want to operate on
# The container itself, then we can't do this. E.g. say you wanted to do this:
# Zip.apply([[1]], [[2]], %Add{})
# The recursive version does this [[3]], but should it really do this:
# [[1, 2]]
# Suppose it depends how we want to define Add, and do we want to differ it from
# concatenate.

# Do we want to be able to operate on containers. If so, the recursion wont work?

# So when do we want to preserve structure? When `map`ping.
# How do we make this paradigm higher order?
# Well we just define it the same way we define the Zip protocol. Can we define a Map
# like Zip, and re-use all the operations?

defimpl Add, for: List do
  def calculate(list_1, list_2) when is_list(list_2), do: Zip.apply(list_1, list_2, %Add{})
end

defimpl Add, for: Map do
  def calculate(map, map_2) when is_map(map_2), do: Zip.apply(map, map_2, %Add{})
end

defimpl Add, for: PID do
  def calculate(pid, pid_2) when is_pid(pid_2) do
    Zip.apply(pid, pid_2, %Add{})
  end
end

# Streams
defimpl Add, for: Function do
  def calculate(stream, stream_2) when is_function(stream_2),
    do: Zip.apply(stream, stream_2, %Add{})
end
