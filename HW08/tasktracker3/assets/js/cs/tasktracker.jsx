// microblog.jsx

import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter as Router, Route } from 'react-router-dom';
import { Provider, connect } from 'react-redux';

import Nav from './nav';
import Feed from './feed';
import Users from './users';
import Register from './register';
import TaskForm from './task-form';

export default function tasktracker_init(store) {
  ReactDOM.render(
   <Provider store={store}>
     <Tasktracker3 />
   </Provider>,
   document.getElementById('root'),
 );
}

let Tasktracker3 = connect((state) => state)((props) => {
  if(props.token) {
    return (
      <Router>
        <div>
          <Nav />
          <Route path="/" exact={true} render={() =>
            <div>
              <TaskForm users={props.users} root={this} />
            </div>
          } />
          <Route path="/feed" exact={true} render={() =>
              <Feed tasks={props.tasks} />
            } />
          <Route path="/users" render={() =>
            <Users users={props.users} />
          } />
          <Route path="/users/:user_id" render={({match}) =>
            <Feed tasks={_.filter(props.tasks, (pp) =>
              match.params.user_id == pp.user.id )
            } />
          } />
        </div>
      </Router>
    );
  }
  else {
    return (
      <Router>
        <div>
          <Nav />
            <Route path="/" exact={true} render={() =>
              <Register  />
            } />
        </div>
      </Router>
    );
  }

});



//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
