defmodule Tasktracker.Repo.Migrations.CreateTimeblock do
  use Ecto.Migration

  def change do
    create table(:timeblock) do
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :timer_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:timeblock, [:timer_id])
  end
end
