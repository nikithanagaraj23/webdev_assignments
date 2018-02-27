// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import $ from "jquery";
// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

var block_id;
function update_buttons() {
  $('.manage-button').each( (_, bb) => {
    let user_id = $(bb).data('user-id');
    let manage = $(bb).data('manage');
    if (manage != "") {
      $(bb).text("Unmanage");
    }
    else {
      $(bb).text("Manage");
    }
  });
}

function set_button(user_id, value) {
  $('.manage-button').each( (_, bb) => {
    if (user_id == $(bb).data('user-id')) {
      $(bb).data('manage', value);
    }
  });
  update_buttons();
}

function manage(user_id) {
  let text = JSON.stringify({
    manage: {
        manager_id: current_user_id,
        managee_id: user_id
      },
  });

console.log("here");
  $.ajax(manage_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(user_id, resp.data.id); },
  });
}

function unmanage(user_id, manage_id) {
  $.ajax(manage_path + "/" + manage_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(user_id, ""); },
  });
}

function manage_click(ev) {
  let btn = $(ev.target);
  let manage_id = btn.data('manage');
  let user_id = btn.data('user-id');
  if (manage_id != "") {
    unmanage(user_id, manage_id);
  }
  else {
    manage(user_id);
  }
}

function init_manage() {
  if (!$('.manage-button')) {
    return;
  }

  $(".manage-button").click(manage_click);
  update_buttons();
}

$(init_manage);


var start_clicked;
function stop_timer_clicked(ev){
  if (start_clicked){
    var btn = $(ev.target);
    var task_id = btn.data('task-id');
    stop = btn.data('stop-time');
    var text = JSON.stringify({
      timeblock: {
        end_time: stop
      },
    });
    $.ajax(timeblock_path + '/' + block_id, {
      method: "PATCH",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {   window.location.reload(); },
      });
      start_clicked = false;
  }
  else{
    alert("First Start Timer");
  }

}

function start_timer_clicked(ev){
  if(start_clicked){
      alert("Timer already running.Click Stop to stop the timer");
  }
  else{
    start_clicked = true;
    var btn = $(ev.target);
    var task_id = btn.data('task-id');
    var start = btn.data('start-time');
    console.log("start inside",start);
    var text = JSON.stringify({
      timeblock: {
        timer_id: task_id,
        start_time: start,
        end_time: start
      },
    });
    $.ajax(timeblock_path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => { block_id = resp.data.id; },
      });
  }
}




function add_time_block(ev){
  var btn = $(ev.target);
  var task_id = btn.data('task-id');
  var starting_time = new Date($(this).closest('.timeblock').find(".starting-time").val()).toISOString();
  var stop_time =  new Date($(this).closest('.timeblock').find(".stop-time").val()).toISOString();

  console.log(starting_time);
  console.log(stop_time);

  var text = JSON.stringify({
    timeblock: {
        timer_id: task_id,
        start_time: starting_time,
        end_time: stop_time
      },
  });
  $.ajax(timeblock_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { console.log("sucess");
    window.location.reload();
  },
  });

}


function delete_timeblock (ev){
  var btn = $(ev.target);
  var task_id = btn.data('task-id');
  var timeblock_id = btn.data('time-id');
  $.ajax(timeblock_path + "/" + timeblock_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { console.log("sucess");
    window.location.reload();
  },
  });
}

function edit_timeblock (ev){
  var btn = $(ev.target);
  var task_id = btn.data('task-id');
  var timeblock_id = btn.data('time-id');
  var starting_time = new Date($(this).closest('.timeblock').find(".starting-time").val()).toISOString();
  var stop_time =  new Date($(this).closest('.timeblock').find(".stop-time").val()).toISOString();
  console.log(starting_time);
  console.log(stop_time);
  var text = JSON.stringify({
    timeblock: {
        timer_id: task_id,
        start_time: starting_time,
        end_time: stop_time
      },
  });
  $.ajax(timeblock_path + '/' + timeblock_id, {
    method: "PATCH",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { window.location.reload();},
    });
}

function show_edit(ev){
  $(this).siblings('.edit-timeblock').slideToggle("slow");
}

function init_timer() {
  if (!$('.start-button')) {
    return;
  }
  $(".start-button").click(start_timer_clicked);
  $(".stop-button").click(stop_timer_clicked);
  $(".add-time").click(add_time_block);
  $(".delete-entry").click(delete_timeblock);
  $('.edit-time').click(edit_timeblock);
  $('.edit-entry').click(show_edit);
}
$(init_timer);


// References
// https://stackoverflow.com/questions/948532/how-do-you-convert-a-javascript-date-to-utc
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/14-assoc-and-ajax/notes.html
// http://www.ccs.neu.edu/home/ntuck/courses/2018/01/cs4550/notes/12-microblog/notes.html
// https://stackoverflow.com/questions/40962261/how-to-parse-datetime-in-elixir?rq=1
// https://hexdocs.pm/ecto/Ecto.Date.html#content
