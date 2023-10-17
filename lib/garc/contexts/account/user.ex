defmodule Garc.Contexts.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Account.Rol
  alias Garc.Contexts.Account.Account

  @required_fields [
    :email,
    :name,
    :first_surname,
    :account_id,
    :rol_id
  ]
  @optional_fields [
    :phone,
    :password_hash,
    :second_surname,
    :avatar,
    :is_owner,
    :is_active
  ]

  schema "users" do
    field(:email, :string)
    field(:phone, :string)
    field(:password_hash, :string)
    field(:name, :string)
    field(:first_surname, :string)
    field(:second_surname, :string)
    field(:avatar, :string)

    field(:is_active, :boolean)
    field(:is_owner, :boolean)

    belongs_to(:account, Account,
      foreign_key: :account_id,
      references: :id,
      type: :integer
    )

    belongs_to(:rol, Rol,
      foreign_key: :rol_id,
      references: :id,
      type: :integer
    )

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
