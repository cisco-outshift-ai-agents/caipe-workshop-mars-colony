# Mission Check 2 — Run Standalone Petstore Agent

## Overview

In this mission, you'll run a standalone Petstore AI agent that demonstrates:
- **Pet Management**: Add, find, update, and delete pets
- **Store Operations**: Inventory, orders, and analytics
- **User Management**: Account creation and management
- **Smart Search**: Combined status + category filtering
- **Response Optimization**: Handles large datasets efficiently

## Step 1: Navigate to AI Platform Engineering Repository

```bash
cd ai-platform-engineering
```

## Step 2: Set Up Environment Variables

### Copy the example environment file:

```bash
cp .env.example .env
```

### Edit the environment file with your LLM credentials:

```bash
vim .env
```

**Required variables to configure:**

Modify lines 31-35 with your LLM credentials:

```bash
LLM_PROVIDER=azure-openai
AZURE_OPENAI_API_KEY=<your provided api key prior to the workshop>
AZURE_OPENAI_ENDPOINT=https://platform-interns-eus2.openai.azure.com/
AZURE_OPENAI_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2025-03-01-preview
```

**💡 Tip:** You should have received your LLM credentials prior to the workshop. If you don't have them, please ask your instructor.

**💡 Tip:** Press `i` to enter insert mode in vim, make your changes, then press `Esc` and type `:wq` to save and exit.

## Step 3: Run the Petstore Agent

Now, we will go through the process of running the standalone petstore agent using docker compose.

```bash
docker compose -f workshop/docker-compose.mission2.yaml up
```

**What happens:**
- 🔧 Builds Docker image (first time ~30 seconds)
- ⚡ Uses cached image on subsequent runs (2 seconds)
- 📁 Mounts code via volumes for live development
- 🌐 Exposes agent on `http://localhost:8000`
- 📋 Shows logs directly in terminal

**Expected output:**
```
...
===================================
       PETSTORE AGENT CONFIG
===================================
AGENT_URL: http://0.0.0.0:8000
===================================
Running A2A server in p2p mode.
INFO:     Started server process [1]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)
```

**🎯 Success indicator:** Ensure you wait until you see the message: `Uvicorn running on http://0.0.0.0:8000 (Press CTRL+C to quit)`

## Step 4: Test the Petstore Agent

### Test the agent health

```bash
curl http://localhost:8000/.well-known/agent.json | jq
```

You should see the agent card with petstore capabilities.

## Step 5: Connect Chat Client

Once you confirm the agent is running, start the chat client:

```bash
docker run -it --network=host ghcr.io/cnoe-io/agent-chat-cli:stable
```
The chat client will connect to the petstore agent on port 8000 and download the agent card that we tested in the previous step. It will then use the agent card to discover the agent's capabilities.

When askes to `💬 Enter token (optional): `, press enter. Wait for the agent's welcome message with example skills and CLI prompt `🧑‍💻 You:`. You can now start interacting with the agent.

## Step 6: Interact with the Petstore Agent

### Discovery Commands

Try these example interactions:

```
What actions can you perform?
```

```
Show me what you can do with pets
```

### Pet Management Examples

```
Find all available pets in the store
```

```
Get all cats that are available
```

```
Get a summary of pets by status
```

```
I want to add a new pet to the store
```

### Store Operations

```
Check store inventory levels
```

```
Show me pets with 'friendly' tags
```

### Expected Behavior

- ✅ **Fast responses** - Agent uses optimized functions with response limits
- ✅ **Smart search** - Can handle combined criteria like "cats that are pending"
- ✅ **Interactive guidance** - Agent will ask for required details when needed
- ✅ **Rich summaries** - Shows counts and statistics without overwhelming data

## Mission Checks

- [ ] ✅ Navigate to petstore directory
- [ ] ✅ Set up .env file with LLM credentials
- [ ] ✅ Run `make run` successfully
- [ ] ✅ Connect chat client to `http://localhost:8000`
- [ ] ✅ Test discovery: "What actions can you perform?"
- [ ] ✅ Test pet search: "Find all available pets"
- [ ] ✅ Test smart search: "Get all cats that are pending"
- [ ] ✅ Test interactive: "I want to add a new pet"

## Troubleshooting

### Agent won't start
```bash
# Check if port 8000 is in use
lsof -i :8000

# Stop any existing containers
make stop
make clean
```

### Chat client can't connect
```bash
# Verify agent health
curl http://localhost:8000/.well-known/agent.json

# Check if agent is running
make status
```

### Environment issues
```bash
# Check environment variables
make show-env

# Rebuild with fresh environment
make run-rebuild
```
