# Mission Check 7 — Tracing and Evaluation

In this mission, you’ll enable tracing with Langfuse and observe your app’s behavior end-to-end.

Steps:

1) Log in to Langfuse

   - Go to https://langfuse.dev.outshift.io/
   - Email: workshop@outshift.io
   - Password: workshop-mars-colony

2) Create an API key

   - In the Langfuse UI, open your project (or create/select the default project).
   - Navigate to Settings → API Keys.
   - Create a new API key and copy both the public and secret values.

3) Configure your environment

   - Open your .env file and add the following (replace with your generated keys).

   Example:
   ```
   LANGFUSE_PUBLIC_KEY=pk-lf-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   LANGFUSE_SECRET_KEY=sk-lf-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   LANGFUSE_TRACING_ENABLED=True
   LANGFUSE_HOST=https://langfuse.dev.outshift.io
   ```

4) Start Mission 7 services

   - Run:
     ```
     IMAGE_TAG=latest docker-compose -f workshop/docker-compose.mission7.yaml up
     ```

5) Run the chat CLI and make an example query

   - Run:
   ```
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

