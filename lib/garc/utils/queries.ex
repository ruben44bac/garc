defmodule Garc.Utils.Queries do
  @moduledoc """
  Utilitary functions for Ecto queries
  """
  import Ecto.Query, warn: false

  @doc """
  Calls UNACCENT()
  """
  defmacro unaccent(column) do
    quote do
      fragment("UNACCENT(?)", unquote(column))
    end
  end

  @spec lower(any) :: {:fragment, [{:closing, [...]} | {:column, 7}, ...], [...]}
  @doc """
  Calls LOWER()
  """
  defmacro lower(column) do
    quote do
      fragment("LOWER(?)", unquote(column))
    end
  end

  @doc """
  Casts the column using ::
  """
  defmacro cast(column, data_type) do
    quote do
      fragment(unquote("?::#{data_type}"), unquote(column))
    end
  end

  @doc """
  Predicate that checks if the value in `path` from `column` is in `array`.

  Use like json_path_in(a.json_field, ["a_field", "b_field"], ["A", "B", "C"])

  See the #>> operator.
  """
  defmacro json_path_in(column, path, array) do
    quote do
      fragment("? #>> ? = ANY(?)", unquote(column), unquote(path), unquote(array))
    end
  end

  @doc """
  Checks if some list item is in another one.

  Use like contains(thing.items, ["A", "B", "C"])

  See the && operator (https://www.postgresql.org/docs/12/functions-array.html#ARRAY-OPERATORS-TABLE).
  """
  defmacro contains(column, list) do
    quote do
      fragment("? && ?", unquote(column), unquote(list))
    end
  end

  @doc """
  The date_trunc function truncates a TIMESTAMP or an  INTERVAL value based on a specified date part e.g., hour, week, or month and returns the truncated timestamp or interval with a level of precision.
  """
  defmacro date_trunc(unit, column, timezone \\ "America/Monterrey") do
    quote do
      fragment(unquote("date_trunc(?, ?, ?)"), unquote(unit), unquote(column), unquote(timezone))
    end
  end

  defmacro same_month?(first_value, second_value) do
    quote do
      date_trunc("month", unquote(first_value)) == date_trunc("month", unquote(second_value))
    end
  end

  @doc """
  Adds dynamic nested filters in the query expression with a keywordlist

  return a `Ecto.Query.t()`

  params:
  - :and
  - `Keyword.t()`

  """
  @spec dynamic_nested_filter(:and, Keyword.t()) :: Ecto.Query.t()
  def dynamic_nested_filter(:and, keywordlist) do
    Enum.reduce(keywordlist, false, fn {k, v}, conditions ->
      if conditions == false do
        dynamic([q], field(q, ^k) == ^v)
      else
        dynamic([q], field(q, ^k) == ^v and ^conditions)
      end
    end)
  end
end
