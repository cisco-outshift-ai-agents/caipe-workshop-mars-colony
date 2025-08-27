# Mission Check 1 — Start Ignition: Download Mission and Learn the Controls

<div style="display: flex; align-items: center; gap: 12px;">
  <button
    onclick="createCountdown({duration: 900, target: 'timer1', doneText: 'FINISHED!', onComplete: () => alert('Timer complete!')}).start()"
    style="
      background: linear-gradient(90deg, #007cba 0%, #28a745 100%);
      color: #fff;
      border: none;
      border-radius: 6px;
      padding: 8px 18px;
      font-size: 1.1em;
      font-weight: bold;
      cursor: pointer;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      transition: background 0.2s;
    "
    onmouseover="this.style.background='linear-gradient(90deg, #28a745 0%, #007cba 100%)'"
    onmouseout="this.style.background='linear-gradient(90deg, #007cba 0%, #28a745 100%)'"
  >
    🚀 Start Mission &mdash; 15 min Timer
  </button>
  <span id="timer1" class="timer" style="font-family: monospace; font-size: 1.1em; color: #011234;">15:00</span>
</div>


<div style="border: 1px solid #007cba; border-left: 6px solid #007cba; background-color: #f0f8ff; color: #007cba; padding: 16px; margin: 18px 0; border-radius: 4px;">
  <strong>💡 General Lab Advice:</strong><br>
  <span style="color: #005fa3;">
    If your lab terminal reloads or disconnects, <b>all commands in these missions are designed to be safely re-run in the same sequence</b>. <br><br>
    <b>Can't finish a mission before the instructor moves on?</b> No problem! You can continue with the next mission and return to any earlier mission during breakouts or after the workshop. <br><br>
    <b>Each mission is designed to be independently runnable</b>—so you can follow along with the rest of the workshop.
  </span>
</div>


## Clone CAIPE

Clone the CAIPE (Community AI Platform Engineering) repository

```bash
cd $HOME/work
```

```bash
pwd
```

```bash
git clone https://github.com/cnoe-io/ai-platform-engineering
```

&nbsp;

## 🌟 **Support CAIPE with stars!** 🌟
Scan the QR code below or visit the CAIPE repository.
<br>
![Star CAIPE Repo](images/caipe-repo-qr.svg)
<br>

_Link:_ [https://github.com/cnoe-io/ai-platform-engineering](https://github.com/cnoe-io/ai-platform-engineering)

_Please give us a ⭐️ on GitHub. Your support helps grow our community and keeps the project thriving. 🚀_

&nbsp;

## 📖🛰️ Download Mission Manual 🚀

* Navigate to CAIP Docs - [https://cnoe-io.github.io/ai-platform-engineering/](https://cnoe-io.github.io/ai-platform-engineering/)
<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #007cba;">
  <h4 style="margin-top: 0; color: #007cba;">📖 Mission Manual Exploration Checklist</h4>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    Explore <strong>Getting Started</strong> &rarr; <strong>Quick Start</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    Explore <strong>Setup</strong> &rarr; <strong>Docker</strong> &rarr; <strong>Run with Docker Compose</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    Explore <strong>Setup</strong> &rarr; <strong>IDP Builder</strong>
  </label>
</div>

&nbsp;

## Agentic AI Concepts

Let's review some key concepts.

## What is an Agent?

An AI Agent is a system that uses a Large Language Model (LLM) to decide the flow of an application

- System Prompts
- Tools
- Memory (Short-term/Long-term)

## Anatomy of agent

![Anatomy of agent](images/agent-anatomy.svg)

## ReAct Loop

Reason and Act (ReAct) is a common
design pattern used in agentic systems to help LLMs decide the next action or tool to use

<center><img src="images/react-agent.svg" alt="Mission Control" width="200"></center>

### [Optional] Try it yourself: Create a Simple ReAct Agent

```bash
pip install -U langgraph "langchain[openai]"
```

```bash
# Create the Python file with LangChain Azure code
cat > $HOME/work/simple_react_agent.py << 'EOF'
from langgraph.prebuilt import create_react_agent  # Import helper to build a ReAct agent
from langchain_openai import AzureChatOpenAI       # Import Azure OpenAI LLM wrapper
import os
import random

# Tool 1: Simulate checking oxygen level in the Mars habitat
def check_oxygen_level() -> str:
    """Returns the current oxygen level in the Mars habitat."""
    print("[TOOL] check_oxygen_level was called")
    oxygen_level = round(random.uniform(18.0, 23.0), 1)
    return f"Oxygen level is optimal at {oxygen_level}%."

# Tool 2: Simulate checking a rover's battery status
def rover_battery_status(rover_name: str) -> str:
    """Returns the battery status for a given Mars rover."""
    print(f"[TOOL] rover_battery_status was called for rover: {rover_name}")
    battery_percent = random.randint(50, 99)
    return f"Rover {rover_name} battery at {battery_percent}% and functioning normally."

# Initialize the Azure OpenAI LLM using environment variables for deployment and API version
llm = AzureChatOpenAI(
    azure_deployment=os.getenv("AZURE_OPENAI_DEPLOYMENT"),      # e.g., "gpt-4o"
    openai_api_version=os.getenv("AZURE_OPENAI_API_VERSION")    # e.g., "2025-03-01-preview"
)

# Create a ReAct agent with the LLM and the two tools above
agent = create_react_agent(
    model=llm,
    tools=[check_oxygen_level, rover_battery_status],
    prompt="You are Mission Control for a Mars colony. Use your tools to help astronauts stay safe and keep the rovers running!"
)

# Run the agent with a user message asking about oxygen and a rover's battery
response = agent.invoke({"messages": [{"role": "user", "content": "Mission Control, what's the oxygen level and the battery status of Rover Spirit?"}]})

# Print the final AI response(s) to the user
print("Final Response:")
for message in response['messages']:
    # Each message is an object with a 'content' attribute (if present)
    if hasattr(message, 'content') and message.content:
        print(f"AI: {message.content}")
EOF
```

```bash
clear && ls -l
```

```bash
python3 $HOME/work/simple_react_agent.py
```

## What is a Multi-Agent System (MAS)?

A Multi-Agent System (MAS) is an agentic AI system composed of multiple, independent and interacting agents to achieve a common goal

Here are some example MAS architecture patterns:

### MAS Network/Swarm Architecture

MAS architecture where agents communitcate in a network like pub-sub, multi-cast or broadcast groups. Each agent is aware of and can hand-off to any other agent(s) in the group

<center><img src="images/mas-network.svg" alt="Mission Control" width="400"></center>

### MAS Planner/Deep Agent Architecture

Simple ReAct agents can yield agents that are “shallow”. They are particularly not very good at longer running tasks, more complex tasks with mutli-turn conversations.

A class MAS systems called “Deep Research” agents implement a planner based architecture, to plan a set of tasks and invoke the sub-agents, system tools in combination with Human-in-the-loop. Examples: Claude Code, AWS Q Cli etc.

<center><img src="images/mas-deep-agents.svg" alt="Mission Control" width="400"></center>

### MAS Supervisor Architecture

A supervisor agent orchestrates tasks with a bunch of sub-agents with the same system or over network

<center><img src="images/mas-supervisor.svg" alt="Mission Control" width="400"></center>

### MAS Hierarchical Supervisor Architecture

Supervisor of Supervisor agents

<center><img src="images/mas-hierarchical-supervisor.svg" alt="Mission Control" width="400"></center>

**References:**

* [Outshift blog - Deep dive into MAS](https://outshift.cisco.com/blog/architecting-jarvis-technical-deep-dive-into-its-multi-agent-system-design)
* [LangChain - Multi-agent systems](https://langchain-ai.github.io/langgraph/concepts/multi_agent/)
* [LangChain - Benchmarking Multi-Agent Architectures](https://blog.langchain.com/benchmarking-multi-agent-architectures/)

## CAPIE Architecture

<center><img src="https://raw.githubusercontent.com/cnoe-io/ai-platform-engineering/refs/heads/main/docs/docs/architecture/images/mas_architecture.svg" alt="Mission Control" width="400"></center>


## MCP (Model Context Protocol)

MCP (Model Context Protocol) standardizes how large language models (LLMs) can get application or API context such as tools, system prompts etc.

<center><img src="images/mcp.svg" alt="Mission Control" width="200"></center>


### [Optional] Try it yourself: Create a Simple ReAct Agent with MCP Server

```bash
pip install -U langgraph "langchain[openai]"
```

```bash
pip install langchain-mcp-adapters
```

```bash
# Create the MCP server file with Mars colony tools
cat > $HOME/work/simple_mars_mcp_server.py << 'EOF'
from mcp.server.fastmcp import FastMCP
import random

mcp = FastMCP("Mars Colony")

@mcp.tool()
def check_oxygen_level() -> str:
    """Returns the current oxygen level in the Mars habitat."""
    print("Tool called: check_oxygen_level")
    oxygen_level = round(random.uniform(18.0, 23.0), 1)
    return f"Oxygen level is optimal at {oxygen_level}%."

@mcp.tool()
def rover_battery_status(rover_name: str) -> str:
    """Returns the battery status for a given Mars rover."""
    print(f"Tool called: rover_battery_status (rover_name={rover_name})")
    battery_percent = random.randint(50, 99)
    return f"Rover {rover_name} battery at {battery_percent}% and functioning normally."

if __name__ == "__main__":
    mcp.run(transport="stdio")
EOF
```

```bash
clear && ls -l
```

```bash
# Create the MCP client file that connects to the Mars server
cat > $HOME/work/simple_react_agent_using_mcp.py << 'EOF'
import asyncio
from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client
from langchain_mcp_adapters.tools import load_mcp_tools
from langgraph.prebuilt import create_react_agent
from langchain_openai import AzureChatOpenAI
import os

mcp_server_file_path = os.path.join(os.environ["HOME"], "work", "simple_mars_mcp_server.py")

async def main():
    # Create server parameters for stdio connection
    server_params = StdioServerParameters(
        command="python3",
        # Make sure to update to the full absolute path to your simple_mars_mcp_server.py file
        args=[mcp_server_file_path],
    )

    async with stdio_client(server_params) as (read, write):
        async with ClientSession(read, write) as session:
            # Initialize the connection
            await session.initialize()

            # Get tools from the MCP server
            tools = await load_mcp_tools(session)

            # Initialize the Azure OpenAI LLM using environment variables
            llm = AzureChatOpenAI(
                azure_deployment=os.getenv("AZURE_OPENAI_DEPLOYMENT"),
                openai_api_version=os.getenv("AZURE_OPENAI_API_VERSION")
            )

            # Create a ReAct agent with the LLM and the MCP tools
            agent = create_react_agent(
                model=llm,
                tools=tools,
                prompt="You are Mission Control for a Mars colony. Use your tools to help astronauts stay safe and keep the rovers running!"
            )

            # Run the agent with a user message
            agent_response = await agent.ainvoke({
                "messages": [{"role": "user", "content": "Mission Control, what's the oxygen level and the battery status of Rover Spirit?"}]
            })

            # Print the final AI response(s) to the user
            print("Final Response:")
            for message in agent_response['messages']:
                if hasattr(message, 'content') and message.content:
                    print(f"AI: {message.content}")

if __name__ == "__main__":
    asyncio.run(main())
EOF
```

```bash
clear && ls -l
```

```bash
python3 $HOME/work/simple_react_agent_using_mcp.py
```

## Difference between an AI agent vs MCP server

Agentic Systems landscape is evolving rapidly, understanding the distinction between AI Agents and MCP Servers is crucial for building scalable agentic systems. While MCP Servers provide a standardized interface for tools and data sources, AI Agents leverage these capabilities to perform complex reasoning, planning, and execution tasks. As MCP protocol advances the lines are blurring, as of today, AI Agents are superset of what MCP server can do but some agents are directly exposed via MCP.

* [Agent Memory (Long-term and Short-term)](https://blog.langchain.com/memory-for-agents/)
* [Prompt/Context Engineering](https://blog.langchain.com/context-engineering-for-agents/)
* [Agent Orchestration](https://outshift.cisco.com/blog/architecting-jarvis-technical-deep-dive-into-its-multi-agent-system-design?search=jarvis)
* [Tool Pruning via RAG](https://github.com/langchain-ai/langgraph-bigtool)

**Reference blog:**

* [AI Agent vs MCP Server](https://cnoe-io.github.io/ai-platform-engineering/blog/ai-agent-vs-mcp-server)

## A2A Protocol

The Agent2Agent (A2A) Protocol is an open standard designed to enable seamless communication and collaboration between AI agents over the network.

<center><img src="images/a2a-ref.svg" alt="Mission Control" width="400"></center>

## AGNTCY Collective

The AGNTCY project provides the complete infrastructure stack for agent collaboration—discovery, identity, messaging, and observability that works across any vendor or framework. It is the foundational layer that lets specialized agents find each other, verify capabilities, and work together on complex problems.

![Mission Control](images/agntcy-arch.svg)

* [Agent Directory](https://docs.agntcy.org/dir/overview/)
  * [OASF Record](https://docs.agntcy.org/oasf/open-agentic-schema-framework/)
* [SLIM](https://docs.agntcy.org/messaging/slim-core/)
* [Agent Identity](https://identity-docs.outshift.com/docs/intro/)
* [Agntcy App SDK](https://github.com/agntcy/app-sdk)
* [coffeeAgntcy](https://github.com/agntcy/coffeeAgntcy/tree/main)

**Outshift Hosted services:**

- **Agent Directory** [https://agent-directory.outshift.com/explore](https://agent-directory.outshift.com/explore)
- **Agent Identity** [https://agent-identity.outshift.com/dashboard](https://agent-identity.outshift.com/dashboard)

**_Note: SLIM will be demo'ed in one of the missions. Additional bonus AGNTCY mission is available to try offline for a deeper dive into AGNTCY._**

**Reference:**

* [https://agntcy.org/](https://agntcy.org/)


<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #28a745;">
  <h4 style="margin-top: 0; color: #28a745;">🚀 Mission 1 Checklist</h4>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> ⭐ Starred the <a href="https://github.com/cnoe-io/ai-platform-engineering" target="_blank">CAIPE GitHub repository</a></strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> 📖 Checked out the <a href="https://cnoe-io.github.io/ai-platform-engineering/" target="_blank">CAIPE documentation</a></strong>
  </label>
  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> 🤖 Tried the Simple ReAct Agent example in your environment</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> 🔗 Tried the Simple ReAct Agent with MCP Server integration (see docs/examples)</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> 🌐 Visited the <a href="https://agntcy.org/" target="_blank">AGNTCY website</a> and explored <a href="https://github.com/agntcy/coffeeAgntcy" target="_blank">Coffee Agntcy</a></strong>
  </label>
</div>
