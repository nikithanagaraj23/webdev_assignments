defmodule Tasktracker.Social do
  @moduledoc """
  The Social context.
  """

  import Ecto.Query, warn: false
  alias Tasktracker.Repo

  alias Tasktracker.Social.Task
  alias Tasktracker.Accounts.User
  alias Tasktracker.Social.Manage
  alias Tasktracker.Social.Timeblock


  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:user)
  end

  def get_manager(user) do
    managerid = Repo.all(from m in Manage,
      select: m.manager_id,
      where: m.managee_id == ^user.id)
    Repo.all(from u in User,
        select: u,
        where: u.id in ^managerid)
  end

  def get_managees(user) do
    manageesid = Repo.all(from m in Manage,
    select: m.managee_id,
    where: m.manager_id == ^user.id)
    if(manageesid) do
      Repo.all(from u in User,
      select: u,
      where: u.id in ^manageesid)
    end
  end

  def list_own_tasks(user) do
    Repo.all(from f in Task,
      where: f.user_id == ^user.id)
    |> Repo.preload(:user)
  end

  def get_availableuser(user) do
    managee_list = from f in Manage, distinct: true,
      select: f.managee_id,
      where: f.manager_id != ^user
    managee_list = Repo.all(managee_list)

    query = from u in User, distinct: true,
      where: u.id not in ^managee_list,
      where: u.id != ^user
    query = Repo.all(query)

  end

  def manages_map_for(user_id) do
     Repo.all(from f in Manage,
       where: f.manager_id == ^user_id)
     |> Enum.map(&({&1.managee_id, &1.id}))
     |> Enum.into(%{})
   end


   def feed_posts_for(user) do
       user = Repo.preload(user, :managees)
       managed_ids = Enum.map(user.managees, &(&1.id))
       managed_user = Enum.map(user.managees, &(&1.name))
       Repo.all(Task)
       |> Enum.filter(&(Enum.member?(managed_user, &1.assignee)))
       |> Repo.preload(:user)
     end

     def list_assignees_for(user) do
         user = Repo.preload(user, :managees)
         managed_user = Enum.map(user.managees, &(&1.name))
    end

    def get_assigned_tasks(user_name) do
      Repo.all(from f in Task,
      where: f.assignee == ^user_name)
      |> Repo.preload(:user)
    end

    def timer_map_for(task_id) do
      time = Repo.all(from f in Task,
         where: f.id == ^task_id)
      IO.inspect(time)
    end



  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  # def get_task!(id), do: Repo.get!(Task, id)

  def get_task!(id) do
      Repo.get!(Task, id)
      |> Repo.preload(:user)
    end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end


#
# References:
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/11-resources/notes.html
# # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html
# https://hexdocs.pm/phoenix/templates.html
# https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#number_input/3
  alias Tasktracker.Social.Manage

  @doc """
  Returns the list of manages.

  ## Examples

      iex> list_manages()
      [%Manage{}, ...]

  """
  def list_manages do
    Repo.all(Manage)
  end

  @doc """
  Gets a single manage.

  Raises `Ecto.NoResultsError` if the Manage does not exist.

  ## Examples

      iex> get_manage!(123)
      %Manage{}

      iex> get_manage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manage!(id), do: Repo.get!(Manage, id)

  def get_manage(id), do: Repo.get(Manage, id)

  @doc """
  Creates a manage.

  ## Examples

      iex> create_manage(%{field: value})
      {:ok, %Manage{}}

      iex> create_manage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manage(attrs \\ %{}) do
    %Manage{}
    |> Manage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manage.

  ## Examples

      iex> update_manage(manage, %{field: new_value})
      {:ok, %Manage{}}

      iex> update_manage(manage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manage(%Manage{} = manage, attrs) do
    manage
    |> Manage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manage.

  ## Examples

      iex> delete_manage(manage)
      {:ok, %Manage{}}

      iex> delete_manage(manage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manage(%Manage{} = manage) do
    Repo.delete(manage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manage changes.

  ## Examples

      iex> change_manage(manage)
      %Ecto.Changeset{source: %Manage{}}

  """
  def change_manage(%Manage{} = manage) do
    Manage.changeset(manage, %{})
  end



  @doc """
  Returns the list of timeblock.

  ## Examples

      iex> list_timeblock()
      [%Timeblock{}, ...]

  """
  def list_timeblock do
    Repo.all(Timeblock)
    |> Repo.preload(:task)
  end

  @doc """
  Gets a single timeblock.

  Raises `Ecto.NoResultsError` if the Timeblock does not exist.

  ## Examples

      iex> get_timeblock!(123)
      %Timeblock{}

      iex> get_timeblock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_timeblock!(id) do
     Repo.get!(Timeblock, id)
     |> Repo.preload(:task)
   end

  @doc """
  Creates a timeblock.

  ## Examples

      iex> create_timeblock(%{field: value})
      {:ok, %Timeblock{}}

      iex> create_timeblock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_timeblock(attrs \\ %{}) do
    %Timeblock{}
    |> Timeblock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a timeblock.

  ## Examples

      iex> update_timeblock(timeblock, %{field: new_value})
      {:ok, %Timeblock{}}

      iex> update_timeblock(timeblock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_timeblock(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> Timeblock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Timeblock.

  ## Examples

      iex> delete_timeblock(timeblock)
      {:ok, %Timeblock{}}

      iex> delete_timeblock(timeblock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_timeblock(%Timeblock{} = timeblock) do
    Repo.delete(timeblock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking timeblock changes.

  ## Examples

      iex> change_timeblock(timeblock)
      %Ecto.Changeset{source: %Timeblock{}}

  """
  def change_timeblock(%Timeblock{} = timeblock) do
    Timeblock.changeset(timeblock, %{})
  end

  def list_timeblock_task(task_id) do
    Repo.all(from f in Timeblock,
    where: f.timer_id == ^task_id)
  end

end



#
# References:
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/11-resources/notes.html
# # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/14-assoc-and-ajax/notes.html
# https://hexdocs.pm/phoenix/templates.html
# https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#number_input/3
