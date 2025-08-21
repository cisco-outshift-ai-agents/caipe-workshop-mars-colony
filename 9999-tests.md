# Tests

<button onclick="createCountdown({duration: 10, target: 'timer1', doneText: 'FINISHED!', onComplete: () => alert('Timer complete!')}).start()">Start timer 1</button>
<span id="timer1" class="timer">00:10</span>


<button id="timer2" onclick="createCountdown({duration: 10, target: 'timer2', doneText: 'FINISHED!', onComplete: () => alert('Timer complete!')}).start()">Start timer 2</button>
