# Mission Check 4 - Reconnaissance & Reporting back (RAG + Git agent)

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

<br>

## Overview
<br>
In this mission, you'll deploy and interact with specialized agents for **knowledge retrieval** and **version control**:

- **📚 RAG Agent**: Use Retrieval-Augmented Generation (RAG) to answer questions about Mars
- **🔧 Git Agent**: Automate git operations like commits, pushes, and repository management

This demonstrates how agents can access external knowledge bases and automate development workflows.

<br>
<hr>

## Step 1: Launch RAG + Git Agent Stack
<br>
Make sure you are in the ai-platform-engineering directory:

```bash
cd $HOME/work/ai-platform-engineering
```

Copy over the mission4 environment variables file:

```bash
cp $HOME/.env_vars .env.mission4
```

Start the Docker Compose stack that includes both RAG and Git agents:

```bash
docker compose -f workshop/docker-compose.mission4.yaml up
```

**👀 Observe:** You should see the following in the logs:

```console
...
platform-engineer-p2p  |        SLACK AGENT CONFIG      ====
platform-engineer-p2p  | ===================================
platform-engineer-p2p  | AGENT_URL: http://localhost:8000
platform-engineer-p2p  | ===================================
platform-engineer-p2p  | ===================================8000
platform-engineer-p2p  |        KB-RAG AGENT CONFIG      ===
platform-engineer-p2p  | ===================================
platform-engineer-p2p  | AGENT_URL: http://kb-rag-agent:8000
platform-engineer-p2p  | ===================================
platform-engineer-p2p  | 2025-08-26 12:03:18,817 - INFO - Running connectivity checks for 8 agents (max 4 attempts per agent)...
platform-engineer-p2p  |        SLACK AGENT CONFIG      
platform-engineer-p2p  | ===================================
platform-engineer-p2p  | AGENT_URL: http://localhost:8000
platform-engineer-p2p  | ===================================
platform-engineer-p2p  | ===================================
platform-engineer-p2p  |        KB-RAG AGENT CONFIG      
platform-engineer-p2p  | ===================================
platform-engineer-p2p  | AGENT_URL: http://kb-rag-agent:8000
platform-engineer-p2p  | ===================================
platform-engineer-p2p  | 2025-08-26 12:03:18,817 - INFO - Running connectivity checks for 8 agents (max 4 attempts per agent)...
kb-rag-agent           | INFO:     172.19.0.9:53190 - "GET /.well-known/agent.json HTTP/1.1" 200 OK
agent-github-p2p       | INFO:     172.19.0.9:47004 - "GET /.well-known/agent.json HTTP/1.1" 200 OK
platform-engineer-p2p  | 2025-08-26 12:03:18,895 - INFO - HTTP Request: GET http://kb-rag-agent:8000/.well-known/agent.json "HTTP/1.1 200 OK"
platform-engineer-p2p  | 2025-08-26 12:03:18,895 - INFO - HTTP Request: GET http://kb-rag-agent:8000/.well-known/agent.json "HTTP/1.1 200 OK"
platform-engineer-p2p  | 2025-08-26 12:03:18,895 - INFO - ✅ Agent kb-rag is reachable at http://kb-rag-agent:8000
platform-engineer-p2p  | 2025-08-26 12:03:18,896 - INFO - HTTP Request: GET http://agent-github-p2p:8000/.well-known/agent.json "HTTP/1.1 200 OK"
platform-engineer-p2p  | 2025-08-26 12:03:18,897 - INFO - ✅ Agent github is reachable at http://agent-github-p2p:8000
...
```

The docker-compose stack should start the following services:

- `platform-engineer-p2p` : The platform engineer supervisor agent
- `agent-github-p2p` : The git agent
- `kb-rag-agent` : The RAG agent
- `kb-rag-server` : The RAG server
- `kb-rag-web`: The RAG web UI
- `milvus-standalone`: The Milvus vector database
- `etcd`: Needed for Milvus
- `minio`: Needed for Milvus


**🫸 Wait:** Wait until this process is completed.

Once you see the logs above, you can verify the supervisor agent is healthy by checking the health endpoint.

**➕ Open another terminal** (top-right '+' icon), and run the following command:

```bash
curl http://localhost:8000/.well-known/agent.json | jq
```

**👀 Observe:** The response should be a JSON object (the A2A agent card).


<br>
<hr>

## Step 2: Populate RAG database
<br>
Now, we will populate the RAG with documentation. The docker-compose stack should have started the `kb-rag-web` service, which is the web ui
for the RAG server.

<a href="/" onclick="javascript:event.target.port=6100" target="_blank">Open the RAG Web UI by clicking here (Opens in new tab)</a>

Once the RAG Web UI is open:

1. Copy the URL for Mars wiki page `https://en.wikipedia.org/wiki/Mars` and paste it in `Ingest URL` field
2. Click `Ingest` button
3. **🫸 Wait:** Wait for the ingestion to complete


