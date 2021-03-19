defmodule UpdatedMedicineWeb.MedicineView do
  use UpdatedMedicineWeb, :view
  alias UpdatedMedicineWeb.MedicineView

  def render("index.json", %{medicines: medicines}) do
    %{data: render_many(medicines, MedicineView, "medicine.json")}
  end

  def render("show.json", %{medicine: medicine}) do
    %{data: render_one(medicine, MedicineView, "medicine.json")}
  end

  def render("medicine.json", %{medicine: medicine}) do
    %{id: medicine.id,
      name: medicine.name,
      dose: medicine.dose,
      noOfMedicine: medicine.noOfMedicine,
      refill: medicine.refill,
      comment: medicine.comment,
      start: medicine.start,
      end: medicine.end}
  end
end
