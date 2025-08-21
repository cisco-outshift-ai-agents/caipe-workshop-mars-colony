# Tests

<button onclick="createCountdown({
  duration: 10,
  target: 'timer1',
  doneText: 'FINISHED!',
  onComplete: () => alert('Timer complete!')
}).start()">Start 10s Timer</button>
<span id="timer1" class="timer"></span>
