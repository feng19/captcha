# NIF for Elixir.Captcha.Native

## To build the NIF module:

- Your NIF will now build along with your project.

## To load the NIF:

```elixir
defmodule Captcha.Native do
  use Rustler, otp_app: :captcha, crate: "captcha_nif"

  # When your NIF is loaded, it will override this function.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)
end
```

## Examples

[This](https://github.com/rusterlium/NifIo) is a complete example of a NIF written in Rust.
