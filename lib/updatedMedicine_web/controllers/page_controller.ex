defmodule UpdatedMedicineWeb.PageController do
  use UpdatedMedicineWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
