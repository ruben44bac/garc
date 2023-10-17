defmodule Garc.Repo.Migrations.CreateProductCategories do
  use Ecto.Migration

  def change do
    create table("product_categories") do
      add(:type, :integer, null: false, default: 1)

      add(:category_id, references(:categories))
      add(:product_id, references(:products))

      timestamps()
    end
  end
end
