# Tests

Click **Start** to begin a 5-minute countdown:

<div>
  <button onclick="startTimer()">Start Timer</button>
  <span id="timer" style="font-size:1.5em; font-weight:bold; margin-left:10px;">05:00</span>

<script>
let timerInterval;

function runTimer(duration, display) {
  clearInterval(timerInterval);
  let timer = duration;

  timerInterval = setInterval(function () {
    let minutes = String(Math.floor(timer / 60)).padStart(2, "0");
    let seconds = String(timer % 60).padStart(2, "0");
    display.textContent = minutes + ":" + seconds;

    if (--timer < 0) {
      clearInterval(timerInterval);
      display.textContent = "TIME UP!";
    }
  }, 1000);
}

window.startTimer = function () {
  let fiveMinutes = 60 * 5;
  let display = document.getElementById("timer");
  runTimer(fiveMinutes, display);
};

</script>
</div>

end