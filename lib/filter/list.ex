defimpl Filter, for: List do
  # We don't know if the filtering fun needs to pass
  # the operation along or not. It would need to if the operation
  # has one or more "free variables". That is, if the operation we are trying to
  # perform requires two or more variables. An example is LessThan needing 2 numbers
  # to compare.
  # The only way to tell is if the operation has a value key. This key could
  # become the way that an operation adds any free variables (e.g. if it needs
  # two free variables, values becomes an array).

  # But what about for operations that span actions,that can sometimes have a free
  # variable sometimes not...
  # For example, Add, when zipping gets two variables from the thing being zipped.
  # But when maping you need a free variable. In that case the pattern is to have
  # a non null thing for value? But what if nil is a legit value? Should we use a list
  # then? Or will he have to cater for list when 2 or more extra args needed.
  # not a list all the other time?
  # What if someone puts a value there? Then do we include it in to the operation?
  # Will it always make sense to do so? Or are Zip.add and Map.add just different
  # types of things?

  # They are in that the semantics of where they get the variables from is way different...
  # for one case (map) it makes sense that there will always be one value in the operation.
  # For zip it doesn't.

  # so can we abstract only what is similar, re-use the same operations but create different
  # operations?
  # Zip.apply([1], [2], %Zip.Add{})
  # Fmap.apply([1], [2], %Add{})
  # The downside here is the user has to know which "Add" to use. Explosion of code also, as there
  # are now N many "Add" protocols that we may have to implement... But 0 chance of a certain class
  # of error... which class? The passing the wrong kind of operation to an Action error
  # This becomes impossible:
  # Zip.apply([1], [2], %Add{value: 10})
  # As does this:
  # Fmap.apply([1], [2], %Zip.Add{})
  # And we can even then enforce the value when we know we need it so this is not possible:
  # Fmap.apply([1], %Add{})
  def apply(a, operation = %{filter: filter, value: _}) do
    Enum.filter(a, fn x -> filter.(x, operation) end)
  end

  def apply(a, %{filter: filter}) do
    Enum.filter(a, fn x -> filter.(x) end)
  end

  def apply(a, fun) when is_function(fun) do
    Enum.filter(a, fun)
  end
end
