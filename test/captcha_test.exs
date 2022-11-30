defmodule CaptchaTest do
  use ExUnit.Case
  alias Captcha.Native
  alias Captcha.Native.Geometry
  alias Captcha.Native.Filter.{Cow, Dots, Grid, Noise, Wave}

  @chars "1234567890abcdefgABCDEFG"

  test "gen funs" do
    assert {_chars, _png} = Native.easy()
    assert {_chars, _png} = Native.easy(add_chars: 1)
    assert {_chars, _png} = Native.medium()
    assert {_chars, _png} = Native.medium(add_chars: 1)
    assert {_chars, _png} = Native.hard()
    assert {_chars, _png} = Native.hard(add_chars: 1)
  end

  test "by_name" do
    names = [:amelia, :lucy, :mila]
    levels = [:easy, :medium, :hard]

    for name <- names, level <- levels do
      assert {_chars, _png} = Native.create_by_name(name, level)
    end

    for name <- names, level <- levels do
      assert {_chars, _png} = Native.create_by_name(name, level, set_chars: @chars)
    end
  end

  test "create" do
    assert {_chars, _png} = Native.create(set_chars: @chars)
    assert {_chars, _png} = Native.create(add_chars: 5)
    assert {_chars, _png} = Native.create(set_color: %{r: 0, g: 116, b: 204})
    assert {_chars, _png} = Native.create(add_chars: 5, view: %{w: 220, h: 120})

    filters = [
      %Noise{prob: 0.2},
      %Grid{x_gap: 8, y_gap: 8},
      %Wave{f: 2.0, amp: 10.0},
      %Dots{n: 15},
      %Cow{
        min_radius: 40,
        max_radius: 50,
        n: 1,
        geometry: %Geometry{left: 40, right: 150, top: 50, bottom: 70}
      }
    ]

    for filter <- filters do
      assert {_chars, _png} = Native.create(filters: [filter])
    end

    # all
    assert {_chars, _png} =
             Native.create(
               set_chars: @chars,
               add_chars: 5,
               set_color: %{r: 0, g: 116, b: 204},
               view: %{w: 220, h: 120},
               filters: filters
             )
  end
end
