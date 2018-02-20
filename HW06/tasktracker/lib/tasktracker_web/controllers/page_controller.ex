defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller
  alias Tasktracker.Accounts
  alias Tasktracker.Repo

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
  assignees = Repo.all(Accounts.User)
                |> Enum.map(&[&1.name])
                |> List.flatten()
   tasks = Tasktracker.Social.list_tasks()
   new_task = %Tasktracker.Social.Task{user_id: conn.assigns[:current_user].id}
   changeset = Tasktracker.Social.change_task(new_task)
   render conn, "feed.html", tasks: tasks, changeset: changeset, assignees: assignees
 end

end


#
# References:
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/11-resources/notes.html
# # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html
# https://hexdocs.pm/phoenix/templates.html
# https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#number_input/3
