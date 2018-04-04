# Tasktracker3

This application will need to do the below functionalities along with added functionalities:
Register an account
Log in / Log out
Create Tasks, entering a title and a description
Assign tasks to themselves or other users
Track how long they've worked on a task they're assigned to, in 15-minute increments.
Mark a task as completed.

New Features:
* Using your app should involve only one full page load. Multiple pages should be
simulated using react-router and AJAX requests to a JSON API.
* Aside from the "page" controller, all of the controllers in your app should be JSON controllers.
Use Redux to manage client-side application/UI state.
* Registering and logging in should use secure password authentication.
* Passwords should be stored hashed in the database. (see the Elixir Comeonin module).
Phoenix sessions don't help with an SPA. You'll need to look into Phoenix.
* Token to handle user login and AJAX request authentication.
* Your deployed app should only be accessible via HTTPS. Use Lets Encrypt and certbot.

Design Description:
In order to make the application user friendly and effective, certain design choices had to be made:
* When the user opens the site ,he cannot see any other functionality other than the Register option
and the login form.
* If the user already has a user name and password, the user can use the login form and enter the system.
* If it is a new user, the user will have to register as a new user using the form shown in the page.
* Now the user can login.
* Once successfully logged in the user will be able to create tasks, view the multiple tasks present in the system
and view the users in the system.
* The user id of the user logged in is visible on the top of the page.
* This is a single page application so refreshing the page will log the user out.So donnot do it.
* From the feed page you can edit the task you created and delete tasks.
* The feed displays all the details regarding the tasks including the task title, description, time taken, status of the task, and assignee.
* When you click on the create task tab, you can create a task by entering the title, description,
assignee, timetaken and completed.Make sure all the fields are entered else the system will throw an error.
* The user is auto filled so the user does not have to fill it.Only a logged in user can create a task.This task is created only
if the user id provided matches the logged in users id.


To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
