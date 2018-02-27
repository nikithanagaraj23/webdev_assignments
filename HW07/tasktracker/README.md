# TaskTracker

#Design Decisions for HW7:

##Task 1: Managers

* Some users should be managers, who supervise many other users.
* nOnly a users's manager can assign them a task.
* A user's profile page should show both their manager and a list of people
that they manage (underlings).
* Managers should be able to see a task report, which shows a table of tasks
assigned to their underlings and the status of those tasks.

The design of the application is to make sure any user with or without any
technical knowledge can use this application smoothly without any guidance.
In order to ensure this, the following choices of layouts and designs have been
Made adding to the design decisions from the previous assignment:
* In order to ensure that some users should be managers, a new resource of the
 json format has been added. This resource is a table which has a managerid
 and a manage id which will maintain the link between the users to their
 managers and managers to their managees. This way of using a new resource to
 provide references to the users give a easier and cleaner way to access the
 task table as well as the user table easily as the ids present in this table
references the user table directly in the one to many fashion.
* So the system is designed such that a user can choose other users whom he
wants to manage. The first user who logs in has the advantages of choosing the
users he wants to manage. For this, on the feed page of the user, there is a
link “Choose users to Manage” which will show the current use the available
users from whom he can chose to manage or unmanage any of the listed users.
*	A user cannot manage himself. So unless assigned the user cannot create a
ticket and assign it to himself. A user can only assign the task to any of the
users who he manages.
* The feed page has a lot of content. The page first displayed the Manager of
the User if there is one, else this value is blank. Below this a list of all
users being managed by this user is listed under the heading “Your Underlings
are:”
* In order to make sure it is readable, a tabpanel format is used on this page
to display the tasks assigned to the current user, the tasks report of the
underlings, the tasks created by the current user. Clicking on each of these
will display the list of tasks with the status of each of them from where they
can be edited.
* When a user has been selected by another user to be managed, then no other
user will get this user as an option to be managed.
* When a manager wants to assign a task, only the users he has selected to
manage will appear in the drop down for assignees while creating a task.


##Task2: Timeblock
* To include timeblocks into the database a new resouse called timeblock is
included which contains a start_time , end-time and an id which references tasks.
* Since the timeblocks will be added by the users to whom the task is assigned
to, the option to view the list of timeblocks and add a time block is
provided in the edit page of the task.
When a user wants to add a timeblock, he needs to click the edit option
which will take him to the edit task page.
* Here the user has the option of using a start and stop button right on top
of the task page to start the timer on the task and stop the timer.
* There can be multiple timeblocks created on a task, over different periods.
Once the stop button is clicked a new entry is added to the list of timeblocks
present.
* The user also has an option of manually entering the start time and end time
in the webpage using input fields. Once the “Add Timeblock” button is clicked,
a new entry of timeblock is created and added to the list of timeblocks.
* The list of time blocks can be seen on the edit task page itself just below
the task creation form.
* Each of these timeblocks can be edited and deleted.
* The delete button will delete this time block
* The Edit button will toggle down a form just below the timeblock you want to
edit where you can add edit or add new values for start and stop .When the
“Save changes ” button is clicked the new values get updated into this timeblock.
* If you click on edit and don’t want to make any changes, clicking on the edit
button again will close the form.
* This way it provides a very clean picture of what is being edited and
provides a very user friendly approach


#Design Decisions for HW6:
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
