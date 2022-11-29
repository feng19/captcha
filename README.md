# Captcha

[![Module Version](https://img.shields.io/hexpm/v/captcha_nif.svg)](https://hex.pm/packages/captcha_nif)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/captcha_nif/)
[![Total Download](https://img.shields.io/hexpm/dt/captcha_nif.svg)](https://hex.pm/packages/captcha_nif)
[![License](https://img.shields.io/hexpm/l/captcha.svg)](https://github.com/feng19/captcha/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/feng19/captcha.svg)](https://github.com/feng19/captcha/commits/master)

**NIF bindings for the [captcha](https://github.com/daniel-e/captcha) Rust implementation**

## Installation

The package can be installed by adding `captcha` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:captcha, "~> 0.1.0", hex: :captcha_nif}
  ]
end
```

Documentation can be found at <https://hexdocs.pm/captcha_nif>.

## Usage

Crate to generate CAPTCHAs.

example:

```elixir
{chars, png} = Captcha.easy()
File.write!("captcha.png", png)
chars
```

or create by options:

```elixir
{chars, png} = Captcha.easy(set_chars: "1234567890")
```
