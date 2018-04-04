import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

/*
 *  state layout:
 *  {
 *   tasks: [... tasks ...],
 *   users: [... Users ...],
 *   form: {
 *     user_id: null,
 *     body: "",
 *   }
 * }
 *
 * */

 function tasks(state = [], action) {
   switch (action.type) {
   case 'TASKS_LIST':
     return [...action.tasks];
   case 'ADD_TASK':
     return [...state, action.tasks];
   default:
     return state;
   }
 }


function users(state = [], action) {
  switch (action.type) {
   case 'USERS_LIST':
     return [...action.users];
   default:
     return state;
   }
}

let empty_form = {
  user_id: "",
  completed: undefined,
  description: "",
  timetaken: null,
  assignee: "",
  title: ""
};

function form(state = empty_form, action) {
  switch (action.type) {
    case 'UPDATE_FORM':
      if(Object.keys(action.data)[0] == "completed") {
        if(action.data["completed"] == "checked") {
          action.data["completed"] = true;
          return Object.assign({}, state, action.data);
        }
        else {
          action.data["completed"] = false;
          return Object.assign({}, state, action.data);
        }
      }
      else {
        return Object.assign({}, state, action.data);
      }
      //return Object.assign({}, state, action.data);
    case 'CLEAR_FORM':
     return empty_form;
    case 'SET_TOKEN':
     return Object.assign({}, state, action.token);
    default:
      return state;
  }
}

function token(state = null, action) {
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token;
    default:
      return state;
  }
}

let empty_login = {
  name: "",
  pass: "",
};

function login(state = empty_login, action) {
  switch (action.type) {
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

function root_reducer(state0, action) {
  let reducer = combineReducers({tasks, users, form, token, login});
  // let reducer = combineReducers({tasks, users, form});
  let state1 = reducer(state0, action);
  return deepFreeze(state1);
};

let store = createStore(root_reducer);
export default store;


//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
