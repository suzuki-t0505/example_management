defmodule Management.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :address, :string
      add :phone_number, :string
      add :email, :string
      add :date_of_birth, :date
      add :department, :string
      add :employment_type, :string
      add :date_of_joining, :date

      timestamps(type: :utc_datetime)
    end
  end
end
