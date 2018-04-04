
// feed.jsx

import React from 'react';
import Task from './task';

export default function Feed(params) {
  let task = _.map(params.tasks, (pp,i) => <Task key={i} task={pp} />);
  return <div>
    { task }
  </div>;
}


//
// References:
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/20-redux/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/
// https://github.com/NatTuck/nu_mart/blob/prep-1016/lib/nu_mart/accounts/user.ex
// https://www.w3schools.com/bootstrap/bootstrap_alerts.asp
