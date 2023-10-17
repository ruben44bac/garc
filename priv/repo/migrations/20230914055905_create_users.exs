defmodule Garc.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table("users") do
      add :email, :string, size: 200, unique: true
      add :phone, :string, size: 15
      add :password_hash, :string, size: 200
      add :name, :string, size: 70
      add :first_surname, :string, size: 70
      add :second_surname, :string, size: 70
      add :avatar, :string
      add :is_owner, :boolean, default: false
      add :is_active, :boolean, default: true, null: false

      add :rol_id, references(:roles)
      add :account_id, references(:accounts)

      timestamps()
    end
  end
end
