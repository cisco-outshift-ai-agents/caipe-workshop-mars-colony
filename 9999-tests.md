<div id="timer" style="font-size: 1.5em; font-weight: bold;"></div>

<script>
function startTimer(duration, display) {
    let timer = duration, minutes, seconds;
    setInterval(function () {
        minutes = String(parseInt(timer / 60, 10)).padStart(2, "0");
        seconds = String(parseInt(timer % 60, 10)).padStart(2, "0");

        display.textContent = minutes + ":" + seconds;

        if (--timer < 0) {
            timer = duration; // restart or remove this line to stop
        }
    }, 1000);
}

window.onload = function () {
    let fiveMinutes = 60 * 5, // 5 minute countdown
        display = document.querySelector('#timer');
    startTimer(fiveMinutes, display);
};
</script>