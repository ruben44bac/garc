defmodule Garc.Repo.Migrations.CreateProductTaxes do
  use Ecto.Migration

  def change do
    execute(
      "CREATE TYPE tax_type AS ENUM ('iva', 'isr')",
      "DROP TYPE tax_type"
    )

    create table("product_taxes") do
      add(:type, :tax_type, null: false, default: "iva")
      add(:amount, :decimal)

      add(:product_id, references(:products))

      timestamps()
    end
  end
end
