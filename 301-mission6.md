# Mission Check 6 — Deploy CAIPE (Community AI Platform Engineering) with IDPBuilder

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


## Overview

🚀 **Mission Status**: Advanced Mars Inhabitant, you're now ready to deploy the full Community AI Platform Engineering stack to establish the colony's complete AI infrastructure.

In this mission, you'll deploy the comprehensive CAIPE platform using IDPBuilder to create a production-ready AI platform for the Mars colony:

- **🏗️ Platform Foundation**: Deploy ArgoCD, Vault, and Backstage as the core infrastructure
- **🔐 Security & Auth**: Configure Keycloak for single sign-on and Vault for secret management
- **🤖 AI Multi-Agent System**: Deploy the complete multi-agent orchestrator with specialized agents
- **📊 Developer Portal**: Access Backstage with integrated AI assistant capabilities
- **🌐 Service Mesh**: Configure ingress and networking for colony-wide access
- **⚡ Production Ready**: Create a versioned, reproducible platform deployment

For anyone going through the workshop on their own, you can also checkout our [vidcast](https://cnoe-io.github.io/ai-platform-engineering/getting-started/idpbuilder/setup) for a step by step guide on how to deploy the platform using IDPBuilder.

## 🚀 Deploy the Platform (Takes Time!)

**Run this command first since deployment takes several minutes, then read through the architecture while it deploys:**

```bash
idpbuilder create \
  --use-path-routing \
  --package https://github.com/cnoe-io/stacks//ref-implementation \
  --package https://github.com/suwhang-cisco/stacks//ai-platform-engineering
```

⏰ **Colony Deployment Time**: This takes 5-10 minutes - perfect time to read through the documentation below!

This command will:

* Create a KIND cluster for the Mars colony platform
* Install core platform components (ArgoCD, Vault, Backstage)
* Deploy the complete CAIPE multi-agent system
* Configure ingress with path-based routing for colony access

## Architecture Overview

IDPBuilder is a CLI tool that creates a KIND cluster and deploys platform components via ArgoCD. The CAIPE stack adds authentication, secret management, and multi-agent AI capabilities:

![CAIPE Platform Architecture](images/mission6.svg)

### Component Flow

1. **IDPBuilder Initialization**: Creates KIND cluster and deploys ArgoCD + Gitea as foundation
2. **Platform Deployment**: ArgoCD deploys all platform components from Git repositories
3. **Authentication Setup**: Keycloak provides SSO for Backstage and other platform services
4. **Secret Management**: Vault stores secrets, External Secrets distributes to applications
5. **Developer Access**: NGINX Ingress routes traffic, Backstage provides developer portal
6. **AI Integration**: Agent-Forge plugin in Backstage connects to CAIPE MAS Agent
7. **Multi-Agent System**: Orchestrator manages individual agents for different platform domains

## Prerequisites (Local Machine Only)

If you are using your local machine, ensure you have the below prerequisites installed. For anyone using the lab environment for the workshop, the below prerequisites have been pre-installed for you.

- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed and configured
- [IDPBuilder](https://cnoe.io/docs/idpbuilder/installation) binary installed
- Docker Desktop or similar container runtime running

## Step 1: Set Your Lab URL Environment Variable

**Set your lab URL so you can easily access all the services:**

Copy your lab URL from the lab environment e.g. `https://outshift-lab-1234abc.demos.eticloud.io` and set it as an environment variable:

```bash
# Interactive setup - you'll be prompted to enter your lab URL
read -p "Enter your lab URL (including https://): " LAB_URL
# Remove trailing slash if present
LAB_URL=${LAB_URL%/}
export LAB_URL
echo "Lab URL set to: $LAB_URL"
```

## Step 2: Verify Colony Infrastructure

### Check cluster status

```bash
kubectl get nodes
```

### Verify all pods are running across the colony

```bash
kubectl get pods --all-namespaces
```

## Step 3: Access ArgoCD and Monitor Deployments

<div style="border: 1px solid #17a2b8; border-left: 4px solid #17a2b8; background-color: #f0ffff; padding: 16px; margin: 16px 0; border-radius: 4px;">
<strong>📝 Note:</strong>
<ul>
<li><strong>Lab Environment</strong>: Use the URLs with your <code>$LAB_URL</code> environment variable as shown below</li>
<li><strong>Local Environment</strong>: Replace <code>$LAB_URL:6101,6102</code> with <code>https://cnoe.localtest.me:8443</code> in all commands</li>
</ul>
</div>

Once the cluster is created, IDPBuilder outputs the ArgoCD URL for monitoring your colony's platform deployment.

### 3.1: Get ArgoCD Administrative Access

First, extract admin credentials for the ArgoCD UI:

```bash
idpbuilder get secrets -p argocd
```

### 3.2: Access ArgoCD to Monitor Platform Deployment

Open ArgoCD in your browser:

```bash
echo "Click this link to open ArgoCD: $LAB_URL:6101/argocd/"
```

### 3.3: Login to ArgoCD

Use the below credentials to login to ArgoCD:

- Username: `admin`
- Password: `<from step 3.1 above>`

Monitor application sync status. Initial synchronization takes 3-5 minutes as the colony platform comes online.

---

## Step 4: Configure Vault Secrets for Colony Operations

---

### 4.1: Check Vault application sync status

From the ArgoCD UI, you can monitor the sync status of the Vault application. Wait until the sync status is `Synced` for Vault like below:

<img src="images/argocd-vault-sync.svg" alt="Vault application sync status" style="width: 60%; max-width: 400px;">

### 4.2: Extract Vault Administrative Token

After Vault application syncs successfully on ArgoCD, you can extract the root token for colony secret management:

```bash
kubectl get secret vault-root-token -n vault -o jsonpath="{.data}" | \
  jq -r 'to_entries[] | "\(.key): \(.value | @base64d)"'
```

### 4.3: Access Colony Vault Interface

Open Vault in your browser and login with the root token from the previous step.

```bash
echo "Click this link to open Vault: $LAB_URL:6102/"
```

### 4.4: Configure Colony AI Agent Secrets

**4.4.1: Navigate to `secrets/ai-platform-engineering` in Vault UI:**

```bash
   echo "Click this link to open Vault secrets: $LAB_URL:6102/ui/vault/secrets/secret/kv/list/ai-platform-engineering/"
```

**4.4.2: Configure Global LLM Settings:**

The `global` secret is required and contains LLM provider configuration shared across all agents. You can copy this from `.env_vars` file you have been using for the workshop.

```bash
cat $HOME/.env_vars
```

You can copy and paste the output to the `global` secret in the Vault UI.

![Vault UI - Global LLM Settings](images/vault-secrets.svg)

<div style="border: 1px solid #17a2b8; border-left: 4px solid #17a2b8; background-color: #f0ffff; padding: 16px; margin: 16px 0; border-radius: 4px;">
<strong>📝 Note:</strong> We support other LLM providers as well. Currently, we support Azure OpenAI, OpenAI, and AWS Bedrock. Check out our <a href="https://cnoe-io.github.io/ai-platform-engineering/getting-started/idpbuilder/setup#step-3-update-secrets">documentation</a> for more details.
</div>

3. **Configure Agent-Specific Secrets**: For each specialized agent (GitHub, PagerDuty, Jira), populate their respective secrets with required credentials.

4. **Refresh Colony Secrets**:

First, we need to force the secret refresh across the colony:

```bash
kubectl delete secret --all -n ai-platform-engineering
```

Then, we need to restart the agent pods to pick up the new secrets:

```bash
kubectl delete pod --all -n ai-platform-engineering
```

## Step 4: Access Colony Developer Portal (Backstage)

### Get Colony Portal Credentials

Run the below command to get the colony user credentials:

```bash
idpbuilder get secrets | grep USER_PASSWORD | sed 's/.*USER_PASSWORD=\([^,]*\).*/\1/'
```

### Login to Colony Developer Portal

Open Backstage in your browser:

```bash
echo "Click this link to open Backstage: $LAB_URL:6101/"
```

Then login with:

- Username: `user1`
- Password: `<from the command above>`

## Step 5: Activate Colony AI Assistant

Once logged into the Developer Portal:

1. 🤖 Look for the AI agent icon in the bottom-right corner
2. 🚀 Click to open the colony AI assistant
3. 💬 Start interacting with the multi-agent platform engineering system

Try these colony operations:

```bash
What can you do?
```

If you have pagerduty secrets configured, you can also ask:

```bash
Who is on call right now?
```

If you have jira secrets configured, you can also ask:

```bash
Show me existing projects in Jira.
```

Feel free to ask anything else and experiment with the multi-agent system!

## Useful URLs

Run the below commands to open the various colony services in your browser:

```bash
echo "Click this link to open ArgoCD: $LAB_URL:6101/argocd/"
echo "Click this link to open Gitea: $LAB_URL:6101/gitea/"
echo "Click this link to open Vault: $LAB_URL:6102/"
echo "Click this link to open Backstage: $LAB_URL:6101/"
echo "Click this link to open Keycloak: $LAB_URL:6101/keycloak/admin/master/console/"
```

## Step 6: Tear down the colony platform

```bash
kind delete cluster --name localdev
```

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

  <label style="display: block; margin: 10px 0; cursor: pointer;">
    <input type="checkbox" style="margin-right: 10px; transform: scale(1.2);">
    <strong>"Teardown" the colony platform</strong>
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
