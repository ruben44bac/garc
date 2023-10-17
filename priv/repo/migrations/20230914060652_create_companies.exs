defmodule Garc.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table("companies") do
      add :name, :string, size: 70, null: false
      add :description, :string
      add :is_active, :boolean, default: true, null: false

      add :account_id, references(:accounts)

      timestamps()
    end
  end
end
