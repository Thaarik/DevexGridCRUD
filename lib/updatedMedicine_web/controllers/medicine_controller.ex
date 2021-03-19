defmodule UpdatedMedicineWeb.MedicineController do
  use UpdatedMedicineWeb, :controller

  alias UpdatedMedicine.Accounts
  alias UpdatedMedicine.Accounts.Medicine

  action_fallback UpdatedMedicineWeb.FallbackController

  def index(conn, _params) do
    medicines = Accounts.list_medicines()
    render(conn, "index.json", medicines: medicines)
  end
  def create(conn, params) do
    with {:ok, %Medicine{} = medicine} <- Accounts.create_medicine(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.medicine_path(conn, :show, medicine))
      |> render("show.json", medicine: medicine)
    end
  end
  # def create(conn, %{"medicine" => medicine_params}) do
  #   with {:ok, %Medicine{} = medicine} <- Accounts.create_medicine(medicine_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.medicine_path(conn, :show, medicine))
  #     |> render("show.json", medicine: medicine)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    medicine = Accounts.get_medicine!(id)
    render(conn, "show.json", medicine: medicine)
  end

  def update(conn, %{"id" => id}=params) do
    medicine = Accounts.get_medicine!(id)

    with {:ok, %Medicine{} = medicine} <- Accounts.update_medicine(medicine, params) do
      render(conn, "show.json", medicine: medicine)
    end
  end

  def delete(conn, %{"id" => id}) do
    medicine = Accounts.get_medicine!(id)

    with {:ok, %Medicine{}} <- Accounts.delete_medicine(medicine) do
      send_resp(conn, :no_content, "")
    end
  end
end
