# Streams are functions...
# This feels weird but is probs fine coz we can't pass a non module to
# Zip.apply anyway, so the only function that should work is a stream i think.
defimpl Zip, for: [Function] do
  def apply(a, b, %{zip: zip}) do
    Stream.zip(a, b) |> Stream.map(fn {x, y} -> zip.(x, y) end)
  end

  # falls-back to calling the function if it's not type we defined
  def apply(a, b, fun) when is_function(fun) do
    Stream.zip(a, b) |> Stream.map(fn {x, y} -> fun.(x, y) end)
  end
end
