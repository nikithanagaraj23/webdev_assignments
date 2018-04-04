

import React from 'react';
import { Card, CardBody } from 'reactstrap';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Route, Redirect} from 'react-router';

function Task(params) {
  function delete_task(ev) {
    // console.log(params.task.id);
    api.delete_task(params.task,params.task.id);
  }

  function edit_task(ev) {
   let action = {
     type: 'UPDATE_FORM',
     data: params.task,
   };
   params.dispatch(action);
  }

  let task = params.task;
  return <Card>
    <CardBody>
      <div>
        <p><b>Title: </b>{ task.title }</p>
        <p><b>Assigned to:</b> { task.assignee }</p>
        <div className="row">
          <div className="col-md-9">
            <p><b>Description:</b> { task.description }</p>
          </div>
          <div className="col-md-3">
              <p className="timetaken-view"><b>TimeTaken: </b>{ task.timetaken }mins</p>
          </div>
        </div>
        <p><b>Status: </b>{ task.completed ? "Task Completed": "Pending" }</p>
        <Button onClick={delete_task} className="btn btn-danger" >Delete</Button>
         <Link to="/">
           <Button onClick={edit_task} className="edit--button">Edit</Button>
        </Link>
      </div>
    </CardBody>
  </Card>;
}


function state2props(state) {
  return { form: state.form };
}

// Export the result of a curried function call.
export default connect(state2props)(Task);


//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
