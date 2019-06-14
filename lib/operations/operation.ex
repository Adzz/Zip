defmodule Operation do
  @moduledoc """
  Allows us to rely on being able to call calculate on any operation that one might implement. This
  means when we are defining an implementation of the Zip protocol, we can know it's okay to call
  calculate on that operation.
  """
  @callback calculate(any(), any()) :: any()
end
