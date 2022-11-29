defmodule Captcha do
  @moduledoc """
  Crate to generate CAPTCHAs.

  Easy example:

      iex> {chars, png} = Captcha.easy()
      {"SnZw8", <<...>>}
      iex> File.write!("captcha.png", png)
      :ok

  Or create by custom chars:

      iex> Captcha.easy(set_chars: "1234567890")
      {"SnZw8", <<...>>}

  Create by options:

      iex> Captcha.create(
      ...>   set_chars: "1234567890abcdefgABCDEFG",
      ...>   add_chars: 6,
      ...>   set_color: %{r: 0, g: 116, b: 204},
      ...>   view: %{w: 220, h: 120},
      ...>   filters: [filter, ...]
      ...> )
      {"SnZw8", <<...>>}
  """
  alias Captcha.Native
  alias Captcha.Native.Filter.{Cow, Dots, Grid, Noise, Wave}

  @type name :: :amelia | :lucy | :mila
  @type difficulty :: :easy | :medium | :hard
  @type filter :: Cow.t() | Dots.t() | Grid.t() | Noise.t() | Wave.t()
  @type options :: [
          set_chars: String.t(),
          add_chars: non_neg_integer,
          set_color: %{r: non_neg_integer, g: non_neg_integer, b: non_neg_integer},
          view: %{w: non_neg_integer, h: non_neg_integer},
          filters: [filter]
        ]

  @type return :: {String.t(), binary}

  @doc """
  example:

      iex> Captcha.create(
      ...>   set_chars: "1234567890abcdefgABCDEFG",
      ...>   add_chars: 6,
      ...>   set_color: %{r: 0, g: 116, b: 204},
      ...>   view: %{w: 220, h: 120},
      ...>   filters: [filter, ...]
      ...> )
      {"SnZw8", <<...>>}
  """
  @spec create(options) :: return
  defdelegate create(options), to: Native

  @doc """
  example:

      iex> Captcha.easy()
      {"SnZw8", <<...>>}
  """
  @spec easy(options) :: return
  defdelegate easy(options \\ nil), to: Native

  @doc """
  example:

      iex> Captcha.medium()
      {"SnZw8", <<...>>}
  """
  @spec medium(options) :: return
  defdelegate medium(options \\ nil), to: Native

  @doc """
  example:

      iex> Captcha.hard()
      {"SnZw8", <<...>>}
  """
  @spec hard(options) :: return
  defdelegate hard(options \\ nil), to: Native

  @doc """
  example:

      iex> Captcha.create_by_name(:lucy)
      {"SnZw8", <<...>>}
  """
  @spec create_by_name(name, difficulty, options) :: return
  defdelegate create_by_name(captcha_name, difficulty \\ :easy, options \\ nil), to: Native

  @doc """
  example:

      iex> Captcha.supported_chars()
      "123456789ABCDEFGHJKMNPQRSTUVWXYZabcdefghijklmnpqrstuvwxyz"
  """
  @spec supported_chars() :: binary
  defdelegate supported_chars, to: Native
end
