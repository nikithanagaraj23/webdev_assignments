defmodule Tasktracker.Social.Timeblock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Social.Timeblock


  schema "timeblock" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    belongs_to :task, Tasktracker.Social.Task , foreign_key: :timer_id
    timestamps()
  end

  @doc false
  def changeset(%Timeblock{} = timeblock, attrs) do
    timeblock
    |> cast(attrs, [:start_time, :end_time, :timer_id])
    |> validate_required([:start_time, :end_time, :timer_id])
  end
end
