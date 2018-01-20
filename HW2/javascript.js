// ALerts the current number in the header
function showAlert() {
  var number = document.getElementById('header').innerHTML;
  alert(number);
}

//Increments the number in the header
function incrementNumber() {
  var heading = document.getElementById('header');
  var number = document.getElementById('header').innerHTML;
  number++;
  heading.innerHTML = number;
}

//Adds a new paragragh to the bottom with the current value of the header
function addParagragh() {
  var paragraph = document.createElement("p");
  var number = document.getElementById('header').innerHTML;
  paragraph.innerHTML = number;
  //console.log(paragraph);
  document.body.appendChild(paragraph);
}


//displays the data in the corresponding right column
function showfirstData(ev) {
  var rightContent = document.getElementById("right--content");
  var newdata = document.getElementById("first-data");
  rightContent.innerHTML = newdata.innerHTML;
}
function showsecondData(ev) {
  var rightContent = document.getElementById("right--content");
  var newdata = document.getElementById("second-data");
  rightContent.innerHTML = newdata.innerHTML;
}
function showthirdData(ev) {
  var rightContent = document.getElementById("right--content");
  var newdata = document.getElementById("third-data");
  rightContent.innerHTML = newdata.innerHTML;
}
