# Mission Check 1 — Download mission and learn the controls

<button id="start-timer-btn" style="padding: 8px 18px; font-size: 1.1rem; border-radius: 10px; background: linear-gradient(90deg, #ff9800 0%, #ff5722 100%); color: #fff; border: none; box-shadow: 0 2px 8px rgba(0,0,0,0.10); cursor: pointer;">
  ⏰ Start 15-Min Timer 🚀 <span id="timer-btn-display" style="margin-left: 12px; font-weight: bold;">15:00</span>
</button>
<script>
/**
 * Create a countdown tied to one element.
 * @param {Object} opts
 * @param {number} opts.duration           - total seconds (e.g., 90)
 * @param {HTMLElement|string} opts.target - element or element id to update
 * @param {string} [opts.doneText]         - text when finished (default "TIME IS UP!")
 * @param {function} [opts.onComplete]     - optional callback when timer finishes naturally
 * @returns {{ start:Function, pause:Function, stop:Function, reset:Function }}
 */
window.createCountdown = function({ duration, target, doneText = "TIME IS UP!", onComplete }) {
  let timeLeft = duration;
  let interval = null;
  let isRunning = false;

  const targetEl = typeof target === 'string' ? document.getElementById(target) : target;

  function formatTime(seconds) {
    const m = Math.floor(seconds / 60);
    const s = seconds % 60;
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  }

  function updateDisplay() {
    if (targetEl) {
      targetEl.textContent = timeLeft > 0 ? formatTime(timeLeft) : doneText;
    }
  }

  function tick() {
    timeLeft--;
    updateDisplay();

    if (timeLeft <= 0) {
      stop();
      if (onComplete) onComplete();
    }
  }

  function start() {
    if (!isRunning && timeLeft > 0) {
      isRunning = true;
      interval = setInterval(tick, 1000);
    }
  }

  function pause() {
    if (isRunning) {
      isRunning = false;
      clearInterval(interval);
    }
  }

  function stop() {
    isRunning = false;
    clearInterval(interval);
    timeLeft = 0;
    updateDisplay();
  }

  function reset() {
    stop();
    timeLeft = duration;
    updateDisplay();
  }

  // Initialize display
  updateDisplay();

  return { start, pause, stop, reset };
};

document.addEventListener('DOMContentLoaded', function() {
  const timerBtn = document.getElementById('start-timer-btn');
  const timerDisplay = document.getElementById('timer-btn-display');

  if (timerBtn && timerDisplay) {
    const countdown = createCountdown({
      duration: 15 * 60, // 15 minutes
      target: timerDisplay,
      doneText: "🎉",
      onComplete: function() {
        timerBtn.disabled = false;
      }
    });

    timerBtn.onclick = function() {
      timerBtn.disabled = true;
      countdown.reset();
      countdown.start();
    };
  }
});
</script>


## Clone CAIPE

Clone the CAIPE (Community AI Platform Engineering) repository


!!! note
    🌟 **Support CAIPE with stars!** 🌟
    Scan the QR code below or visit the CAIPE repository.
    <br>
    ![Star CAIPE Repo](images/caipe-repo-qr.svg)
    <br>
    Please give us a ⭐️ on GitHub. Your support helps grow our community and keeps the project thriving. 🚀

```bash
cd $HOME/work
```

```bash
pwd
```

```bash
git clone https://github.com/cnoe-io/ai-platform-engineering
```

## Download Mission manual

