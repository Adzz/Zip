# Streams are functions...
# This feels weird but is probs fine coz we can't pass a non module to
# Zip.apply anyway, so the only function that should work is a stream i think.
defimpl Zip, for: [Function] do
  def apply(a, b, fun) do
    Stream.zip(a, b) |> Stream.map(fn {x, y} -> fun.(x, y) end)
  end

  def apply(a, b, mod, fun) when is_function(fun) do
    Stream.zip(a, b) |> Stream.map(fn {x, y} -> Kernel.apply(mod, fun, [a, b]) end)
  end

  def apply(a, b, mod, fun, args) do
    Stream.zip(a, b) |> Stream.map(fn {x, y} -> Kernel.apply(mod, fun, [a, b] ++ args) end)
  end
end
