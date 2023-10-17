defmodule Chronos do
  @moduledoc """
  Chronos module
  """
  alias __MODULE__, as: Chronos

  use Agent

  @mty_tz "America/Monterrey"
  @time_format "%Y-%m-%dT%H:%M:%S"

  @spec start_link(list()) :: {:error, any()} | {:ok, pid()}
  def start_link([]) do
    Agent.start_link(
      fn ->
        %{is_frozen: false, frozen_value: nil}
      end,
      name: Chronos
    )
  end

  @spec now() :: DateTime.t()
  def now do
    get_timestamp()
    |> Timex.from_unix()
    |> shift_localtime
  catch
    :exit, {:noproc, _} ->
      Timex.now(@mty_tz)
      |> shift_localtime
  end

  @spec get_timestamp() :: integer()
  def get_timestamp do
    state = Agent.get(Chronos, fn state -> state end)

    if state[:is_frozen] do
      state[:frozen_value]
    else
      :os.system_time(:second)
    end
  end

  @spec freeze() :: atom()
  def freeze do
    freeze(:os.system_time(:second))
  end

  @spec freeze(integer()) :: atom()
  def freeze(timestamp) do
    Agent.update(Chronos, fn _state ->
      %{is_frozen: true, frozen_value: timestamp}
    end)
  end

  @spec unfreeze() :: atom()
  def unfreeze do
    Agent.update(Chronos, fn _state ->
      %{is_frozen: false, frozen_value: nil}
    end)
  end

  @spec get_monthly_interval(map()) :: map()
  def get_monthly_interval(company) do
    if is_nil(company.last_charge_at) do
      today = Timex.now(@mty_tz)
      created = company.created_at |> Timex.to_date()
      year_diff = today.year - created.year
      month_diff = today.month - created.month
      anniversary = Timex.shift(created, years: year_diff, months: month_diff)

      if Timex.compare(anniversary, today) == 1 do
        {Timex.to_naive_datetime(Timex.shift(anniversary, months: -1)),
         Timex.to_naive_datetime(anniversary)}
      else
        {Timex.to_naive_datetime(anniversary),
         Timex.to_naive_datetime(Timex.shift(anniversary, months: 1))}
      end
    else
      last_charge_at = company.last_charge_at |> Timex.to_date()

      {Timex.to_naive_datetime(last_charge_at),
       Timex.to_naive_datetime(Timex.shift(last_charge_at, months: 1))}
    end
  end

  @spec new(NaiveDateTime.t()) :: DateTime.t()
  def new(naive_datetime) do
    naive_datetime
    |> DateTime.from_naive!("Etc/UTC")
    |> DateTime.truncate(:second)
  end

  defp shift_localtime(date_time) do
    date_time
    |> Timex.format!(@time_format, :strftime)
    |> Timex.parse!(@time_format, :strftime)
    |> Timex.to_datetime()
  end
end
