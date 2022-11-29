defmodule Captcha.Native do
  @moduledoc """
  NIF bindings for the [captcha](https://github.com/daniel-e/captcha) Rust implementation
  """
  use Rustler, otp_app: :captcha, crate: "captcha_nif"

  def create(_options), do: error()
  def easy(_options \\ nil), do: error()
  def medium(_options \\ nil), do: error()
  def hard(_options \\ nil), do: error()
  def create_by_name(_captcha_name, _difficulty \\ :easy, _options \\ nil), do: error()
  def supported_chars, do: error()

  defp error, do: :erlang.nif_error(:nif_not_loaded)
end
