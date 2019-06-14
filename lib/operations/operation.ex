defmodule Operation do
  @moduledoc """
  Allows us to rely on being able to call calculate on any operation that one might implement.
  """
  @callback calculate(any(), any()) :: any()
end
