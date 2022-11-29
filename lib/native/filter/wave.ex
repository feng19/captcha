defmodule Captcha.Native.Filter.Wave do
  @moduledoc "Wave Filter"
  @enforce_keys [:f, :amp]
  defstruct f: nil, amp: nil, direction: :horizontal
  @type t :: %__MODULE__{f: float, amp: float, direction: :horizontal | :vertical}
end
