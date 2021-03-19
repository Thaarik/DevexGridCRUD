defmodule UpdatedMedicine.Repo do
  use Ecto.Repo,
    otp_app: :updatedMedicine,
    adapter: Ecto.Adapters.Postgres
end
