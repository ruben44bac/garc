defmodule Garc.Contexts.Core.Action do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Core.Module

  @required_fields [
    :name,
    :key,
    :module_id
  ]
  @optional_fields []

  schema "actions" do
    field :name, :string
    field :key, :string

    belongs_to :module, Module,
      foreign_key: :module_id,
      references: :id,
      type: :integer

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
