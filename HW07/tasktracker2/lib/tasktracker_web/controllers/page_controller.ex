defmodule TasktrackerWeb.PageController do
  use TasktrackerWeb, :controller
  alias Tasktracker.Accounts
  alias Tasktracker.Repo
  alias Tasktracker.Social

  def index(conn, _params) do
    render conn, "index.html"
  end

  def feed(conn, _params) do
   assigned_tasks = Social.get_assigned_tasks(conn.assigns[:current_user].name)
   assignees = Social.list_assignees_for(conn.assigns[:current_user])
   tasks = Enum.reverse(Social.feed_posts_for(conn.assigns[:current_user]))
   new_task = %Tasktracker.Social.Task{user_id: conn.assigns[:current_user].id}
   owntasks = Social.list_own_tasks(conn.assigns[:current_user])
   changeset = Social.change_task(new_task)
   manager = Social.get_manager(conn.assigns[:current_user])
   managees = Social.get_managees(conn.assigns[:current_user])
   render conn, "feed.html", tasks: tasks, owntasks: owntasks,
   changeset: changeset, assignees: assignees, manager: manager,
   managees: managees, assigned_tasks: assigned_tasks
 end

end


#
# References:
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/11-resources/notes.html
# # http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html
# http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/14-assoc-and-ajax/notes.html
# https://hexdocs.pm/phoenix/templates.html
# https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#number_input/3
