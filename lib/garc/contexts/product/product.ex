defmodule Garc.Contexts.Product.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Product.Category
  alias Garc.Contexts.Account.Account
  alias Garc.Contexts.Product.Unit
  alias Garc.Contexts.Product.ProductTax

  @required_fields [
    :name,
    :account_id
  ]
  @optional_fields [
    :key,
    :sku,
    :ean_code,
    :is_inventory,
    :is_sale,
    :is_buy,
    :sat_key,
    :quantity,
    :sat_unit,
    :is_negative_allow,
    :is_price_updated,
    :width,
    :height,
    :long,
    :weight,
    :unit_id,
    :unit_packing_id,
    :unit_packing_quantity
  ]

  schema "products" do
    field :name, :string
    field :key, :string
    field :sku, :string
    field :ean_code, :string
    field :is_inventory, :boolean, default: false
    field :is_sale, :boolean, default: false
    field :is_buy, :boolean, default: false
    field :sat_key, :string
    field :quantity, :integer
    field :unit_packing_quantity, :integer
    field :sat_unit, :string
    field :is_negative_allow, :boolean, default: false
    field :is_price_updated, :boolean, default: false
    field :width, :decimal
    field :height, :decimal
    field :long, :decimal
    field :weight, :decimal

    belongs_to :account, Account,
      foreign_key: :account_id,
      references: :id,
      type: :integer

    belongs_to :unit, Unit,
      foreign_key: :unit_id,
      references: :id,
      type: :integer

    belongs_to :unit_packing, Unit,
      foreign_key: :unit_packing_id,
      references: :id,
      type: :integer

    has_many :product_taxes, ProductTax,
      foreign_key: :product_id,
      references: :id,
      preload_order: [asc: :inserted_at]

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
