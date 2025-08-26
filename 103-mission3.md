# Mission Check 3 — Multi-Agent Weather + Petstore System

## Overview

In this mission, you'll run a **multi-agent system** that coordinates critical Mars colony operations across multiple domains:

- **🐾 Petstore Agent**: Manages colony biological companions from Mission 2 - essential for morale and psychological well-being during long Mars deployments
- **🌤️ Weather Agent**: Monitors Earth weather conditions to optimize interplanetary trade routes and supply deliveries - knowing Earth's weather patterns helps predict launch windows and cargo capacity for supply missions
- **🧠 Supervisor Agent**: Acts as the colony's central command coordinator, orchestrating complex operations that require data from multiple specialized systems

This demonstrates **agent-to-agent communication** where the supervisor can intelligently route requests to specialized agents and combine their responses.

## Step 1: Configure Multi-Agent Environment

**💡 Tip:** You can also click the IDE button on the top right of this page to open the `.env` file in the IDE and edit it that way. Edit lines 1-18 with the following agent configuration:

Run the below command to update the `.env` file with the following agent configuration:

```bash
sed -i \
  -e 's|^ENABLE_WEATHER_AGENT=.*|ENABLE_WEATHER_AGENT=true|' \
  -e 's|^ENABLE_PETSTORE_AGENT=.*|ENABLE_PETSTORE_AGENT=true|' \
  -e 's|^SKIP_AGENT_CONNECTIVITY_CHECK=.*|SKIP_AGENT_CONNECTIVITY_CHECK=false|' \
  -e 's|^AGENT_CONNECTIVITY_ENABLE_BACKGROUND=.*|AGENT_CONNECTIVITY_ENABLE_BACKGROUND=true|' \
  .env
```

The connectivity check is performed when the supervisor agent starts. It will check if the petstore and weather agents are running and if they are, it will add them to the supervisor agent's memory.

The dynamic monitoring is performed in the background and will check if the petstore and weather agents are running every 5 minutes. If any of the agents is unavailable, the supervisor agent will remove it from available tools until it is back online.

## Step 2: Start Multi-Agent System

### Launch the multi-agent stack with Docker Compose:

For this mission, we will use the HTTP mode. You can also try out the STDIO mode afterward if you prefer.

#### HTTP mode

```bash
IMAGE_TAG=latest MCP_MODE=http docker compose -f workshop/docker-compose.mission3.yaml --profile=p2p up
```
#### [Optional] STDIO mode

```bash
IMAGE_TAG=latest MCP_MODE=stdio docker compose -f workshop/docker-compose.mission3.yaml --profile=p2p up
```

### What happens:

- ⏬ Downloads the latest supervisor, petstore and weather agent images from the registry
- 🌐 Exposes the supervisor agent on `http://localhost:8000`
- 🌐 Exposes the petstore agent on `http://localhost:8009`
- 🌐 Exposes the weather agent on `http://localhost:8010`
- 🔗 Uses peer-to-peer (p2p) mode to connect the supervisor agent to the petstore and weather agents
- 📋 Shows logs directly in terminal for all three agents

### Expected output:
Look out for the following logs for each agent:

**💡 Tip:** You can also see the logs for a single agent by running `docker logs -f <platform-engineer-p2p|agent-weather-p2p|agent-petstore-p2p>` on a new terminal.

#### Petstore agent logs:
```
...
agent-petstore-p2p     | ===================================
agent-petstore-p2p     |        PETSTORE AGENT CONFIG
agent-petstore-p2p     | ===================================
agent-petstore-p2p     | AGENT_URL: http://0.0.0.0:8000
agent-petstore-p2p     | ===================================
agent-petstore-p2p     | Running A2A server in p2p mode.
agent-petstore-p2p     | INFO:     Started server process [1]
agent-petstore-p2p     | INFO:     Waiting for application startup.
agent-petstore-p2p     | INFO:     Application startup complete.
agent-petstore-p2p     | INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```

