defmodule Garc.Contexts.Product.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Account.Account

  @required_fields [
    :name,
    :account_id
  ]
  @optional_fields [
    :description,
    :is_active,
    :category_id
  ]

  schema "categories" do
    field :name, :string
    field :description, :string
    field :is_active, :boolean, default: true

    belongs_to :account, Account,
      foreign_key: :account_id,
      references: :id,
      type: :integer

    belongs_to :category, __MODULE__,
      foreign_key: :category_id,
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
