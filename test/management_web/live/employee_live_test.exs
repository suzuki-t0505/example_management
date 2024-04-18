defmodule ManagementWeb.EmployeeLiveTest do
  use ManagementWeb.ConnCase

  import Phoenix.LiveViewTest
  import Management.EmployeesFixtures

  @create_attrs %{name: "some name", address: "some address", phone_number: "some phone_number", email: "some email", date_of_birth: "2024-04-17", department: "some department", employment_type: "some employment_type", date_of_joining: "2024-04-17"}
  @update_attrs %{name: "some updated name", address: "some updated address", phone_number: "some updated phone_number", email: "some updated email", date_of_birth: "2024-04-18", department: "some updated department", employment_type: "some updated employment_type", date_of_joining: "2024-04-18"}
  @invalid_attrs %{name: nil, address: nil, phone_number: nil, email: nil, date_of_birth: nil, department: nil, employment_type: nil, date_of_joining: nil}

  defp create_employee(_) do
    employee = employee_fixture()
    %{employee: employee}
  end

  describe "Index" do
    setup [:create_employee]

    test "lists all employees", %{conn: conn, employee: employee} do
      {:ok, _index_live, html} = live(conn, ~p"/employees")

      assert html =~ "Listing Employees"
      assert html =~ employee.name
    end

    test "saves new employee", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/employees")

      assert index_live |> element("a", "New Employee") |> render_click() =~
               "New Employee"

      assert_patch(index_live, ~p"/employees/new")

      assert index_live
             |> form("#employee-form", employee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#employee-form", employee: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/employees")

      html = render(index_live)
      assert html =~ "Employee created successfully"
      assert html =~ "some name"
    end

    test "updates employee in listing", %{conn: conn, employee: employee} do
      {:ok, index_live, _html} = live(conn, ~p"/employees")

      assert index_live |> element("#employees-#{employee.id} a", "Edit") |> render_click() =~
               "Edit Employee"

      assert_patch(index_live, ~p"/employees/#{employee}/edit")

      assert index_live
             |> form("#employee-form", employee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#employee-form", employee: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/employees")

      html = render(index_live)
      assert html =~ "Employee updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes employee in listing", %{conn: conn, employee: employee} do
      {:ok, index_live, _html} = live(conn, ~p"/employees")

      assert index_live |> element("#employees-#{employee.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#employees-#{employee.id}")
    end
  end

  describe "Show" do
    setup [:create_employee]

    test "displays employee", %{conn: conn, employee: employee} do
      {:ok, _show_live, html} = live(conn, ~p"/employees/#{employee}")

      assert html =~ "Show Employee"
      assert html =~ employee.name
    end

    test "updates employee within modal", %{conn: conn, employee: employee} do
      {:ok, show_live, _html} = live(conn, ~p"/employees/#{employee}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Employee"

      assert_patch(show_live, ~p"/employees/#{employee}/show/edit")

      assert show_live
             |> form("#employee-form", employee: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#employee-form", employee: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/employees/#{employee}")

      html = render(show_live)
      assert html =~ "Employee updated successfully"
      assert html =~ "some updated name"
    end
  end
end
