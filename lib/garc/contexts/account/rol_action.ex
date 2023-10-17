defmodule Garc.Contexts.Account.RolAction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Account.Rol
  alias Garc.Contexts.Core.Action

  @required_fields [
    :name,
    :account_id
  ]
  @optional_fields []

  schema "roles_actions" do
    belongs_to :rol, Rol,
      foreign_key: :rol_id,
      references: :id,
      type: :integer

    belongs_to :action, Action,
      foreign_key: :action_id,
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
