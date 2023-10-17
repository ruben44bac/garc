defmodule Garc.Contexts.Product.ProductManager do
  use Garc.Contexts.BaseManager,
    schema: Garc.Contexts.Product.Product,
    repo: Garc.Repo,
    only: [:get!, :get_all, :create, :update, :preloads]
end
