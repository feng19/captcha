defmodule Captcha.MixProject do
  use Mix.Project

  @version "0.2.0"
  @source_url "https://github.com/feng19/captcha"

  def project do
    [
      app: :captcha,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:rustler_precompiled, "~> 0.4"},
      {:rustler, ">= 0.0.0", optional: true},
      {:ex_doc, ">= 0.0.0", only: [:docs, :dev], runtime: false}
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "master",
      formatters: ["html"],
      formatter_opts: [gfm: true]
    ]
  end

  defp package do
    [
      name: "captcha_nif",
      description: "NIF bindings for the captcha Rust implementation",
      files: ["lib", "native", "checksum-*.exs", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["feng19"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end
end
