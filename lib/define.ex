# doing this @ runtime is probably bad because of protocol consolidation?

defmodule Define do
  defmacro operation(name) do
    quote do
      defprotocol unquote(name) do
        defstruct zip: &__MODULE__.zip/2
        def zip(a, b)
      end
    end
  end
end
