defmodule Garc.Contexts.Product.ProductTax do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Product.Product

  @required_fields [
    :amount,
    :type,
    :product_id
  ]
  @optional_fields []

  schema "product_taxes" do
    field :amount, :decimal

    field :type, Ecto.Enum,
      values: [:iva, :isr],
      default: :iva

    belongs_to :product, Product,
      foreign_key: :product_id,
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
