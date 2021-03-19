defmodule UpdatedMedicine.Repo.Migrations.CreateMedicines do
  use Ecto.Migration

  def change do
    create table(:medicines) do
      add :name, :string
      add :dose, :string
      add :noOfMedicine, :integer
      add :refill, :integer
      add :comment, :string
      add :start, :string
      add :end, :string

      timestamps()
    end

  end
end
