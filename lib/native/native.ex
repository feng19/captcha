defmodule Captcha.Native do
  @moduledoc """
  NIF bindings for the [captcha](https://github.com/daniel-e/captcha) Rust implementation
  """
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :captcha,
    crate: "captcha_nif",
    base_url: "https://github.com/feng19/captcha/releases/download/v#{version}",
    targets:
      Enum.uniq(["aarch64-unknown-linux-musl" | RustlerPrecompiled.Config.default_targets()]),
    version: version

  def create(_options), do: error()
  def easy(_options \\ nil), do: error()
  def medium(_options \\ nil), do: error()
  def hard(_options \\ nil), do: error()
  def create_by_name(_captcha_name, _difficulty \\ :easy, _options \\ nil), do: error()
  def supported_chars, do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
