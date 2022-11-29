defmodule Captcha.Native.Filter.Grid do
  @moduledoc "Grid Filter"
  @enforce_keys [:x_gap, :y_gap]
  defstruct x_gap: nil, y_gap: nil
  @type t :: %__MODULE__{x_gap: non_neg_integer, y_gap: non_neg_integer}
end
