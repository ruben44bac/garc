defmodule Garc.Repo.Migrations.CreateUnits do
  use Ecto.Migration

  def change do
    create table("units") do
      add(:name, :string, size: 30)
      add(:type, :integer)
      timestamps()
    end

    alter table("products") do
      remove(:um_packing)
      remove(:um_packing_quantity)
      add(:unit_id, references(:units))
      add(:unit_packing_id, references(:units))
      add(:unit_packing_quantity, :integer)
    end
  end
end
