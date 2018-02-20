# TaskTracker

#Design Decisions:
The main purpose of this application is to allow a user to have the below
functionalities:
* login/logout
* Register an account
* Create Tasks, entering a title and a description
* Assign tasks to themselves or other users
* Track how long they've worked on a task they're assigned to,
in 15-minute increments.
* Mark a task as completed.

The design of the application is to make sure any user with or without any
technical knowledge can use this application smoothly without any guidance.

In order to ensure this, the following choices of layouts and designs have been
 made:
* The login page (http://tasks1.nikithanagaraj.com/) will have have an input
form field to input the email id of a user who has already been registered.The
user can now press the Login button to view and create tasks.
* If a new user is trying to login, the selection of the login button will show
up an error message prompting the user to first register.The user can click on
the register button and register as a new user.From here the user can go back
to the login page and enter the application.
* Once the user logs in, he will land up on the feeds page.
* Here the user can view the list of all tasks present including his and the
tasks of other users.
* The logged in users name will be displayed on the top of the page.
* On this page, in order to make task creation simple, the user can create tasks
 from the top of the page, using the form present on top of the page.
* In this form the User can add a title and  description, select the assignee
 who will be the user to whom the task will be assigned to, enter time taken to
 complete the task and also mark if the task has been completed or not.
* The assignee field is a dropdown of names to make it simpler for the user
 to know whom the task is being assigned to.
* The time field is an input field of numbers where the user can enter or
increment the  time in steps of 15 mins.
* The field to mark a task as completed is a checkbox, where the user checks the
box if the task is completed else the task isn't completed yet.
* Once submitted without any errors the user can see the task which he just
created and its related data.
* From here, the user can go back to the feed page using the "back to feed" link.
* The feed will now include the new task created at the end of the list of tasks.
* If there was an error when the form is submitted, the user is prompted with
the error validation and once the error is corrected the user can submit again.
* This layout of showing the feeds and task creation on a single page helps the
users to keep track of all tasks and shows an easy flow of data without having
to search through different pages.
* In the tasks listed in the feed, any user can edit any of the tasks to update
them as completed or if the task needs to be reassigned.
* The user_id is hidden from the form even though it is present, as the user
 does not need to know his/her id.This will be looked after and updated by the
 system itself.
* When the user makes a new task he is prompted to a page where the task he
created is shown. From here the user can choose to edit the task ,view the list
of tasks present or even go back to his timeline feed. These are present as
separate links to ensure accessibility.
* The main set of tasks can be viewed on "/tasks" page and all the users can be
seen on "/users" page.
* These tasks and users can be deleted from here.Hence this functionality
should be controlled by the admin.
* The user can logout anytime by clicking the logout link at the top of the page.

## Development Instructions

Prerequisites:

 * Erlang / OTP ~ 20.2
 * Elixir ~ 1.5
 * NodeJS ~ 9.4

To start your Phoenix server:

 * Install dependencies with `mix deps.get`
 * Install Node.js dependencies with `cd assets && npm install`
 * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
