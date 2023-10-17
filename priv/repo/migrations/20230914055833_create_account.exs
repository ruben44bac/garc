defmodule Garc.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table("subscriptions") do
      add :name, :string, size: 70
      add :key, :string, size: 50
      add :description, :text

      timestamps()
    end

    create table("accounts") do
      add :name, :string
      add :first_surname, :string, size: 70
      add :second_surname, :string, size: 70
      add :email, :string, size: 100
      add :phone, :string, size: 11
      add :last_paymnet, :naive_datetime
      add :next_paymnet, :naive_datetime

      add :subscription_id, references(:subscriptions)

      timestamps()
    end

    create table("roles") do
      add :name, :string, size: 100

      add :account_id, references(:accounts)

      timestamps()
    end

    create table("modules") do
      add :name, :string, size: 70
      add :key, :string, size: 50

      timestamps()
    end

    create table("actions") do
      add :name, :string, size: 70
      add :key, :string, size: 50

      add :module_id, references(:modules)

      timestamps()
    end
  end
end
