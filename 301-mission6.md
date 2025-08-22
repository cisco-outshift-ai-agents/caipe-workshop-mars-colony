# Mission Check 6 — Deploy CAIPE (Community AI Platform Engineering) with IDPBuilder

## Overview

🚀 **Mission Status**: Advanced Mars colonist, you're now ready to deploy the full Community AI Platform Engineering stack to establish the colony's complete AI infrastructure.

In this mission, you'll deploy the comprehensive CAIPE platform using IDPBuilder to create a production-ready AI platform for the Mars colony:
- **🏗️ Platform Foundation**: Deploy ArgoCD, Vault, and Backstage as the core infrastructure
- **🔐 Security & Auth**: Configure Keycloak for single sign-on and Vault for secret management
- **🤖 AI Multi-Agent System**: Deploy the complete multi-agent orchestrator with specialized agents
- **📊 Developer Portal**: Access Backstage with integrated AI assistant capabilities
- **🌐 Service Mesh**: Configure ingress and networking for colony-wide access
- **⚡ Production Ready**: Create a versioned, reproducible platform deployment

## Architecture Overview

IDPBuilder creates a KIND cluster and deploys platform components via ArgoCD. The CAIPE stack adds authentication, secret management, and multi-agent AI capabilities:

```mermaid
flowchart LR
    subgraph WHITEBG[" "]
        direction LR
        create
        IDB[IDPBuilder] --> create
        IDB --> AC
        IDB --> GITEA

        subgraph KIND["KIND Cluster"]
        subgraph CORE["Core Platform"]
            AC[ArgoCD]
            GITEA[Gitea]
            IG[NGINX Ingress]
            V[Vault]
            KC[Keycloak]
        end

        subgraph PORTAL["Backstage"]
            direction TB
            BS[Backstage]
            AF[Agent-Forge]
            BS --- AF
        end

        subgraph AIPLATFORM["CAIPE (Community AI Platform Engineering)"]
            MA[multi-agent]
            A1[GitHub Agent]
            A2[PagerDuty Agent]
            A3[Jira Agent]
            A4[ArgoCD Agent]
            A5["...other agents"]
        end

        ES[External Secrets]
    end

    subgraph EXT["External"]
        LT[cnoe.localtest.me] ~~~ GH[GitHub Repos]
    end

    %% Key relationships only
    GITEA --> AC
    AC --> BS
    AC --> MA
    AC --> KC
    AC --> V
    AC --> IG

    KC --> BS
    V --> ES
    ES --> MA

    AF --> MA
    MA --> A1
    MA --> A2
    MA --> A3
    MA --> A4
    MA --> A5

        %% External connections
        AC --> GH
        IG --> LT
    end

    %% Styling
    classDef core fill:#e3f2fd,stroke:#1976d2,stroke-width:2px
    classDef portal fill:#e8f5e8,stroke:#388e3c,stroke-width:2px
    classDef ai fill:#fff8e1,stroke:#f57c00,stroke-width:2px
    classDef agents fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    classDef external fill:#fafafa,stroke:#616161,stroke-width:2px
    classDef whitebg fill:#ffffff,stroke:#ffffff,stroke-width:0px

    class AC,GITEA,IG,V,KC,ES core
    class BS,AF portal
    class AIPE ai
    class A1,A2,A3,A4,A5 agents
    class LT,GH external
    class WHITEBG whitebg
```

### Component Flow

1. **IDPBuilder Initialization**: Creates KIND cluster and deploys ArgoCD + Gitea as foundation
2. **Platform Deployment**: ArgoCD deploys all platform components from Git repositories
3. **Authentication Setup**: Keycloak provides SSO for Backstage and other platform services
4. **Secret Management**: Vault stores secrets, External Secrets distributes to applications
5. **Developer Access**: NGINX Ingress routes traffic, Backstage provides developer portal
6. **AI Integration**: Agent-Forge plugin in Backstage connects to CAIPE MAS Agent
7. **Multi-Agent System**: Orchestrator manages individual agents for different platform domains

