import React from 'react';
import { NavLink } from 'react-router-dom';
import { Form, FormGroup, NavItem, Input, Button ,Label} from 'reactstrap';
import { connect } from 'react-redux';
import api from '../api';


export default function Register(params) {

  function submit(ev) {
    ev.preventDefault();
    let tgt = $(ev.target);
    let data = tgt.serialize();
    var name = tgt.find('input[name="name"]').val();
    var password = tgt.find('input[name="password"]').val();
   var text = JSON.stringify({
     user: {
       name: name,
       password: password
      }
      });
    api.submit_user(text)
  }

  return(
    <div>
      <Form onSubmit={submit} className="register-form">
        <FormGroup>
          <label>User Name</label>
          <Input type="text" name="name" id="#name" placeholder="name"/>
        </FormGroup>
        <FormGroup>
            <label>Password</label>
          <Input type="password" id="#password" name="password" placeholder="password"  />
        </FormGroup>
        <Button type="submit">Sign up</Button>
      </Form>
  </div>);

}



//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
