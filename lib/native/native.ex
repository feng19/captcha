defmodule Captcha.Native do
  @moduledoc """
  NIF bindings for the [captcha](https://github.com/daniel-e/captcha) Rust implementation
  """
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :captcha,
    crate: "captcha_nif",
    base_url: "https://github.com/feng19/captcha/releases/download/v#{version}",
    targets: ~w(
      aarch64-apple-darwin
      aarch64-unknown-linux-gnu
      aarch64-unknown-linux-musl
      x86_64-apple-darwin
      x86_64-pc-windows-gnu
      x86_64-pc-windows-msvc
      x86_64-unknown-linux-gnu
      x86_64-unknown-linux-musl
    ),
    version: version

  def create(_options), do: error()
  def easy(_options \\ nil), do: error()
  def medium(_options \\ nil), do: error()
  def hard(_options \\ nil), do: error()
  def create_by_name(_captcha_name, _difficulty \\ :easy, _options \\ nil), do: error()
  def supported_chars, do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
