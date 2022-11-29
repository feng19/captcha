defmodule Captcha.Native.Filter.Dots do
  @moduledoc "Dots Filter"
  @enforce_keys [:n]
  defstruct n: nil, min_radius: 5, max_radius: 10

  @type t :: %__MODULE__{
          n: non_neg_integer,
          min_radius: non_neg_integer,
          max_radius: non_neg_integer
        }
end
