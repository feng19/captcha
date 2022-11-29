defmodule Captcha.Native.Filter.Noise do
  @moduledoc "Noise Filter"
  @enforce_keys [:prob]
  defstruct prob: nil
  @type t :: %__MODULE__{prob: float}
end
