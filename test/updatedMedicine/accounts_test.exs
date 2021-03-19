defmodule UpdatedMedicine.AccountsTest do
  use UpdatedMedicine.DataCase

  alias UpdatedMedicine.Accounts

  describe "medicines" do
    alias UpdatedMedicine.Accounts.Medicine

    @valid_attrs %{comment: "some comment", dose: "some dose", end: "some end", name: "some name", noOfMedicine: 42, refill: 42, start: "some start"}
    @update_attrs %{comment: "some updated comment", dose: "some updated dose", end: "some updated end", name: "some updated name", noOfMedicine: 43, refill: 43, start: "some updated start"}
    @invalid_attrs %{comment: nil, dose: nil, end: nil, name: nil, noOfMedicine: nil, refill: nil, start: nil}

    def medicine_fixture(attrs \\ %{}) do
      {:ok, medicine} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_medicine()

      medicine
    end

    test "list_medicines/0 returns all medicines" do
      medicine = medicine_fixture()
      assert Accounts.list_medicines() == [medicine]
    end

    test "get_medicine!/1 returns the medicine with given id" do
      medicine = medicine_fixture()
      assert Accounts.get_medicine!(medicine.id) == medicine
    end

    test "create_medicine/1 with valid data creates a medicine" do
      assert {:ok, %Medicine{} = medicine} = Accounts.create_medicine(@valid_attrs)
      assert medicine.comment == "some comment"
      assert medicine.dose == "some dose"
      assert medicine.end == "some end"
      assert medicine.name == "some name"
      assert medicine.noOfMedicine == 42
      assert medicine.refill == 42
      assert medicine.start == "some start"
    end

    test "create_medicine/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_medicine(@invalid_attrs)
    end

    test "update_medicine/2 with valid data updates the medicine" do
      medicine = medicine_fixture()
      assert {:ok, %Medicine{} = medicine} = Accounts.update_medicine(medicine, @update_attrs)
      assert medicine.comment == "some updated comment"
      assert medicine.dose == "some updated dose"
      assert medicine.end == "some updated end"
      assert medicine.name == "some updated name"
      assert medicine.noOfMedicine == 43
      assert medicine.refill == 43
      assert medicine.start == "some updated start"
    end

    test "update_medicine/2 with invalid data returns error changeset" do
      medicine = medicine_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_medicine(medicine, @invalid_attrs)
      assert medicine == Accounts.get_medicine!(medicine.id)
    end

    test "delete_medicine/1 deletes the medicine" do
      medicine = medicine_fixture()
      assert {:ok, %Medicine{}} = Accounts.delete_medicine(medicine)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_medicine!(medicine.id) end
    end

    test "change_medicine/1 returns a medicine changeset" do
      medicine = medicine_fixture()
      assert %Ecto.Changeset{} = Accounts.change_medicine(medicine)
    end
  end
end
