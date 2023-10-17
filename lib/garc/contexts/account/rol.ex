defmodule Garc.Contexts.Account.Rol do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Account.Account

  @required_fields [
    :name,
    :account_id
  ]
  @optional_fields []

  schema "roles" do
    field :name, :string

    belongs_to :account, Account,
      foreign_key: :account_id,
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
