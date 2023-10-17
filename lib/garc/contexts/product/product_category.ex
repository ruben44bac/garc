defmodule Garc.Contexts.Product.ProductCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias Garc.Contexts.Product.Product
  alias Garc.Contexts.Product.Category

  @required_fields [
    :type,
    :category_id,
    :product_id
  ]
  @optional_fields []

  schema "product_categories" do
    field :type, :integer

    belongs_to :category, Category,
      foreign_key: :category_id,
      references: :id,
      type: :integer

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
