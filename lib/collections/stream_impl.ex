# Streams are functions...
# This feels weird but is probs fine coz we can't pass a non module to
# Zip.apply anyway, so the only function that should work is a stream i think.
defimpl Zip, for: [Function] do
  def apply(a, b, operation) do
    Stream.zip(a, b)
    |> Stream.map(fn {x, y} ->
      operation.calculate(x, y)
    end)
  end
end
