defmodule Management.EmployeesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Management.Employees` context.
  """

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        address: "some address",
        date_of_birth: ~D[2024-04-17],
        date_of_joining: ~D[2024-04-17],
        department: "some department",
        email: "some email",
        employment_type: "some employment_type",
        name: "some name",
        phone_number: "some phone_number"
      })
      |> Management.Employees.create_employee()

    employee
  end
end
