# Mission Check 4 - Mission Control Manual and Reporting back (RAG + Git agent)

## Overview

In this mission, you'll deploy and interact with specialized agents for **knowledge retrieval** and **version control**:
- **📚 RAG Agent**: Query AI Platform Engineering documentation using Retrieval-Augmented Generation
- **🔧 Git Agent**: Automate git operations like commits, pushes, and repository management
- **🤖 Integration**: Combine both agents for documentation-driven development workflows

This demonstrates how agents can access external knowledge bases and automate development workflows.


### Prerequisites

- [ ] Git account and credentials

## Step 1: Launch RAG + Git Agent Stack

Start the Docker Compose stack that includes both RAG and Git agents:

```bash
docker compose -f workshop/docker-compose.mission4.yaml up
```

**Expected output:**
```
✅ Starting rag-agent...
✅ Starting git-agent...
✅ Starting supervisor-agent...

📚 rag-agent        | INFO: RAG service ready on http://0.0.0.0:9446
🔧 git-agent        | INFO: Git agent ready on http://0.0.0.0:8003
🧠 supervisor-agent | INFO: Multi-agent supervisor ready on http://0.0.0.0:8000
```

**🎯 Success indicator:** Wait until all three services are running and healthy.

## Step 2: Populate RAG with Documentation

Import the AI Platform Engineering documentation into the RAG system:

```bash
curl -X POST \
  http://localhost:9446/v1/datasource/ingest/url \
  -H "Content-Type: application/json" \
  -d '{
    "url": "https://cnoe-io.github.io/ai-platform-engineering/",
    "params": {}
  }'
```

**Expected response:**
```json
202 Accepted
```


### Observe:

You should see relevant documentation snippets returned with source references. 

**Explanation:** The server crawls the sitemap, fetches each page, and embeds the content into a vector store (Milvus).


**Please wait** until this process is completed.

**Example of logs:**
```json
...
INFO:     [63/64] Loading page
INFO:     Generator tag found: <meta content="Docusaurus v3.8.1" name="generator"/>
INFO:     Generator: Docusaurus v3.8.1
INFO:     Embedding & adding document: https://cnoe-io.github.io/ai-platform-engineering/usecases/product-owner⁠
INFO:     Document added to vector store: [460268547916431933]
INFO:     [64/64] Loading page
INFO:     Generator tag found: <meta content="Docusaurus v3.8.1" name="generator"/>
INFO:     Generator: Docusaurus v3.8.1
INFO:     Embedding & adding document: https://cnoe-io.github.io/ai-platform-engineering/⁠
INFO:     Document added to vector store: [460268547916431934]
INFO:     Shutting down
INFO:     Waiting for application shutdown.
INFO:     Application shutdown complete.
INFO:     Finished server process [1]
```


## Step 3: Verify RAG System

Test the RAG system with a sample query:

```bash
curl -X POST \
  http://localhost:9446/v1/query \
  -H "Content-Type: application/json" \
  -d '{
    "query": "what is ai platform engineering",
    "limit": 1
  }'
```

**Expected response:**
```json
[
    {
        "page_content": "...",
        "metadata": {
            "source": "...",
            "title": "...",
            "description": "..."
        },
        "pk": "..."
    }
]
```

## Step 4: Connect to Multi-Agent System

Start the chat client to interact with both agents:

```bash
docker run -it --network=host ghcr.io/cnoe-io/agent-chat-cli:stable
```

When prompted for token, press enter to connect to the supervisor agent.

## Step 5: Test RAG Agent Capabilities

### Documentation Queries
Try these knowledge retrieval examples:
```
How do I set up ai-platform-engineering system using Docker?
```

```
How do I deploy GraphRAG in ai-platform-engineering?
```

### Expected Behavior
- ✅ **Contextual answers** from ingested documentation
- ✅ **Source citations** showing which docs were referenced
- ✅ **Accurate information** based on the knowledge base


## Step 6: Test Git Agent Operations

### Repository Status
```
Check the current git status of this repository
```

### File Operations
```
Show me the recent commit history
```

## Step 7: 

Test a realistic development workflow combining both agents:

```
Search the documentation for best practices on agent deployment, then commit any changes I've made to the repository
```

```
Find information about Docker Compose setup and create a git branch called "docker-improvements"
```

## Mission Checks

- [ ] ✅ Launch RAG + Git agent stack successfully
- [ ] ✅ Import AI Platform Engineering docs into RAG
- [ ] ✅ Verify RAG queries return relevant documentation
- [ ] ✅ Connect chat client to multi-agent supervisor
- [ ] ✅ Test knowledge retrieval: "What is AI Platform Engineering?"
- [ ] ✅ Test git operations: "Check git status"
- [ ] ✅ Test combined workflow: Documentation search + git operations

## Troubleshooting

### RAG ingestion fails
```bash
# Check RAG service health
curl http://localhost:9446/health

# Restart RAG service
docker compose -f workshop/docker-compose.mission4.yaml restart rag-agent
```

### Git agent can't access repository
```bash
# Verify git agent is running
curl http://localhost:8003/.well-known/agent.json

# Check repository permissions
ls -la .git/
```

### Agents not connecting
```bash
# Check all agent health endpoints
curl http://localhost:8000/.well-known/agent.json  # Supervisor
curl http://localhost:9446/health                  # RAG
curl http://localhost:8003/.well-known/agent.json  # Git
```
