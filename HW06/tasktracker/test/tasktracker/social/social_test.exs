defmodule Tasktracker.SocialTest do
  use Tasktracker.DataCase

  alias Tasktracker.Social

  describe "tasks" do
    alias Tasktracker.Social.Task

    @valid_attrs %{assignee: "some assignee", completed: true, description: "some description", timetaken: 42, title: "some title"}
    @update_attrs %{assignee: "some updated assignee", completed: false, description: "some updated description", timetaken: 43, title: "some updated title"}
    @invalid_attrs %{assignee: nil, completed: nil, description: nil, timetaken: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Social.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Social.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Social.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Social.create_task(@valid_attrs)
      assert task.assignee == "some assignee"
      assert task.completed == true
      assert task.description == "some description"
      assert task.timetaken == 42
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Social.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Social.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.assignee == "some updated assignee"
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.timetaken == 43
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Social.update_task(task, @invalid_attrs)
      assert task == Social.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Social.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Social.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Social.change_task(task)
    end
  end
end
