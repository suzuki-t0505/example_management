defmodule Management.Employees.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :name, :string
    field :address, :string
    field :phone_number, :string
    field :email, :string
    field :date_of_birth, :date
    field :department, :string
    field :employment_type, :string
    field :date_of_joining, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :address, :phone_number, :email, :date_of_birth, :department, :employment_type, :date_of_joining])
    |> validate_required([:name, :address, :phone_number, :email, :date_of_birth, :department, :employment_type, :date_of_joining])
  end
end
