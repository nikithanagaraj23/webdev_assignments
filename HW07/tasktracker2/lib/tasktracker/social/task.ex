defmodule Tasktracker.Social.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Task
  alias Tasktracker.Social.Timeblock


  schema "tasks" do
    field :assignee, :string
    field :completed, :boolean, default: false
    field :description, :string
    field :timetaken, :integer
    field :title, :string
    belongs_to :user, Tasktracker.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :assignee, :timetaken, :completed, :user_id])
    |> validate_required([:title, :description, :assignee, :completed, :user_id])
  end
end
