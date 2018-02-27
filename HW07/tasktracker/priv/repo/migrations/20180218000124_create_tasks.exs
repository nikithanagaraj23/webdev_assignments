defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :assignee, :string, null: false
      add :timetaken, :integer, null: false
      add :completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:tasks, [:user_id])
    # create constraint("tasks", :time_should_be_multiples_of_15, check: "timetaken % 15 == 0")
  end
end


#
# References:
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/11-resources/notes.html
# # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html
# https://hexdocs.pm/phoenix/templates.html
# https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#number_input/3
