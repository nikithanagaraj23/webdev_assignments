

import React from 'react';
import { connect } from 'react-redux';
import { Link } from 'react-router-dom';
import { Button, FormGroup, Label, Input } from 'reactstrap';
import api from '../api';

function TaskForm(params) {

  function update(ev) {
   let tgt = $(ev.target);
   let data = {};
   data[tgt.attr('name')] = tgt.val();
   let action = {
     type: 'UPDATE_FORM',
     data: data,
   };
   params.dispatch(action);
 }

 function updatecheckbox(ev) {
  let tgt = $(ev.target);
  let data = {};
  data[tgt.attr('name')] = tgt.val();
  data["completed"] = params.form.completed ?  undefined : "checked"
  let action = {
    type: 'UPDATE_FORM',
    data: data,
  };
  params.dispatch(action);
}

 function submit(ev) {
   api.submit_task(params.form);
 }

 function edit_task(ev) {
  console.log(params.form.id);
  console.log(params.form);
  api.edit_task(params.form,params.form.id);
 }
  // let users = _.map(params.users, (uu) => <option key={uu.id} value={uu.id}>{uu.name}</option>);
  let usernames = _.map(params.users, (uu) => <option key={uu.id} value={uu.name}>{uu.name}</option>);

  return <div style={{padding: "4ex"}}>
    <h2>New Task</h2>
    <FormGroup>
      <Label for="user_id">User</Label>
      <Input type="text" name="user_id" value={params.form.user_id} onChange={update}/>
    </FormGroup>
    <FormGroup>
      <Label for="title">Title</Label>
      <Input type="text" name="title" value={params.form.title} placeholder="Enter the title of the task" onChange={update}/>
    </FormGroup>
    <FormGroup>
      <Label for="description">Description</Label>
      <Input type="text" name="description" value={params.form.description} placeholder="Enter the Description of the task" onChange={update} />
    </FormGroup>
    <FormGroup>
      <Label for="assignee">Assignee</Label>
        <Input type="select" name="assignee" onChange={update}  value={params.form.assignee} >
          { usernames }
        </Input>
    </FormGroup>
    <FormGroup>
      <Label for="timetaken">TimeTaken</Label>(in minutes as multiples for 15)
      <Input type="number" name="timetaken" step= "15" min="0" placeholder="0" defaultValue="0" value={params.form.timetaken} onChange={update}/>
    </FormGroup>
    <FormGroup className="completed">
      <Label for="completed" >Completed</Label>
      <Input type="checkbox" className="checkbox" name="completed" checked={params.form.completed ? "checked" : undefined } onChange={updatecheckbox} />
    </FormGroup>
    { params.form.id ? <div><Link to="/feed"><Button onClick={edit_task} color="primary">Save</Button></Link> <Link to="/feed"><Button color="secondary">Back to Feed</Button> </Link></div> :
     <Link to="/feed"><Button onClick={submit} color="primary">Create Task</Button></Link> }
  </div>;
}

function state2props(state) {
  console.log("rerender", state);
  return { form: state.form };
}

// Export the result of a curried function call.
export default connect(state2props)(TaskForm);


//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
