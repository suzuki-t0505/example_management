defmodule Management.EmployeesTest do
  use Management.DataCase

  alias Management.Employees

  describe "employees" do
    alias Management.Employees.Employee

    import Management.EmployeesFixtures

    @invalid_attrs %{name: nil, address: nil, phone_number: nil, email: nil, date_of_birth: nil, department: nil, employment_type: nil, date_of_joining: nil}

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Employees.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Employees.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      valid_attrs = %{name: "some name", address: "some address", phone_number: "some phone_number", email: "some email", date_of_birth: ~D[2024-04-17], department: "some department", employment_type: "some employment_type", date_of_joining: ~D[2024-04-17]}

      assert {:ok, %Employee{} = employee} = Employees.create_employee(valid_attrs)
      assert employee.name == "some name"
      assert employee.address == "some address"
      assert employee.phone_number == "some phone_number"
      assert employee.email == "some email"
      assert employee.date_of_birth == ~D[2024-04-17]
      assert employee.department == "some department"
      assert employee.employment_type == "some employment_type"
      assert employee.date_of_joining == ~D[2024-04-17]
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Employees.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", phone_number: "some updated phone_number", email: "some updated email", date_of_birth: ~D[2024-04-18], department: "some updated department", employment_type: "some updated employment_type", date_of_joining: ~D[2024-04-18]}

      assert {:ok, %Employee{} = employee} = Employees.update_employee(employee, update_attrs)
      assert employee.name == "some updated name"
      assert employee.address == "some updated address"
      assert employee.phone_number == "some updated phone_number"
      assert employee.email == "some updated email"
      assert employee.date_of_birth == ~D[2024-04-18]
      assert employee.department == "some updated department"
      assert employee.employment_type == "some updated employment_type"
      assert employee.date_of_joining == ~D[2024-04-18]
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Employees.update_employee(employee, @invalid_attrs)
      assert employee == Employees.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Employees.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Employees.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Employees.change_employee(employee)
    end
  end
end
