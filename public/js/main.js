// Setup
var play_interval;

// Get a random name
function getNomeAleatorio() {

  let url = '/nome/aleatorio';

  fetch(url)
  .then(res => res.json())
  .then((out) => {
    // Refresh Display
    //refreshDisplay(out[0], out[1], out[2])
    fadeRefreshDisplay(out[0], out[1], out[2])
  })
  .catch(err => { throw err });
}


// Refresh name with a fade out and fadein
function fadeRefreshDisplay(nome, apelido1, apelido2) {
  nome_aleatorio = nome + " " + apelido1 + " " + apelido2
  $("#nome_aleatorio").animate({'opacity': 0}, 500, function () {
    $(this).text(nome_aleatorio);
  }).animate({'opacity': 1}, 500);
}



// Start Play
function play() {
  play_interval = setInterval(getNomeAleatorio, 3000);
}

// Pause Play
function pause() {
  clearTimeout(play_interval);
}

// Enable controls
function enableControls() {

  // Play/Pause control
  document.getElementById('play_control').onclick=function(){
    if (this.innerHTML == "►") {
      getNomeAleatorio();
      play();
      this.innerHTML = "&#10074;&#10074;"
    } else {
      pause();
      this.innerHTML = "&#9658;"
    }
  }
}