import React from 'react';
import { NavLink } from 'react-router-dom';
import { Form, FormGroup, NavItem, Input, Button } from 'reactstrap';
import { connect } from 'react-redux';
import api from '../api';
import { Route, Redirect, browserHistory,hashHistory } from 'react-router';

let LoginForm = connect(({login}) => {return {login};})((props) => {
  function update(ev) {
    let tgt = $(ev.target);
    console.log(tgt);
    let data = {};
    data[tgt.attr('name')] = tgt.val();
    props.dispatch({
      type: 'UPDATE_LOGIN_FORM',
      data: data,
    });
  }

  function create_token(ev) {
    api.submit_login(props.login);
    console.log(props.login);
  }


  return <div className="navbar-text">
    <Form inline>
      <FormGroup>
        <Input type="text" name="name" placeholder="name"
               value={props.login.name} onChange={update} />
      </FormGroup>
      <FormGroup>
        <Input type="password" name="pass" placeholder="password"
               value={props.login.pass} onChange={update} />
      </FormGroup>
      <Button onClick={create_token}>Log In</Button>
    </Form>
  </div>;
});

let Session = connect(({token}) => {return {token};})((props) => {
// console.log(props);  ``

function logout(ev){
  window.location.reload();
}
  return <div className="navbar-text">
    logged in as  { props.token.user_id}
    <Button onClick={logout} color="secondary">logout</Button>

  </div>;
});

function Nav(props) {
  let session_info;
  if (props.token) {
    session_info = <Session token={props.token} /> ;
    return (
      <nav className="navbar navbar-dark bg-dark navbar-expand">
        <span className="navbar-brand">
          TaskTracker3
        </span>
        <ul className="navbar-nav mr-auto">
          <NavItem>
            <NavLink to="/" exact={true} activeClassName="active" className="nav-link">Create Task</NavLink>
          </NavItem>
          <NavItem>
            <NavLink to="/feed" href="#" exact={true} activeClassName="active" className="nav-link">Feed</NavLink>
          </NavItem>
          <NavItem>
            <NavLink to="/users" href="#" activeClassName="active" className="nav-link">All Users</NavLink>
          </NavItem>
        </ul>
        { session_info }
      </nav>
    )
  }
  else {
    session_info = <LoginForm />
      return (
        <nav className="navbar navbar-dark bg-dark navbar-expand">
          <span className="navbar-brand">
            TaskTracker3
          </span>
          <ul className="navbar-nav mr-auto">
            <NavItem>
              <NavLink to="/" exact={true} href="#" activeClassName="active" className="nav-link">Register</NavLink>
            </NavItem>
          </ul>
          { session_info }
        </nav>
      );
  }
}

function state2props(state) {
  return {
    token: state.token,
  };
}

export default connect(state2props,null,null,{
  pure: false
})(Nav);



//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
// https://github.com/reactjs/react-redux/blob/master/docs/troubleshooting.md