**👀 Observe:** The status should show as `✅ Successfully processed 1 URL(s)`

![RAG UI](images/rag-ui-screenshot.png)

### Explanation:

Here's what happens:

 - The RAG server crawls webpage (it also supports sitemap), and fetches the page.
 - The HTML is parsed and content is extracted.
 - If the page is too large, it is split into chunks, using [Recursive Text Splitter](https://python.langchain.com/docs/how_to/recursive_text_splitter/).
 - Each chunk is sent to embedding model (LLM in this case) to generate embeddings.
 - The embeddings are stored in a vector store (Milvus), along with metadata (source, title, description etc).

<br>

![RAG ingestion](images/rag-ingestion.png)

<br>
<hr>

## Step 3: Verify RAG System is working
<br>
We will now use the UI to query the RAG system and verify it is working.

<a href="/" onclick="javascript:event.target.port=6100" target="_blank">Open RAG Web UI again</a>

**Type:** `Axial tilt` in the query box, then **Click:** `Search` button

**👀 Observe:** The response should return relevant document chunks. The chunks may not be formatted in a way that is easy to read. As long as some document chunks are returned, the RAG system is working.


<br>
<hr>

## Step 4: Using the RAG Agent
<br>

**➕ Open another terminal** (top-right '+' icon), and run the following command:

```bash
docker run -it --network=host ghcr.io/cnoe-io/agent-chat-cli:stable
```

## Note: When prompted for optional token, press enter.
![chatcli token](images/chat-cli-token.png)

This should open a CLI chat client. You can now interact with the supervisor agent.

**Ask the agent:**

```bash
What is the axial tilt of Mars?
```

**👀 Observe:** The agent should respond with the axial tilt of Mars, and cite the source of the information.

### Explanation:

Here's what happens:

 - The RAG agent embeds the question using the same embedding model used to embed the documents.
 - The agent then uses the vector store to find the most similar documents.
 - The agent uses the retrieved document chunks to answer the question.

<br>

![RAG Agent Architecture](images/rag-agent-arch.png)

<br>
<hr>

## Step 5: Multi-agent interaction
<br>

Now, we will test the multi-agent interaction by asking the supervisor agent to:
 - search for information about Mars (reconnaissance)
 - commit the steps to git repository (report back).


In the CLI chat client, ask the agent:

```bash
Research and write a report on mars surface, then commit it as a text file named '%%LABNAME%%-report.txt' to my github repository https://github.com/outshiftcaipe/mission-mars-colony
```


**👀 Observe:** While the agent is working, in the first terminal tab, you should see the ai platform engineering supervisor agent delegate tasks to `kb-rag` and `github` agents.

**👀 Observe:** Back in the CLI chat client, the agent should have created a report (named `%%LABNAME%%-report.txt`) about the martian surface, and commited it to the [workshop git repository](https://github.com/outshiftcaipe/mission-mars-colony).

### Explanation:

Here's what happens:

 - The supervisor agent determines what needs to be done, and delegates the tasks to the sub agents.
 - It first asks the RAG agent to search for information about Mars surface.
 - The RAG agent uses the vector store to find relavant information, and write a report.
 - The supervisor agent then asks the git agent to commit the report as a text file to the repository.

<br>
<hr>

## Mission Checks
<br>

<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #007cba;">
  <h4 style="margin-top: 0; color: #007cba;">🚀 Reconnaissance & Reporting Mission Checklist</h4>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Launch RAG + Git agent stack successfully</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Import Mars wiki into RAG</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Verify RAG queries return relevant documentation</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Connect chat client to supervisor agent</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Test knowledge retrieval: "What is the axial tilt of Mars?"</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>Test multi-agent interaction: Documentation search + git operations</strong>
  </label>
</div>

<br>
<hr>

## 📖 Further Reading
<br>

### RAG Agent

More information on the RAG agent can be found [here](https://github.com/cnoe-io/ai-platform-engineering/tree/main/ai_platform_engineering/knowledge_bases/rag).

### Graph RAG

The AI platform engineering repository also includes **Graph RAG**, which uses Neo4J to create knowledge graphs from structured data (K8s objects, AWS resources).
See the [Graph RAG documentation](https://cnoe-io.github.io/ai-platform-engineering/knowledge_bases/graph_rag) for more details, and how to run it in your local environment.

### Unified Knowledge Base

Currently there is a open discussion on how to unify different RAG systems, and create a unified knowledge base thats specialized for AI platform engineering. Please follow the discussion [here](https://github.com/cnoe-io/ai-platform-engineering/discussions/196).

### Github agent

The Github agent can be used as is. Please refer to the [Github agent documentation](https://github.com/cnoe-io/ai-platform-engineering/tree/main/ai_platform_engineering/agents/github) for more details.
