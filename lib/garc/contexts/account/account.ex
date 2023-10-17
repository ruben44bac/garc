defmodule Garc.Contexts.Account.Account do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Account.Subscription

  @required_fields [
    :name,
    :first_surname,
    :email,
    :phone
  ]
  @optional_fields [
    :second_surname,
    :last_paymnet,
    :next_paymnet
  ]

  schema "accounts" do
    field :name, :string
    field :first_surname, :string
    field :second_surname, :string
    field :email, :string
    field :phone, :string
    field :last_paymnet, :naive_datetime
    field :next_paymnet, :naive_datetime

    belongs_to :subscription, Subscription,
      foreign_key: :subscription_id,
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
