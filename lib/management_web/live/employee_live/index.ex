defmodule ManagementWeb.EmployeeLive.Index do
  use ManagementWeb, :live_view

  alias Management.Employees
  alias Management.Employees.Employee

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream(:employees, Employees.list_employees())
      |> assign(:employment_options, ["全て"] ++ Employees.list_employment_types())
      |> assign(:department_options, ["全て"] ++ Employees.list_department())
      |> assign(:option_values, %{"date_of_joining" => "", "department" => "全て", "employment_type" => "全て"})
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Employee")
    |> assign(:employee, Employees.get_employee!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Employee")
    |> assign(:employee, %Employee{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Employees")
    |> assign(:employee, nil)
  end

  @impl true
  def handle_info({ManagementWeb.EmployeeLive.FormComponent, {:saved, employee}}, socket) do
    {:noreply, stream_insert(socket, :employees, employee)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    employee = Employees.get_employee!(id)
    {:ok, _} = Employees.delete_employee(employee)

    {:noreply, stream_delete(socket, :employees, employee)}
  end

  def handle_event("filter", %{"filter" => params}, socket) do
    employees =
      params
      |> Enum.reject(fn {_filed, value} -> value in ["", "全て"] end)
      |> Employees.list_filter_employees()

    socket =
      socket
      |> stream(:employees, employees, reset: true)
      |> assign(:option_values, params)

    {:noreply, socket}
  end
end
