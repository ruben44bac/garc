defmodule Garc.Contexts.Product.UnitManager do
  use Garc.Contexts.BaseManager,
    schema: Garc.Contexts.Product.Unit,
    repo: Garc.Repo,
    only: [:get_all]
end
