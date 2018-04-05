

import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';

function EditForm(params) {

  function update(ev) {
   let tgt = $(ev.target);
   let data = {};
   data[tgt.attr('name')] = tgt.val();
   let action = {
     type: 'UPDATE_EDIT_FORM',
     data: data,
   };
   params.dispatch(action);
 }

 function updatecheckbox(ev) {
  let tgt = $(ev.target);
  let data = {};
  data[tgt.attr('name')] = tgt.val();
  data["completed"] = params.editform.completed ?  undefined : "checked";
  let action = {
    type: 'UPDATE_EDIT_FORM',
    data: data,
  };
  params.dispatch(action);
}

 function submit(ev) {
   api.submit_task(params.editform);
 }

 function edit_task(ev) {
  console.log(params.editform.id);
  console.log(params.editform);
  api.edit_task(params.editform,params.editform.id);
 }
  // let users = _.map(params.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);

  let usernames = _.map(params.users, (uu) => <option key={uu.id} value={uu.name}>{uu.name}</option>);
  console.log(" params",params.editform.user);

  return <div style={{padding: "4ex"}}>
    <h2>Edit Task</h2>

    <FormGroup>
      <Label for="title">Title</Label>
      <Input type="text" name="title" value={params.editform.title} placeholder="Enter the title of the task" onChange={update}/>
    </FormGroup>
    <FormGroup>
      <Label for="description">Description</Label>
      <Input type="text" name="description" value={params.editform.description} placeholder="Enter the Description of the task" onChange={update} />
    </FormGroup>
    <FormGroup>
      <Label for="assignee">Assignee</Label>
        <Input type="select" name="assignee" onChange={update}  value={params.editform.assignee} >
          { usernames }
        </Input>
    </FormGroup>
    <FormGroup>
      <Label for="timetaken">TimeTaken</Label>(in minutes as multiples for 15)
      <Input type="number" name="timetaken" step= "15" min="0" placeholder="0" defaultValue="0" value={params.editform.timetaken} onChange={update}/>
    </FormGroup>
    <FormGroup className="completed">
      <Label for="completed" >Completed</Label>
      <Input type="checkbox" className="checkbox" name="completed" checked={params.editform.completed ? "checked" : undefined } onChange={updatecheckbox} />
    </FormGroup>
     <Button onClick={edit_task} color="primary">Save</Button>
  </div>;
}

function state2props(state) {
  console.log("rerender", state);
  return { editform: state.editform,
  users: state.users };
}

// Export the result of a curried function call.
export default connect(state2props)(EditForm);


//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
