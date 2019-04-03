defmodule Zip.CollectionsOfDifferentSizes do
  defexception [:message]

  @impl true
  def exception({a, b}) do
    msg = """
    You have tried to zip two things that are of different lengths: #{inspect(a)} and #{
      inspect(b)
    }
    """

    %__MODULE__{message: msg}
  end
end
