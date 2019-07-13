defmodule Zip.MixProject do
  use Mix.Project

  def project do
    [
      name: "zip",
      app: :zip,
      licenses: "",
      description: description(),
      version: "0.1.1",
      elixir: "~> 1.8",
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/Adzz/Zip"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps, do: [{:ex_doc, "~> 0.19", only: :dev, runtime: false}]

  defp description() do
    """
    A library to help with doing pairwise or elementwise operations on collections.
    """
  end

  defp package() do
    [licenses: ["Apache 2.0"], links: %{"GitHub" => "https://github.com/Adzz/Zip"}]
  end
end
