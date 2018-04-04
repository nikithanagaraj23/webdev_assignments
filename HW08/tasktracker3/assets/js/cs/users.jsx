
// users.jsx

import React from 'react';
import { Link } from 'react-router-dom';

function User(params) {
  return <p className="list-users">{params.user.name} - <Link to={"/users/" + params.user.id}>View tasks</Link></p>;
}

export default function Users(params) {
  let users = _.map(params.users, (uu) => <User key={uu.id} user={uu} />);
  return <div>
    { users }
  </div>;
}
