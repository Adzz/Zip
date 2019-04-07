defmodule Operation do
  @callback calculate(any(), any()) :: any()
end
