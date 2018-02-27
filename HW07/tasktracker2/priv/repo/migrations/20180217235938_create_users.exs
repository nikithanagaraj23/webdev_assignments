defmodule Tasktracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false

      timestamps()
    end

  end
end


#
# References:
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/11-resources/notes.html
# # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html
# https://hexdocs.pm/phoenix/templates.html
# https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#number_input/3
