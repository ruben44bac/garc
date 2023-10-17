defmodule Garc.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table("products") do
      add(:name, :string, size: 70, null: false)
      add(:key, :string, size: 10)
      add(:sku, :string, size: 50)
      add(:ean_code, :string, size: 30)
      add(:is_inventory, :boolean, null: false, default: false)
      add(:is_sale, :boolean, null: false, default: false)
      add(:is_buy, :boolean, null: false, default: false)
      add(:sat_key, :string, size: 20)
      add(:unit, :string, size: 70)
      add(:quantity, :integer)
      add(:um_packing, :string, size: 70)
      add(:um_packing_quantity, :integer)
      add(:sat_unit, :string, size: 20)
      add(:is_negative_allow, :boolean, null: false, default: false)
      add(:is_price_updated, :boolean, null: false, default: false)
      add(:width, :decimal)
      add(:height, :decimal)
      add(:long, :decimal)
      add(:weight, :decimal)
      add(:account_id, references(:accounts))

      timestamps()
    end
  end
end
