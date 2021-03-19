defmodule UpdatedMedicine.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias UpdatedMedicine.Repo

  alias UpdatedMedicine.Accounts.Medicine

  @doc """
  Returns the list of medicines.

  ## Examples

      iex> list_medicines()
      [%Medicine{}, ...]

  """
  def list_medicines do
    Repo.all(Medicine)
  end

  @doc """
  Gets a single medicine.

  Raises `Ecto.NoResultsError` if the Medicine does not exist.

  ## Examples

      iex> get_medicine!(123)
      %Medicine{}

      iex> get_medicine!(456)
      ** (Ecto.NoResultsError)

  """
  def get_medicine!(id), do: Repo.get!(Medicine, id)

  @doc """
  Creates a medicine.

  ## Examples

      iex> create_medicine(%{field: value})
      {:ok, %Medicine{}}

      iex> create_medicine(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_medicine(attrs \\ %{}) do
    %Medicine{}
    |> Medicine.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a medicine.

  ## Examples

      iex> update_medicine(medicine, %{field: new_value})
      {:ok, %Medicine{}}

      iex> update_medicine(medicine, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_medicine(%Medicine{} = medicine, attrs) do
    medicine
    |> Medicine.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a medicine.

  ## Examples

      iex> delete_medicine(medicine)
      {:ok, %Medicine{}}

      iex> delete_medicine(medicine)
      {:error, %Ecto.Changeset{}}

  """
  def delete_medicine(%Medicine{} = medicine) do
    Repo.delete(medicine)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking medicine changes.

  ## Examples

      iex> change_medicine(medicine)
      %Ecto.Changeset{data: %Medicine{}}

  """
  def change_medicine(%Medicine{} = medicine, attrs \\ %{}) do
    Medicine.changeset(medicine, attrs)
  end
end
