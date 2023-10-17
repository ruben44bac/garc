defmodule Garc.Repo.Migrations.CreateBranches do
  use Ecto.Migration

  def change do
    create table("branches") do
      add :name, :string, size: 70, null: false
      add :legal_name, :string
      add :description, :string
      add :is_active, :boolean, default: true, null: false

      add :company_id, references(:companies)

      timestamps()
    end
  end
end
