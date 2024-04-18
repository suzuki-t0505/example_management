defmodule ManagementWeb.EmployeeLive.FormComponent do
  use ManagementWeb, :live_component

  alias Management.Employees

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage employee records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="employee-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:phone_number]} type="text" label="Phone number" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:date_of_birth]} type="date" label="Date of birth" />
        <.input field={@form[:department]} type="text" label="Department" />
        <.input field={@form[:employment_type]} type="select" label="Employment type" options={@options} />
        <.input field={@form[:date_of_joining]} type="date" label="Date of joining" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Employee</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{employee: employee} = assigns, socket) do
    changeset = Employees.change_employee(employee)
    options = ["社員", "契約社員", "アルバイト"]

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:options, options)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"employee" => employee_params}, socket) do
    changeset =
      socket.assigns.employee
      |> Employees.change_employee(employee_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"employee" => employee_params}, socket) do
    save_employee(socket, socket.assigns.action, employee_params)
  end

  defp save_employee(socket, :edit, employee_params) do
    case Employees.update_employee(socket.assigns.employee, employee_params) do
      {:ok, employee} ->
        notify_parent({:saved, employee})

        {:noreply,
         socket
         |> put_flash(:info, "Employee updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_employee(socket, :new, employee_params) do
    case Employees.create_employee(employee_params) do
      {:ok, employee} ->
        notify_parent({:saved, employee})

        {:noreply,
         socket
         |> put_flash(:info, "Employee created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
