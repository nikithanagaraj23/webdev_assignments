defmodule Tasktracker3.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :assignee, :string
    field :completed, :boolean, default: false
    field :description, :string
    field :timetaken, :integer
    field :title, :string
    belongs_to :user, Tasktracker3.Users.User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :assignee, :timetaken, :completed, :user_id])
    |> validate_required([:title, :description, :assignee, :timetaken, :completed, :user_id])
  end
end
