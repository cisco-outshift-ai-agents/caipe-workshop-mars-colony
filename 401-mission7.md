# Mission Check 7 — Tracing and Evaluation

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

In this mission, you’ll enable tracing with Langfuse and observe your app’s behavior end-to-end.

Steps:

1) Log in to Langfuse

   - Go to <https://langfuse.dev.outshift.io/>
   - Email: workshop@outshift.io
   - Password: workshop-mars-colony

2) Create an API key

   - In the Langfuse UI, open your project (or create/select the default project).
   - Navigate to Settings → API Keys.
   - Create a new API key and copy both the public and secret values.

3) Configure your environment

    ```bash
    cd $HOME/work
    ```

    ```bash
    git clone https://github.com/cnoe-io/ai-platform-engineering
    ```

   <div style="border: 1px solid #007cba; border-left: 4px solid #007cba; background-color: #f0f8ff; color: #007cba; padding: 14px; margin: 16px 0; border-radius: 4px;">
     <strong>💡 Tip:</strong>
     <ul style="margin: 8px 0 0 18px;">
       <li>You are about to create a <code>.env</code> file containing your Langfuse API secrets.</li>
       <li>Open your <code>.env</code> file and add the following (replace with your generated keys).</li>
     </ul>
   </div>

   ```bash
   cat <<EOF > .env
   LANGFUSE_PUBLIC_KEY=pk-lf-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   LANGFUSE_SECRET_KEY=sk-lf-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   LANGFUSE_TRACING_ENABLED=True
   LANGFUSE_HOST=https://langfuse.dev.outshift.io
   EOF
   ```

   ```bash
   read -s -p "Enter your LANGFUSE_SECRET_KEY (pasted text won't show, just press enter): " LF_SEC_KEY; echo; sed -i "s|^LANGFUSE_SECRET_KEY=.*|LANGFUSE_SECRET_KEY=$LF_SEC_KEY|" .env
   ```

   ```bash
   read -s -p "Enter your LANGFUSE_PUBLIC_KEY (pasted text won't show anything, just press enter): " LF_PUB_KEY; echo; sed -i "s|^LANGFUSE_PUBLIC_KEY=.*|LANGFUSE_PUBLIC_KEY=$LF_PUB_KEY|" .env
   ```

4) Start Mission 7 services

   - Run:

   ```bash
   IMAGE_TAG=latest docker-compose -f workshop/docker-compose.mission7.yaml up
   ```

5) Run the chat CLI and make an example query

   - Run:

   ```bash
   docker run -it --network=host ghcr.io/cnoe-io/agent-chat-cli:stable
   ```
   - Ask the app: *What's the weather in london?*

6) View the trace in Langfuse

   - Return to the Langfuse dashboard.
   - Open Traces and find the new trace for your query.
   - Explore the spans, inputs/outputs, and timing.

Success criteria:

- You can see a complete, versioned trace for your query in Langfuse.
- Your environment is configured for reproducible tracing during development.


## Tear down

<div style="border: 1px solid #dc3545; border-left: 6px solid #dc3545; background-color: #fff5f5; padding: 16px; margin: 16px 0; border-radius: 4px;">
  <strong>🛑 Before You Proceed: Bring Down Your Docker Containers</strong>
  <ul style="margin: 8px 0 0 16px;">
    <li><strong>Important:</strong> Run <code>docker compose down</code> in your terminal to stop and remove all running containers for this demo before moving on to the next steps.</li>
    <li>This ensures a clean environment and prevents port conflicts or resource issues.</li>
  </ul>
</div>

```bash
docker-compose -f workshop/docker-compose.mission7.yaml down
```