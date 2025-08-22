# Mission Check 2 — Run Standalone Petstore Agent

## Overview

🚀 **Mission Status**: As a newly arrived Mars colonist, your first assignment is to manage the colony's biological companions and supply systems.

In this mission, you'll deploy a standalone Petstore AI agent to handle critical colony operations:
* **🐾 Companion Management**: Track, care for, and manage colony animals that boost morale and assist with tasks
* **📦 Supply Operations**: Monitor inventory, process resource orders, and analyze colony logistics
* **👨‍🚀 Colonist Management**: Maintain records and manage access for fellow Mars inhabitants
* **🔍 Smart Search**: Efficiently locate animals and supplies using advanced filtering systems
* **⚡ Response Optimization**: Handle large datasets crucial for colony survival without system overload

## Architecture Overview

The following diagram shows how the chat client connects to the petstore agent in STDIO mode:

[![Mission 2 Architecture - STDIO Mode](https://mermaid.ink/img/pako:eNpVkUtu2zAQhq9CzKoBLFnW0xaCALacAlkENZBkk7ILWppKaiTSoKi4reND9ATd9IA9QkZiIzQDAiR_znzz4AlyVSCkUGpxqNj9lktG9vCZw9_fv_6whw41hy_Mca5YlpGaVcKwrKlRmsu9nl99KKtcu7Wa51KhQ7so6cnJyc3JmzrtjNg3eEEMLi07y5jjOuyFw0c0ecXGAJYLXXB4YdeUY-4esWmcJ6mO0vLcb52SI2MgXI-A9X_Ay6G-Sej6vW2HAy2rDbYm9g5NZ5RGti6nFnZKG7b0PO9iSjHYhtxvsx27Q_2M2rre3W9vPrFbmtl737UtYWMVlMVbLRv7kL1LvbuxtMM_xe2OoixxnOOz_zYsLmFG_1IXkH4VTYczaFG3YrjDaaBzMBW2yCGlYyH009DsmYIOQj4q1UJqdE9hWvVlNUH6QyEMbmtBM2onVVPNqDPVSwOp74UjBNITfIc0SGJ3FYVBtAwXYeglwQx-kLpyoyj2SV8EyTKJveg8g59jWs9dxskqSuI4iP2F5wfx-RXgTbhw?type=png)](https://mermaid.live/edit#pako:eNpVkUtu2zAQhq9CzKoBLFnW0xaCALacAlkENZBkk7ILWppKaiTSoKi4reND9ATd9IA9QkZiIzQDAiR_znzz4AlyVSCkUGpxqNj9lktG9vCZw9_fv_6whw41hy_Mca5YlpGaVcKwrKlRmsu9nl99KKtcu7Wa51KhQ7so6cnJyc3JmzrtjNg3eEEMLi07y5jjOuyFw0c0ecXGAJYLXXB4YdeUY-4esWmcJ6mO0vLcb52SI2MgXI-A9X_Ay6G-Sej6vW2HAy2rDbYm9g5NZ5RGti6nFnZKG7b0PO9iSjHYhtxvsx27Q_2M2rre3W9vPrFbmtl737UtYWMVlMVbLRv7kL1LvbuxtMM_xe2OoixxnOOz_zYsLmFG_1IXkH4VTYczaFG3YrjDaaBzMBW2yCGlYyH009DsmYIOQj4q1UJqdE9hWvVlNUH6QyEMbmtBM2onVVPNqDPVSwOp74UjBNITfIc0SGJ3FYVBtAwXYeglwQx-kLpyoyj2SV8EyTKJveg8g59jWs9dxskqSuI4iP2F5wfx-RXgTbhw)

## Step 1: Navigate to AI Platform Engineering Repository

```bash
cd $HOME/work/ai-platform-engineering
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

Run this in your terminal. It prompts for your key and updates `.env`:

```bash
read -s -p "Enter your Azure OpenAI API key: " API_KEY && echo && \
sed -i \
  -e 's|^LLM_PROVIDER=.*|LLM_PROVIDER=azure-openai|' \
  -e "s|^AZURE_OPENAI_API_KEY=.*|AZURE_OPENAI_API_KEY=${API_KEY}|" \
  -e 's|^AZURE_OPENAI_ENDPOINT=.*|AZURE_OPENAI_ENDPOINT=https://platform-interns-eus2.openai.azure.com/|' \
  -e 's|^AZURE_OPENAI_DEPLOYMENT=.*|AZURE_OPENAI_DEPLOYMENT=gpt-4o|' \
  -e 's|^AZURE_OPENAI_API_VERSION=.*|AZURE_OPENAI_API_VERSION=2025-03-01-preview|' \
  .env
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


<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #007cba;">
  <h4 style="margin-top: 0; color: #007cba;">🚀 Colony Mission Checklist</h4>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> Navigate to AI Platform Engineering repository</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> Set up .env file with LLM credentials</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> Run docker compose to pull the latest petstore agent image and run it on port 8000</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> Connect chat client to the petstore agent and test the agent</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> Test discovery: "What actions can you perform?"</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> Test companion search: "Find all available companions"</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> Test smart search: "Get all cats that are pending"</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong> Test interactive: "I want to add a new companion"</strong>
  </label>
</div>

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
