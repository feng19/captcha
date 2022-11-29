defmodule Captcha.Native.Geometry do
  @moduledoc "Geometry"
  @enforce_keys [:left, :right, :top, :bottom]
  defstruct [:left, :right, :top, :bottom]

  @type t :: %__MODULE__{
          left: non_neg_integer,
          right: non_neg_integer,
          top: non_neg_integer,
          bottom: non_neg_integer
        }
end