## Prerequisites

Before beginning this mission, ensure you have:

- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed and configured
- [IDPBuilder](https://cnoe.io/docs/idpbuilder/installation) binary installed
- Your LLM credentials ready (Azure OpenAI, OpenAI, or AWS Bedrock)
- Docker Desktop or similar container runtime running

## Step 1: Create KIND Cluster with IDPBuilder

### Deploy the Complete Platform

```bash
# Create cluster with reference implementation + lightweight AI stack
idpbuilder create \
  --use-path-routing \
  --package https://github.com/cnoe-io/stacks//ref-implementation \
  --package https://github.com/suwhang-cisco/stacks//ai-platform-engineering
```

This command will:
* Create a KIND cluster for the Mars colony platform
* Install core platform components (ArgoCD, Vault, Backstage)
* Deploy the complete CAIPE multi-agent system
* Configure ingress with path-based routing for colony access

⏰ **Colony Deployment Time**: This takes around 5-10 minutes. Perfect time to review your mission objectives! ☕

### Verify Colony Infrastructure

```bash
# Check cluster status
kubectl get nodes

# Verify all pods are running across the colony
kubectl get pods --all-namespaces

# Check ingress configuration for colony access points
kubectl get ingress --all-namespaces
```

## Step 2: Access ArgoCD and Monitor Deployments

Once the cluster is created, IDPBuilder outputs the ArgoCD URL for monitoring your colony's platform deployment.

### Get ArgoCD Administrative Access

```bash
# Extract admin credentials for platform oversight
idpbuilder get secrets -p argocd
```

### Access Colony Platform Dashboard

Open https://cnoe.localtest.me:8443/argocd/ and login with:
- Username: `admin`
- Password: From the command above

Monitor application sync status. Initial synchronization takes 3-5 minutes as the colony platform comes online.

## Step 3: Configure Vault Secrets for Colony Operations

After Vault application syncs successfully on ArgoCD:

### Extract Vault Administrative Token

```bash
# Extract root token for colony secret management
kubectl get secret vault-root-token -n vault -o jsonpath="{.data}" | \
  jq -r 'to_entries[] | "\(.key): \(.value | @base64d)"'
```

### Access Colony Vault Interface

Open https://vault.cnoe.localtest.me:8443/ and login with the root token from the previous step.

### Configure Colony AI Agent Secrets

1. Navigate to `secrets/ai-platform-engineering` in Vault UI: https://vault.cnoe.localtest.me:8443/ui/vault/secrets/secret/kv/list/ai-platform-engineering/

2. **Configure Global LLM Settings** for colony AI operations:

   The `global` secret is required and contains LLM provider configuration shared across all agents:
   - `LLM_PROVIDER`: Choose your provider: `azure-openai`, `openai`, or `aws-bedrock`

   **For Azure OpenAI (Recommended for workshop):**
   ```yaml
   LLM_PROVIDER: "azure-openai"
   AZURE_OPENAI_API_KEY: <your-workshop-api-key>
   AZURE_OPENAI_ENDPOINT: https://platform-interns-eus2.openai.azure.com/
   AZURE_OPENAI_DEPLOYMENT: gpt-4o
   AZURE_OPENAI_API_VERSION: 2025-03-01-preview
   ```

   **For OpenAI:**
   ```yaml
   LLM_PROVIDER: "openai"
   OPENAI_API_KEY: <your-api-key>
   OPENAI_ENDPOINT: <your-endpoint>
   OPENAI_MODEL_NAME: <your-model-name>
   ```

   **For AWS Bedrock:**
   ```yaml
   LLM_PROVIDER: "aws-bedrock"
   AWS_ACCESS_KEY_ID: <your-access-key>
   AWS_SECRET_ACCESS_KEY: <your-secret-key>
   AWS_REGION: <your-region>
   AWS_BEDROCK_MODEL_ID: <your-model-id>
   AWS_BEDROCK_PROVIDER: <your-provider>
   ```

3. **Configure Agent-Specific Secrets**: For each specialized agent (GitHub, PagerDuty, Jira), populate their respective secrets with required credentials.

4. **Refresh Colony Secrets**:

```bash
# Force secret refresh across the colony
kubectl delete secret --all -n ai-platform-engineering
# Restart agent pods to pick up new secrets
kubectl delete pod --all -n ai-platform-engineering
```

## Step 4: Access Colony Developer Portal (Backstage)

### Get Colony Portal Credentials

```bash
# Get colony user credentials
idpbuilder get secrets | grep USER_PASSWORD | sed 's/.*USER_PASSWORD=\([^,]*\).*/\1/'
```

### Login to Colony Developer Portal

Open https://cnoe.localtest.me:8443/ and login with:
- Username: `user1`
- Password: From Step 4 above

## Step 5: Activate Colony AI Assistant

Once logged into the Developer Portal:

1. 🤖 Look for the AI agent icon in the bottom-right corner
2. 🚀 Click to open the colony AI assistant
3. 💬 Start interacting with the multi-agent platform engineering system

Try these colony operations:
```bash
What agents are available in the colony?
```

```bash
Help me manage GitHub repositories for our Mars colony project
```

```bash
Show me the status of our platform deployments
```

## Colony Communication Endpoints

Your Mars colony platform is now accessible at these coordinates:

- **🎯 ArgoCD** (Platform Operations): https://cnoe.localtest.me:8443/argocd/
- **🏠 Backstage** (Developer Portal): https://cnoe.localtest.me:8443/
- **🔐 Vault** (Secret Management): https://vault.cnoe.localtest.me:8443/
- **👤 Keycloak** (Identity Management): https://cnoe.localtest.me:8443/keycloak/admin/master/console/
- **📚 Gitea** (Code Repository): https://cnoe.localtest.me:8443/gitea/

## Mission Checks

<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; border-left: 4px solid #007cba;">
  <h4 style="margin-top: 0; color: #007cba;">🚀 Colony Platform Deployment Checklist</h4>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>✅ Verify prerequisites (kubectl, IDPBuilder) are installed</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>🏗️ Deploy KIND cluster with CAIPE platform using IDPBuilder</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>📊 Access ArgoCD and verify all applications are synced</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>🔐 Configure Vault with LLM credentials and agent secrets</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>🏠 Access Backstage developer portal with colony credentials</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>🤖 Activate AI assistant in Backstage and test multi-agent capabilities</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>🌐 Verify all colony endpoints are accessible and functional</strong>
  </label>

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>🚀 Test platform agent interactions: "What agents are available?"</strong>
  </label>
</div>

## Troubleshooting

### IDPBuilder Deployment Issues
```bash
# Check IDPBuilder logs
idpbuilder get logs

# Verify KIND cluster status
kind get clusters
kubectl cluster-info
```

### Platform Applications Not Syncing
```bash
# Check ArgoCD application status
kubectl get applications -n argocd

# Force sync specific application
argocd app sync <application-name>
```

### Vault Secret Issues
```bash
# Check Vault pod status
kubectl get pods -n vault

# Verify secret creation
kubectl get secrets -n ai-platform-engineering
```

### AI Agent Connection Problems
```bash
# Check agent pod logs
kubectl logs -n ai-platform-engineering -l app=multi-agent

# Restart agent pods
kubectl delete pod --all -n ai-platform-engineering
```

### Complete Colony Platform Reset
```bash
# Destroy and rebuild the entire colony platform
kind delete cluster --name localdev
# Then re-run Step 1
```

## Next Steps

With your colony's CAIPE platform deployed, you're ready for advanced missions:
- **Mission 7**: Integrate custom agents for specific colony operations
- **Mission 8**: Configure automated platform monitoring and alerting
- **Mission 9**: Deploy production workloads using the AI-assisted platform

🎉 **Mission Complete!** Your Mars colony now has a fully operational AI Platform Engineering infrastructure ready to support all future missions!



