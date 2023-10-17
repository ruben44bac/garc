defmodule Garc.Contexts.Product.ProductTaxManager do
  use Garc.Contexts.BaseManager,
    schema: Garc.Contexts.Product.ProductTax,
    repo: Garc.Repo,
    only: [:create, :delete]

  alias Garc.Contexts.Product.ProductTax

  alias Garc.Repo

  def clean_product(product_id) do
    ProductTax
    |> where([pt], pt.product_id == ^product_id)
    |> Repo.delete_all()
  end
end
