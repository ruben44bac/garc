defmodule Garc.Contexts.Product.ProductCategoryManager do
  use Garc.Contexts.BaseManager,
    schema: Garc.Contexts.Product.ProductCategory,
    repo: Garc.Repo,
    only: [:create, :delete]

  alias Garc.Contexts.Product.ProductCategory

  alias Garc.Repo

  def clean_product(product_id) do
    ProductCategory
    |> where([pc], pc.product_id == ^product_id)
    |> Repo.delete_all()
  end
end
