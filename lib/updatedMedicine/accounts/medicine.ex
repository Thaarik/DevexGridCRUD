defmodule UpdatedMedicine.Accounts.Medicine do
  use Ecto.Schema
  import Ecto.Changeset

  schema "medicines" do
    field :comment, :string
    field :dose, :string
    field :end, :string
    field :name, :string
    field :noOfMedicine, :integer
    field :refill, :integer
    field :start, :string

    timestamps()
  end

  @doc false
  def changeset(medicine, attrs) do
    medicine
    |> cast(attrs, [:name, :dose, :noOfMedicine, :refill, :comment, :start, :end])
    |> validate_required([:name, :dose, :noOfMedicine, :refill, :comment, :start, :end])
  end
end
