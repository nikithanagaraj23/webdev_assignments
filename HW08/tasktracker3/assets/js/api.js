import store from './store';

class TheServer {
  request_tasks() {
    $.ajax("/api/v1/tasks", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'TASKS_LIST',
          tasks: resp.data,
        });
      },
      error: (req)=> {
        alert("Make sure you have all the fields entered.failed with status code:" + req.status);
      },
    });
  }

  request_users() {
    $.ajax("/api/v1/users", {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      success: (resp) => {
        store.dispatch({
          type: 'USERS_LIST',
          users: resp.data,
        });
      },
      error: (req)=> {
        alert("Make sure you have all the fields entered.failed with status code:" + req.status);
      },
    });
  }

  edit_task(data,task_id) {
    console.log(data);
    $.ajax("/api/v1/tasks"+"/"+task_id, {
      method: "PATCH",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({ token: data.token, task: data }),
      success: (resp) => {
        console.log("success edit");
        this.request_tasks();
        alert("Your task has been edited successfully");
      }
      ,
      error: (req)=> {
        alert("Make sure you have all the fields entered.failed with status code:" + req.status);
      },
    });
  }

  submit_task(data) {
    console.log(data);
    $.ajax("/api/v1/tasks", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify({ token: data.token, task: data }),
      success: (resp) => {
        store.dispatch({
          type: 'ADD_TASK',
          task: resp.data,
        });
        this.request_tasks();
        alert("Your task has been created successfully.");
      },
      error: (req)=> {
        alert("Make sure you have all the fields entered.failed with status code:" + req.status);
      },
    });
  }


  delete_task(data,task_id) {
    $.ajax("/api/v1/tasks" + "/" + task_id, {
     method: "delete",
     dataType: "json",
     contentType: "application/json; charset=UTF-8",
     data: "",
     success: () => {
      this.request_tasks();
     },
     error: (req)=> {
       alert("Make sure you have all the fields entered.failed with status code:" + req.status);
     },
    });
  }

  submit_user(data) {
    //console.log(data);
      $.ajax("/api/v1/users", {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: data,
        success: (resp) => {
          store.dispatch({
            type: 'ADD_USER',
            task: resp.data,
          });
          this.request_users();
          alert("Your user has been created.Please use the login form to enter the system");
        },
        error: (req)=> {
          alert("Make sure you have all the fields entered.failed with status code:" + req.status);
        },
      });
    }

  submit_login(data) {
    $.ajax("/api/v1/token", {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: JSON.stringify(data),
      success: (resp) => {
        store.dispatch({
          type: 'SET_TOKEN',
          token: resp,
        });
      },
      error: (req)=> {
        alert("Make sure you have all the fields entered.failed with status code" + req.status);
      },
    });
  }
}


export default new TheServer();

//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
