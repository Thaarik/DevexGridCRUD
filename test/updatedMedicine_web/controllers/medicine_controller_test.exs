defmodule UpdatedMedicineWeb.MedicineControllerTest do
  use UpdatedMedicineWeb.ConnCase

  alias UpdatedMedicine.Accounts
  alias UpdatedMedicine.Accounts.Medicine

  @create_attrs %{
    comment: "some comment",
    dose: "some dose",
    end: "some end",
    name: "some name",
    noOfMedicine: 42,
    refill: 42,
    start: "some start"
  }
  @update_attrs %{
    comment: "some updated comment",
    dose: "some updated dose",
    end: "some updated end",
    name: "some updated name",
    noOfMedicine: 43,
    refill: 43,
    start: "some updated start"
  }
  @invalid_attrs %{comment: nil, dose: nil, end: nil, name: nil, noOfMedicine: nil, refill: nil, start: nil}

  def fixture(:medicine) do
    {:ok, medicine} = Accounts.create_medicine(@create_attrs)
    medicine
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all medicines", %{conn: conn} do
      conn = get(conn, Routes.medicine_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create medicine" do
    test "renders medicine when data is valid", %{conn: conn} do
      conn = post(conn, Routes.medicine_path(conn, :create), medicine: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.medicine_path(conn, :show, id))

      assert %{
               "id" => id,
               "comment" => "some comment",
               "dose" => "some dose",
               "end" => "some end",
               "name" => "some name",
               "noOfMedicine" => 42,
               "refill" => 42,
               "start" => "some start"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.medicine_path(conn, :create), medicine: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update medicine" do
    setup [:create_medicine]

    test "renders medicine when data is valid", %{conn: conn, medicine: %Medicine{id: id} = medicine} do
      conn = put(conn, Routes.medicine_path(conn, :update, medicine), medicine: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.medicine_path(conn, :show, id))

      assert %{
               "id" => id,
               "comment" => "some updated comment",
               "dose" => "some updated dose",
               "end" => "some updated end",
               "name" => "some updated name",
               "noOfMedicine" => 43,
               "refill" => 43,
               "start" => "some updated start"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, medicine: medicine} do
      conn = put(conn, Routes.medicine_path(conn, :update, medicine), medicine: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete medicine" do
    setup [:create_medicine]

    test "deletes chosen medicine", %{conn: conn, medicine: medicine} do
      conn = delete(conn, Routes.medicine_path(conn, :delete, medicine))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.medicine_path(conn, :show, medicine))
      end
    end
  end

  defp create_medicine(_) do
    medicine = fixture(:medicine)
    %{medicine: medicine}
  end
end
