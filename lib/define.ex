defmodule Define do
  defmacro operation(name) do
    quote do
      defprotocol unquote(name) do
        defstruct calculate: &__MODULE__.calculate/2
        def calculate(a, b)
      end
    end
  end
end
