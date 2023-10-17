defmodule Garc.Contexts.Core.Module do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [
    :name,
    :key
  ]
  @optional_fields []

  schema "modules" do
    field :name, :string
    field :key, :string

    timestamps()
  end

  @doc false
  def changeset(data, attrs) do
    data
    |> cast(attrs, @required_fields)
    |> cast(attrs, @optional_fields)
    |> validate_required(@required_fields)
  end
end
