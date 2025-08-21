# Tests

Click **Start** to begin a 5-minute countdown:

<div>
  <button onclick="startTimer()">Start Timer</button>
  <span id="timer" style="font-size:1.5em; font-weight:bold; margin-left:10px;">05:00</span>
</div>

<script>
let timerInterval;

function startTimer() {
  clearInterval(timerInterval); // reset if already running

  let duration = 60 * 5; // 5 minutes
  let display = document.getElementById("timer");

  timerInterval = setInterval(function () {
    let minutes = String(parseInt(duration / 60, 10)).padStart(2, "0");
    let seconds = String(parseInt(duration % 60, 10)).padStart(2, "0");

    display.textContent = minutes + ":" + seconds;

    if (--duration < 0) {
      clearInterval(timerInterval);
      display.textContent = "TIME UP!";
    }
  }, 1000);
}
</script>
