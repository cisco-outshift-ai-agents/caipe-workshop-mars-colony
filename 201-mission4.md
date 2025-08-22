# Mission Check 4 - Reconnaissance & Reporting back (RAG + Git agent)

## Overview

In this mission, you'll deploy and interact with specialized agents for **knowledge retrieval** and **version control**:

- **📚 RAG Agent**: Use Retrieval-Augmented Generation (RAG) to answer questions about Mars
- **🔧 Git Agent**: Automate git operations like commits, pushes, and repository management

This demonstrates how agents can access external knowledge bases and automate development workflows.

## Step 1: Launch RAG + Git Agent Stack

Clear any old containers by running:

```bash
docker stop $(docker ps -a -q); docker container prune -f
```

Make sure you are in the ai-platform-engineering directory, you can check by running `pwd`.

Start the Docker Compose stack that includes both RAG and Git agents:

```bash
docker compose -f workshop/docker-compose.mission4.yaml up
```

**👀 Observe:** The logs should show the following:

```
...
===================================
       GITHUB AGENT CONFIG      
===================================
AGENT_URL: http://agent-github-p2p:8000⁠
===================================
===================================
       KB-RAG AGENT CONFIG      
===================================
AGENT_URL: http://kb-rag:8000⁠
===================================
2025-08-21 14:10:48,082 - INFO - ✅ Added github to registry (reachable)
2025-08-21 14:10:48,082 - INFO - ✅ Added kb-rag to registry (reachable)
...
```

The docker-compose stack should start the following services:

- `platform-engineer-p2p` : The platform engineer supervisor agent
- `agent-github-p2p` : The git agent
- `kb-rag-agent` : The RAG agent
- `kb-rag-server` : The RAG server
- `kb-rag-web`: The RAG web interface
- `milvus-standalone`: The Milvus vector database
- `etcd`: Needed for Milvus
- `minio`: Needed for Milvus


**🫸 Wait:** Wait until this process is completed.


You can verify the supervisor agent is healthy by running:

```bash
curl http://localhost:8000/.well-known/agent.json | jq
```


## Step 2: Populate RAG database

Now, we will populate the RAG with documentation. The docker-compose stack should have started the `kb-rag-web` service, which is the web ui
for the RAG server. 

[Open the RAG Web UI by clicking here (Opens in new tab)](%%RAG_WEB_URL%%)

Once the RAG Web UI is open:

1. Copy the URL for Mars wiki page (https://en.wikipedia.org/wiki/Mars) and paste it in `Ingest URL` field
2. Click `Ingest` button
3. **🫸 Wait:** Wait for the ingestion to complete


**👀 Observe:** The status should show as `✅ Successfully processed 1 URL(s)`

<img src="images/rag-ui-screenshot.png" alt="RAG UI" width="400">

### Explanation:

Here's what happens:

 - The RAG server crawls webpage (it also supports sitemap), and fetches the page.
 - The HTML is parsed and content is extracted.
 - If the page is too large, it is split into chunks, using [Recursive Text Splitter](https://python.langchain.com/docs/how_to/recursive_text_splitter/).
 - Each chunk is sent to embedding model (LLM in this case) to generate embeddings.
 - The embeddings are stored in a vector store (Milvus), along with metadata (source, title, description etc).
 
<br>
<img src="images/rag-ingestion.png" alt="RAG ingestion" width="400">


## Step 3: Verify RAG System is working

We will now use the UI to query the RAG system and verify it is working.

[Go back to the Web UI](%%RAG_WEB_URL%%)

Query `Axial tilt` and click the `Search` button

**👀 Observe:** The response should return relevant document chunks. The chunks may not be formatted in a way that is easy to read. As long as some document chunks are returned, the RAG system is working.

## Step 4: Using the RAG Agent

**➕ Open another terminal (top-right '+' icon)**, and run the following command:

```bash
docker run -it --network=host ghcr.io/cnoe-io/agent-chat-cli:stable
```

Note: When prompted for token, press enter.

This should open a CLI chat client. You can now interact with the supervisor agent.

Ask the agent - `What is the axial tilt of Mars?`

**👀 Observe:** The agent should respond with the axial tilt of Mars, and cite the source of the information.

### Explanation:

Here's what happens:

 - The RAG agent embeds the question using the same embedding model used to embed the documents.
 - The agent then uses the vector store to find the most similar documents.
 - The agent uses the retrieved document chunks to answer the question.

<br>
<img src="images/rag-agent-arch.png" alt="RAG Agent Architecture" width="400">

## Step 5: Multi-agent interaction

Now, we will test the multi-agent interaction by asking the supervisor agent to: 
 - search for information about Mars (reconnaissance) 
 - commit the steps to git repository (report back).


In the CLI chat client, ask the agent:

```
Research and write a report on mars surface, then commit it as a text file to my github repository https://github.com/subbaksh/agent-report-workshop
```

**👀 Observe:** The agent should create a report, commit it to git and push it to the repository.


## Mission Checks

- ✅ Launch RAG + Git agent stack successfully
- ✅ Import Mars wiki into RAG
- ✅ Verify RAG queries return relevant documentation
- ✅ Connect chat client to multi-agent supervisor
- ✅ Test knowledge retrieval: "What is the axial tilt of Mars?"
- ✅ Test multi-agent interaction: Documentation search + git operations


## Further Reading

### Graph RAG

The AI platform engineering repository also includes **Graph RAG**, which uses Neo4J to create knowledge graphs from structured data (K8s objects, AWS resources). 
See the [Graph RAG documentation](https://cnoe-io.github.io/ai-platform-engineering/knowledge_bases/graph_rag) for more details, and how to run it in your local environment.

### RAG Agent

More information on the RAG agent can be found [here](https://github.com/cnoe-io/ai-platform-engineering/tree/main/ai_platform_engineering/knowledge_bases/rag).

### Unified Knowledge Base

Currently there is a open discussion on how to unify different RAG systems, and create a unified knowledge base thats specialized for AI platform engineering. Please follow the discussion [here](https://github.com/cnoe-io/ai-platform-engineering/discussions/196).

### Github agent

The Github agent can be used as is. Please refer to the [Github agent documentation](https://github.com/cnoe-io/ai-platform-engineering/tree/main/ai_platform_engineering/agents/github) for more details.