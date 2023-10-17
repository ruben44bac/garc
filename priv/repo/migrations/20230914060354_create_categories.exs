defmodule Garc.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table("categories") do
      add :name, :string, size: 70, null: false
      add :description, :string
      add :is_active, :boolean, default: true, null: false

      add :account_id, references(:accounts)
      add :category_id, references(:categories)

      timestamps()
    end
  end
end
