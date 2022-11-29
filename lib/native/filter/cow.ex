defmodule Captcha.Native.Filter.Cow do
  @moduledoc "Cow Filter"
  alias Captcha.Native.Geometry
  defstruct min_radius: 10, max_radius: 20, n: 3, allow_duplicates: true, geometry: nil

  @type t :: %__MODULE__{
          min_radius: non_neg_integer,
          max_radius: non_neg_integer,
          n: non_neg_integer,
          allow_duplicates: bool,
          geometry: nil | Geometry.t()
        }
end
