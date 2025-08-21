# Mission Check 3 — Multi-Agent Weather + Petstore System

## Overview

In this mission, you'll run a **multi-agent system** that includes:
- **🐾 Petstore Agent**: Pet management from Mission 2
- **🌤️ Weather Agent**: Real-time weather data and forecasts
- **🧠 Supervisor Agent**: Orchestrates and coordinates between agents

This demonstrates **agent-to-agent communication** where the supervisor can intelligently route requests to specialized agents and combine their responses.

## Step 1: Configure Multi-Agent Environment

### Edit the environment file to enable multi-agent mode:

```bash
vim .env
```

**Modify lines 1-18** with the following agent configuration:

```bash
########### AGENT CONFIGURATION ###########

ENABLE_WEATHER_AGENT=true # <- enable weather agent
ENABLE_PETSTORE_AGENT=true # <- enable petstore agent

########### MULTI-AGENT CONFIGURATION ###########

# INITIAL CONNECTIVITY CHECK FOR SUBAGENTS
SKIP_AGENT_CONNECTIVITY_CHECK=false # <- set to true to perform the initial connectivity check
AGENT_CONNECTIVITY_TIMEOUT=5.0
AGENT_CONNECTIVITY_MAX_RETRIES=3
AGENT_CONNECTIVITY_RETRY_DELAY=2.0
AGENT_CONNECTIVITY_STARTUP_DELAY=0.0

# DYNAMIC MONITORING PARAMETERS
AGENT_CONNECTIVITY_ENABLE_BACKGROUND=true # <- set to true to enable the background connectivity check
AGENT_CONNECTIVITY_REFRESH_INTERVAL=300
AGENT_CONNECTIVITY_FAST_CHECK_TIMEOUT=2.0
```

**💡 Tip:** Press `i` to enter insert mode in vim, make your changes, then press `Esc` and type `:wq` to save and exit.

The connectivity check is performed when the supervisor agent starts. It will check if the petstore and weather agents are running and if they are, it will add them to the supervisor agent's memory.

The dynamic monitoring is performed in the background and will check if the petstore and weather agents are running every 5 minutes. If any of the agents is unavailable, the supervisor agent will remove it from available tools until it is back online.

## Step 2: Start Multi-Agent System

### Launch the multi-agent stack with Docker Compose:

```bash
docker compose -f workshop/docker-compose.mission3.yaml up
```

**Expected output:**
```
✅ Creating network "ai-platform-engineering_default"
✅ Starting weather-agent...
✅ Starting petstore-agent...
✅ Starting supervisor-agent...

🌤️ weather-agent    | INFO: Uvicorn running on http://0.0.0.0:8001
🐾 petstore-agent   | INFO: Uvicorn running on http://0.0.0.0:8002
🧠 supervisor-agent | INFO: Multi-agent supervisor ready on http://0.0.0.0:8000
```

**🎯 Success indicator:** Wait until you see all three agents running and the supervisor reports successful connectivity checks.

## Step 3: Connect Multi-Agent Chat Client

Once all agents are running, **open a new terminal** and start the chat client:

```bash
docker run -it --network=host ghcr.io/cnoe-io/agent-chat-cli:stable
```

When asked for `💬 Enter token (optional):`, press enter. The client will connect to the supervisor agent and show available capabilities from both petstore and weather agents.

## Step 4: Test Multi-Agent Interactions

### Discovery Commands
Try these to explore the multi-agent capabilities:

```
What agents are available?
```

```
What can you help me with?
```

### Cross-Agent Scenarios
Test scenarios that require both agents:

```
What's the weather like today? Also show me available pets in the store.
```

```
If it's going to rain tomorrow, should I delay outdoor pet deliveries?
```

```
Get me weather for New York and find me all cats that are available for adoption.
```

### Weather-Specific Commands
```
What's the current weather in San Francisco?
```

```
Give me a 3-day forecast for London
```

### Petstore Commands (from Mission 2)
```
Get all available pets
```

```
Add a new dog named Max
```

## Step 5: Observe Agent Coordination

### Watch the logs to see agent-to-agent communication:
In your Docker Compose terminal, you'll see:
- **🧠 Supervisor**: Receives user query and decides which agent(s) to call
- **🌤️ Weather/🐾 Petstore**: Process specific requests and return results
- **🧠 Supervisor**: Combines responses and presents unified answer

### Example coordination flow:
```
🧑‍💻 User: "What's the weather in NYC and show me available cats?"

🧠 Supervisor: "I need weather data and pet data..."
           ↳ Calls Weather Agent for NYC weather
           ↳ Calls Petstore Agent for available cats
           ↳ Combines both responses

🌤️ Weather: "Current weather in NYC: 72°F, sunny"
🐾 Petstore: "Found 3 available cats: Fluffy, Whiskers, Shadow"

🧠 Supervisor: "Here's what I found: [combined response]"
```

## Mission Checks

✅ **Multi-Agent Launch**: All three agents (supervisor, weather, petstore) start successfully
✅ **Connectivity**: Supervisor reports successful connections to both subagents
✅ **Cross-Agent Query**: Successfully handle requests requiring both weather and petstore data
✅ **Agent Coordination**: Observe supervisor routing requests to appropriate specialized agents
✅ **Combined Responses**: Receive unified answers that incorporate data from multiple agents

## Troubleshooting

### If agents fail to connect:
```bash
# Check agent health individually
curl http://localhost:8001/.well-known/agent.json  # Weather
curl http://localhost:8002/.well-known/agent.json  # Petstore
curl http://localhost:8000/.well-known/agent.json  # Supervisor
```

### If Docker Compose fails:
```bash
# Stop and clean up
docker compose -f docker-compose.weather.yaml --profile=p2p down

# Try again
docker compose -f docker-compose.weather.yaml --profile=p2p up
```

## Next Steps

🚀 **Mission 4**: Implement custom agent with specialized domain knowledge
🔧 **Mission 5**: Add distributed tracing to observe agent communication patterns
🌐 **Mission 6**: Deploy multi-agent system to production environment

---

**📚 References:**
- [Agent-to-Agent Communication Protocol](https://docs.agent-protocol.org/)
- [Multi-Agent Orchestration Patterns](https://langchain.com/multi-agent)
- [Docker Compose Multi-Service Setup](https://docs.docker.com/compose/)