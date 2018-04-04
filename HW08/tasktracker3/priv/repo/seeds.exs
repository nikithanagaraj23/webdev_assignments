# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasktracker3.Repo.insert!(%Tasktracker3.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  alias Tasktracker3.Repo
  alias Tasktracker3.Users.User
  alias Tasktracker3.Tasks.Task

  def run do
    p = Comeonin.Argon2.hashpwsalt("password1")

    Repo.delete_all(User)
    a = Repo.insert!(%User{ name: "alice",password_hash: p })
    b = Repo.insert!(%User{ name: "bob", password_hash: p })
    c = Repo.insert!(%User{ name: "carol", password_hash: p  })
    d = Repo.insert!(%User{ name: "dave", password_hash: p  })

    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, title: "title1" , description: "Hi, I'm Alice" , timetaken: 15, completed: false , assignee: "bob" })
    Repo.insert!(%Task{ user_id: b.id, title: "title2" , description: "Hi, I'm Bob" , timetaken: 30, completed: true , assignee: "carol" })
    Repo.insert!(%Task{ user_id: b.id, title: "title3" , description: "Hi, I'm Bob Again", timetaken: 60, completed: true , assignee: "dave"  })
    Repo.insert!(%Task{ user_id: c.id, title: "title4" , description: "Hi, I'm Carol", timetaken: 80, completed: true , assignee: "alice"  })
    Repo.insert!(%Task{ user_id: d.id, title: "title5" , description: "Hi, I'm Dave", timetaken: 15, completed: false , assignee: "bob"  })
  end
end

Seeds.run
