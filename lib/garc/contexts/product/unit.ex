defmodule Garc.Contexts.Product.Unit do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [
    :name,
    :type
  ]
  @optional_fields []

  schema "units" do
    field :name, :string
    field :type, :integer

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
