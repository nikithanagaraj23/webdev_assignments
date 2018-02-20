defmodule TasktrackerWeb.TaskController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Social
  alias Tasktracker.Accounts
  alias Tasktracker.Social.Task
  alias Tasktracker.Repo

  def index(conn, _params) do
    assignees = Repo.all(Accounts.User)
                |> Enum.map(&[&1.name])
                |> List.flatten()
    tasks = Social.list_tasks()
    render(conn, "index.html", tasks: tasks,assignees: assignees)
  end

  def new(conn, _params) do
    assignees = Repo.all(Accounts.User)
                |> Enum.map(&[&1.name])
                |> List.flatten()
    new_task = %Tasktracker.Social.Task{user_id: conn.assigns[:current_user].id}
    changeset = Tasktracker.Social.change_task(new_task)
    render(conn, "new.html", changeset: changeset ,assignees: assignees)
  end

  def create(conn, %{"task" => task_params}) do
    assignees = Repo.all(Accounts.User)
                |> Enum.map(&[&1.name])
                |> List.flatten()
    case Social.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, assignees: assignees)
    end
  end

  def show(conn, %{"id" => id}) do
    assignees = Repo.all(Accounts.User)
                |> Enum.map(&[&1.name])
                |> List.flatten()
    task = Social.get_task!(id)
    render(conn, "show.html", task: task, assignees: assignees)
  end

  def edit(conn, %{"id" => id}) do
    assignees = Repo.all(Accounts.User)
                |> Enum.map(&[&1.name])
                |> List.flatten()
    task = Social.get_task!(id)
    changeset = Social.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset, assignees: assignees)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Social.get_task!(id)
    assignees = Repo.all(Accounts.User)
                |> Enum.map(&[&1.name])
                |> List.flatten()
    case Social.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset,assignees: assignees)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Social.get_task!(id)
    {:ok, _task} = Social.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end

#
# References:
# https://stackoverflow.com/questions/36698192/how-to-create-a-select-tag-with-options-and-values-from-a-separate-model-in-the
# https://stackoverflow.com/questions/33805309/how-to-show-all-records-of-a-model-in-phoenix-select-field
# https://stackoverflow.com/questions/33803754/phoenix-ordering-a-query-set
# https://stackoverflow.com/questions/33961924/how-to-use-repo-module-in-my-model-file
