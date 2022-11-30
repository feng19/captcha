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
    {:captcha, "~> 0.1", hex: :captcha_nif}
  ]
end
```

Documentation can be found at <https://hexdocs.pm/captcha_nif>.

Rust Documentation can be found at <https://docs.rs/captcha/latest/captcha>.

## Usage

Crate to generate CAPTCHAs.

Easy example:

```elixir
iex> {chars, png} = Captcha.easy()
{"SnZw8", <<...>>}
iex> File.write!("captcha.png", png)
:ok
```

Or create by custom chars:

```elixir
iex> Captcha.easy(set_color: %{r: 0, g: 116, b: 204})
{"SnZw8", <<...>>}
```

Create by options:

```elixir
iex> Captcha.create(
...>   set_chars: "1234567890abcdefgABCDEFG",
...>   add_chars: 6,
...>   set_color: %{r: 0, g: 116, b: 204},
...>   view: %{w: 220, h: 120},
...>   filters: [filter, ...]
...> )
{"SnZw8", <<...>>}
```

More use case can see: [test/captcha_test.exs](test/captcha_test.exs) or [rust docs](https://docs.rs/captcha/latest/captcha/). 