#### Weather agent logs:
```
agent-weather-p2p      | ===================================
agent-weather-p2p      |        WEATHER AGENT CONFIG
agent-weather-p2p      | ===================================
agent-weather-p2p      | AGENT_URL: http://0.0.0.0:8000
agent-weather-p2p      | ===================================
agent-weather-p2p      | Running A2A server in p2p mode.
agent-weather-p2p      | INFO:     Started server process [1]
agent-weather-p2p      | INFO:     Waiting for application startup.
agent-weather-p2p      | INFO:     Application startup complete.
agent-weather-p2p      | INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```

#### Supervisor agent logs:
```
platform-engineer-p2p  | 2025-08-21 13:36:04,058 - INFO - Dynamic monitoring enabled for 2 agents
platform-engineer-p2p  | 2025-08-21 13:36:04,062 - INFO - [LLM] AzureOpenAI deployment=gpt-4o api_version=2025-03-01-preview
platform-engineer-p2p  | 2025-08-21 13:36:04,809 - INFO - Graph updated with 2 agent tools
platform-engineer-p2p  | 2025-08-21 13:36:04,809 - INFO - AIPlatformEngineerMAS initialized with 2 agents
platform-engineer-p2p  | INFO:     Started server process [1]
platform-engineer-p2p  | INFO:     Waiting for application startup.
platform-engineer-p2p  | INFO:     Application startup complete.
platform-engineer-p2p  | INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```

**🎯 Success indicator:** Wait until you see all three agents running and the supervisor reports successful connectivity checks as shown in the logs above.

## Step 3: Test the agent health

We can now check each agent card to see what capabilities are available. Open a new terminal and run the following command to test the agent health:

### Weather agent card:
```bash
curl http://localhost:8009/.well-known/agent.json | jq
```

### Petstore agent card:
```bash
curl http://localhost:8010/.well-known/agent.json | jq
```

### Supervisor agent card:

This is the supervisor agent card. It will show the combined capabilities of the petstore and weather agents.

```bash
curl http://localhost:8000/.well-known/agent.json | jq
```

## Step 4: Connect Multi-Agent Chat Client

Once all agents are running, start the chat client:

**💡 Tip:**  When askes to `💬 Enter token (optional): `, press enter.


```bash
docker run -it --network=host ghcr.io/cnoe-io/agent-chat-cli:stable
```

The client will connect to the supervisor agent and show available capabilities from both petstore and weather agents.

## Step 5: Test Multi-Agent Interactions

### Discovery Commands

Try these to explore the multi-agent capabilities:

```bash
What agents are available?
```

```bash
What can you help me with?
```

### Weather-Specific Commands

```bash
What's the current weather in San Francisco?
```

```bash
Give me a 5-day forecast for London
```

### Petstore Commands (from Mission 2)

```bash
Add a new dog named Max
```

```bash
Show me pets with 'cold' tags
```

### Cross-Agent Scenarios

Test scenarios that require both agents:

```bash
Get me weather for New York and find me all cats that are available for adoption.
```

```bash
 What’s the weather like in Paris right now? If it’s cold, think dogs (cold‑tolerant). If it’s hot, think fish or reptiles. If it’s rainy/snowy, think indoor cats. Show available petstore pets that fit
```

```bash
If it's going to rain tomorrow in Tokyo, should I delay outdoor pet deliveries?
```

## Bonus

**Run this with AGNTCY SLIM Gateway in the middle**

```
IMAGE_TAG=latest MCP_MODE=http docker compose -f workshop/docker-compose.mission3.yaml --profile=slim up
```

## Mission Checks

<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #007cba;">
  <h4 style="margin-top: 0; color: #007cba;">🚀 Mars Colony Multi-Agent Mission Checklist</h4>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Multi-Agent Launch: All three agents (supervisor, weather, petstore) start successfully</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Connectivity: Supervisor reports successful connections to both subagents</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Cross-Agent Query: Successfully handle requests requiring both weather and petstore data</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Agent Coordination: Observe supervisor routing requests to appropriate specialized agents</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Combined Responses: Receive unified answers that incorporate data from multiple agents</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Bonus: Run with AGNTCY SLIM Gateway</strong>
  </label>
</div>
