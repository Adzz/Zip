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

# Would this be better anyway? Easily define operations to extend
# existing protocols. Allow for filter, fmap, etc etc..
# Define.operation_for(Zip, Add)
