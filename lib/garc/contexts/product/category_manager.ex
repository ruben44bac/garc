defmodule Garc.Contexts.Product.CategoryManager do
  use Garc.Contexts.BaseManager,
    schema: Garc.Contexts.Product.Category,
    repo: Garc.Repo,
    only: [:get_all, :create, :update]
end