* Navigate to [https://cnoe-io.github.io/ai-platform-engineering/](https://cnoe-io.github.io/ai-platform-engineering/)
* Explore the pages
  * `Getting Started` -> `Quick Start`
  * `Setup` -> `Docker` -> `Run with Docker Compose`
  * `Setup` -> `IDP Builder`

## Agentic AI Concepts

Let's review some key concepts.

### What is an Agent?

An AI Agent is a system that uses a Large Language Model (LLM) to decide the flow of an application

### ReAct Loop

Reason and Act (ReAct) is a common
design pattern used in agentic systems to help LLMs decide the next action or tool to use

<img src="images/react-agent.svg" alt="Mission Control" width="200">


### What is a Multi-Agent System (MAS)?

A Multi-Agent System (MAS) is an agentic AI system composed of multiple, independent and interacting agents to achieve a common goal

Here are some example MAS architecture patterns:

### MAS Network/Swarm Architecture

MAS architecture where agents communitcate in a network like pub-sub, multi-cast or broadcast groups. Each agent is aware of and can hand-off to any other agent(s) in the group

<img src="images/mas-network.svg" alt="Mission Control" width="400">

### MAS Planner/Deep Agent Architecture

Simple ReAct agents can yield agents that are “shallow”. They are particularly not very good at longer running tasks, more complex tasks with mutli-turn conversations.

A class MAS systems called “Deep Research” agents implement a planner based architecture, to plan a set of tasks and invoke the sub-agents, system tools in combination with Human-in-the-loop. Examples: Claude Code, AWS Q Cli etc.

<img src="images/mas-deep-agents.svg" alt="Mission Control" width="400">

### MAS Supervisor Architecture

A supervisor agent orchestrates tasks with a bunch of sub-agents with the same system or over network

<img src="images/mas-supervisor.svg" alt="Mission Control" width="400">

### MAS Hierarchical Supervisor Architecture

Supervisor of Supervisor agents

<img src="images/mas-hierarchical-supervisor.svg" alt="Mission Control" width="400">

**References:**

* [Outshift blog - Deep dive into MAS](https://outshift.cisco.com/blog/architecting-jarvis-technical-deep-dive-into-its-multi-agent-system-design)
* [LangChain - Multi-agent systems](https://langchain-ai.github.io/langgraph/concepts/multi_agent/)
* [LangChain - Benchmarking Multi-Agent Architectures](https://blog.langchain.com/benchmarking-multi-agent-architectures/)

### CAPIE Architecture

<img src="https://raw.githubusercontent.com/cnoe-io/ai-platform-engineering/refs/heads/main/docs/docs/architecture/images/mas_architecture.svg" alt="Mission Control" width="400">


## MCP (Model Context Protocol)

MCP (Model Context Protocol) standardizes how large language models (LLMs) can get application or API context such as tools, system prompts etc.

<img src="images/mcp.svg" alt="Mission Control" width="200">

## Difference between an AI agent vs MCP server

Agentic Systems landscape is evolving rapidly, understanding the distinction between AI Agents and MCP Servers is crucial for building scalable agentic systems. While MCP Servers provide a standardized interface for tools and data sources, AI Agents leverage these capabilities to perform complex reasoning, planning, and execution tasks. As MCP protocol advances the lines are blurring, as of today, AI Agents are superset of what MCP server can do but some agents are directly exposed via MCP.

* [Agent Memory (Long-term and Short-term)](https://blog.langchain.com/memory-for-agents/)
* [Prompt/Context Engineering](https://blog.langchain.com/context-engineering-for-agents/)
* Agent Orchestration
* [Tool Pruning via RAG](https://github.com/langchain-ai/langgraph-bigtool)

**Reference blog:**

* [AI Agent vs MCP Server](https://cnoe-io.github.io/ai-platform-engineering/blog/ai-agent-vs-mcp-server)

## A2A Protocol

The Agent2Agent (A2A) Protocol is an open standard designed to enable seamless communication and collaboration between AI agents over the network.

<img src="images/a2a-ref.svg" alt="Mission Control" width="400">

## AGNTCY Collective

The AGNTCY project provides the complete infrastructure stack for agent collaboration—discovery, identity, messaging, and observability that works across any vendor or framework. It is the foundational layer that lets specialized agents find each other, verify capabilities, and work together on complex problems.

<img src="images/agntcy-arch.svg" alt="Mission Control" width="600">

* [Agent Directory](https://docs.agntcy.org/dir/overview/)
  * [OASF Record](https://docs.agntcy.org/oasf/open-agentic-schema-framework/)
* [SLIM](https://docs.agntcy.org/messaging/slim-core/)
* [Agent Identity](https://docs.agntcy.org/messaging/slim-core/)
* [Agntcy App SDK](https://github.com/agntcy/app-sdk)
* [coffeeAgntcy](https://github.com/agntcy/coffeeAgntcy/tree/main)

**_Note: More bonus missions are available to try offline for a deeper dive into AGNTCY._**

**Reference:**

* [https://agntcy.org/](https://agntcy.org/)

## Misson Checks

* [ ] 📝 Clone CAIPE
* [ ] 📝 Navigate to Docs
* [ ] 📝 Agentic AI Concepts
