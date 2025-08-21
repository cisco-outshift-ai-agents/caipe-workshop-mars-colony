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

For this workshop, we will use Azure OpenAI. Modify lines 30-35 with your LLM credentials:

**💡 Tip:** You should have received your LLM credentials prior to the workshop. If you don't have them, please ask your instructor.

**💡 Tip:** Press `i` to enter insert mode in vim, make your changes, then press `Esc` and type `:wq` to save and exit.


```bash
# --- OR Use Azure OpenAI ---
LLM_PROVIDER=azure-openai
AZURE_OPENAI_API_KEY=<your provided api key prior to the workshop>
AZURE_OPENAI_ENDPOINT=https://platform-interns-eus2.openai.azure.com/
AZURE_OPENAI_DEPLOYMENT=gpt-4o
AZURE_OPENAI_API_VERSION=2025-03-01-preview
```

## Step 3: Run the Petstore Agent

**Note:** If you prefer to build and run the agent locally, refer to the step at the bottom of this page: [Optional: Build and run the petstore agent locally](#optional-build-and-run-the-petstore-agent-locally).

Now, we will go through the process of running the standalone petstore agent using docker compose:

```bash
IMAGE_TAG=latest docker compose -f workshop/docker-compose.mission2.yaml up
```

This pulls the latest petstore agent image from the registry and runs in port 8000.

**What happens:**
- ⏬ Downloads petstore agent image with the latest tag from the registry
- 🔗 Connects to MCP server on STDIO mode to https://petstore.swagger.io/v2 which is a public sandbox API
- 🌐 Exposes agent on `http://localhost:8000`
- 📋 Shows logs directly in terminal

**Expected output:**
```console
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

Open a new terminal and run the following command to test the agent health:

```bash
curl http://localhost:8000/.well-known/agent.json | jq
```

You should see the agent card with petstore capabilities. This includes the agent's name, description, and capabilities including example prompts that you can use to test the agent.

## Step 5: Connect Chat Client

Once you confirm the agent is running, start the chat client:

**💡 Tip:**  When askes to `💬 Enter token (optional): `, press enter.

```bash
docker run -it --network=host ghcr.io/cnoe-io/agent-chat-cli:stable
```

The chat client will connect to the petstore agent on port 8000 and download the agent card from Step 4. It will then use the agent card to discover the agent's capabilities.

Wait for the agent's welcome message with example skills and CLI prompt `🧑🧑‍💻 You: `. You can now start interacting with the agent.

## Step 6: Interact with the Petstore Agent

### Discovery Commands

Try these example interactions:

```bash
What actions can you perform?
```

```bash
Show me what you can do with pets
```

### Pet Management Examples

```bash
Find all available pets in the store
```

```bash
Get all cats that are available
```

```bash
Get a summary of pets by status
```

```bash
I want to add a new pet to the store
```

**Warning:** The Petstore API used here (`https://petstore.swagger.io/v2`) is a public demo sandbox. Create/update/delete requests may return 200 OK but data is not persisted, so subsequent reads may not reflect your changes.

### Store Operations

```bash
Check store inventory levels
```

```bash
Show me pets with 'friendly' tags
```

### Expected Behavior

- ✅ **Fast responses** - Agent uses optimized functions with response limits
- ✅ **Smart search** - Can handle combined criteria like "cats that are pending"
- ✅ **Interactive guidance** - Agent will ask for required details when needed e.g. ask to add a new pet and it will ask for required details like name, category, status, etc.
- ✅ **Rich summaries** - Shows counts and statistics without overwhelming data

## Mission Checks

- [ ] ✅ Navigate to AI Platform Engineering repository
- [ ] ✅ Set up .env file with LLM credentials
- [ ] ✅ Run docker compose to to pull the latest petstore agent image and run it in port 8000
- [ ] ✅ Connect chat client to the petstore agent and test the agent
- [ ] ✅ Test discovery: "What actions can you perform?"
- [ ] ✅ Test pet search: "Find all available pets"
- [ ] ✅ Test smart search: "Get all cats that are pending"
- [ ] ✅ Test interactive: "I want to add a new pet"

## Teardown that agent and chat client

You can stop the agent and chat client by pressing `Ctrl+C` (or `Cmd+C` on Mac) in each terminal.

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

### [Optional] Build and run the petstore agent locally

You can also build and run the petstore agent locally:

```bash
docker compose -f workshop/docker-compose.mission2.yaml -f workshop/docker-compose.dev.override.yaml --profile mission2-dev up
```

Above command uses the dev override file to mount the code from your local machine and rebuild the petstore agent image on each change. This is useful for testing local changes to the agent code.

**What happens:**
- 🔧 Builds Docker image located in `ai_platform_engineering/agents/template/build/Dockerfile.a2a`
- 📁 Mounts code via volumes for live development
- 🌐 Exposes agent on `http://localhost:8000`
- 📋 Shows logs directly in terminal
