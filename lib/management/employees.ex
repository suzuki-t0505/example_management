defmodule Management.Employees do
  @moduledoc """
  The Employees context.
  """

  import Ecto.Query, warn: false
  alias Management.Repo

  alias Management.Employees.Employee

  @doc """
  Returns the list of employees.

  ## Examples

      iex> list_employees()
      [%Employee{}, ...]

  """
  def list_employees do
    Repo.all(Employee)
  end

  def list_department do
    Employee
    |> select([e], e.department)
    |> Repo.all()
    |> Enum.uniq()
  end

  def list_employment_types do
    Employee
    |> select([e], e.employment_type)
    |> Repo.all()
    |> Enum.uniq()
  end

  @doc """
  指定された値で従業員データをフィルターします。
  """
  def list_filter_employees(params) do
    params
    |> Enum.reduce(Employee, fn filter_value, query ->
      filter_employees_query(query, filter_value)
    end)
    |> Repo.all()
  end

  defp filter_employees_query(query, {"department", department}) do
    where(query, [e], e.department == ^department)
  end

  defp filter_employees_query(query, {"employment_type", employment_type}) do
    where(query, [e], e.employment_type == ^employment_type)
  end

  defp filter_employees_query(query, {"date_of_joining", date_of_joining}) do
    [year, month] = date_of_joining |> String.split("-") |> Enum.map(& String.to_integer/1)
    min_date = Date.new!(year, month, 1)
    max_date = Date.end_of_month(min_date)
    where(query, [e], e.date_of_joining >= ^min_date and e.date_of_joining <= ^max_date)
  end

  defp filter_employees_query(query, _), do: query

  @doc """
  Gets a single employee.

  Raises `Ecto.NoResultsError` if the Employee does not exist.

  ## Examples

      iex> get_employee!(123)
      %Employee{}

      iex> get_employee!(456)
      ** (Ecto.NoResultsError)

  """
  def get_employee!(id), do: Repo.get!(Employee, id)

  @doc """
  Creates a employee.

  ## Examples

      iex> create_employee(%{field: value})
      {:ok, %Employee{}}

      iex> create_employee(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_employee(attrs \\ %{}) do
    %Employee{}
    |> Employee.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a employee.

  ## Examples

      iex> update_employee(employee, %{field: new_value})
      {:ok, %Employee{}}

      iex> update_employee(employee, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_employee(%Employee{} = employee, attrs) do
    employee
    |> Employee.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a employee.

  ## Examples

      iex> delete_employee(employee)
      {:ok, %Employee{}}

      iex> delete_employee(employee)
      {:error, %Ecto.Changeset{}}

  """
  def delete_employee(%Employee{} = employee) do
    Repo.delete(employee)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking employee changes.

  ## Examples

      iex> change_employee(employee)
      %Ecto.Changeset{data: %Employee{}}

  """
  def change_employee(%Employee{} = employee, attrs \\ %{}) do
    Employee.changeset(employee, attrs)
  end
end
