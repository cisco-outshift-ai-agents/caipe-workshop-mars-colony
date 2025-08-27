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


##add warning
agent isn't authenticted when using through backstage. this will be fixed in the coming weeks.



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
  --package https://github.com/suwhang-cisco/stacks//ref-implementation-workshop \
  --package https://github.com/suwhang-cisco/stacks//ai-platform-engineering
```

<div style="border: 1px solid #dc3545; border-left: 6px solid #dc3545; background-color: #fff5f5; padding: 16px; margin: 16px 0; border-radius: 4px;">
  <strong>⏰ Expected Output (Cluster Created, NOT Fully Deployed Yet)</strong>
  <p style="margin: 8px 0 0 0;">
    After the command completes, you should see output like the sample below. This confirms KIND cluster creation and that ArgoCD is reachable, <strong>but it does NOT mean the whole platform is deployed</strong>. ArgoCD will continue pulling images and bringing pods online, which typically takes <strong>5–10 minutes</strong>.
  </p>
</div>

```text
...
########################### Finished Creating IDP Successfully! ############################


Can Access ArgoCD at https://cnoe.localtest.me:8443/argocd
Username: admin
Password can be retrieved by running:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo
```

<div style="border: 1px solid #dc3545; border-left: 6px solid #dc3545; background-color: #fff5f5; padding: 16px; margin: 16px 0; border-radius: 4px;">
  <strong>🚨 Massive Warning for Lab Environment Users</strong>
  <ul style="margin: 8px 0 0 16px;">
    <li><strong>Do NOT use</strong> <code>https://cnoe.localtest.me:8443/argocd</code> in the lab environment — that URL is only for local installs.</li>
    <li>Follow the steps below to set <code>&#36;LABURL</code> (Step 1) and then open ArgoCD using <code>https://&#36;LABURL:6101/argocd/</code> (Step 3.2).</li>
  </ul>
</div>

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

The lab URL will be automatically detected from the lab environment details:

```bash
export LABURL=`head -n 3 /usr/share/etilabs/details | tail -1`
echo "Lab URL automatically set to: $LABURL"
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
<li><strong>Lab Environment</strong>: Use the URLs with your <code>$LABURL</code> environment variable as shown below</li>
<li><strong>Local Environment</strong>: Replace <code>https://$LABURL:6101,6102</code> with <code>https://cnoe.localtest.me:8443</code> in all commands</li>
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

<a href="/argocd/" onclick="javascript:event.target.port=6101" target="_blank">Open ArgoCD by clicking here (opens in new tab)</a>

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

**Note:** Vault will be on the 2nd page of the ArgoCD UI.

<img src="images/argocd-vault-sync.svg" alt="Vault application sync status" style="width: 60%; max-width: 400px;">

### 4.2: Port forward to Vault service

First, open up a **new terminal** and run the below command to port forward to Vault service so we can use this to directly access the vault service:

```bash
# Port forward Vault service (run in background)
kubectl port-forward -n vault svc/vault 8200:8200
```

### 4.3: Configure Vault CLI

Now, come back to the original terminal and run the below commands to configure the vault cli with the root token:

```bash
export VAULT_ADDR="http://localhost:8200"
export VAULT_TOKEN=$(kubectl get secret -n vault vault-root-token -o jsonpath='{.data.token}' | base64 -d)
vault login "$VAULT_TOKEN"
```

<a id="step-4-4"></a>
### 4.4: Verify Vault CLI is working and check existing secrets

Run below command to list existing secret paths:

```bash
vault kv list secret/ai-platform-engineering/
```

This should return a list of keys that exist in the `ai-platform-engineering` namespace:

```
Keys
----
argocd-secret
backstage-secret
github-secret
global
jira-secret
pagerduty-secret
slack-secret
```

which are pre-populated vault secret paths but the actual secrets are not populated yet.

### 4.5: Configure Global LLM Credentials

We will use the credentials from the `.env_vars` file you have been using for the workshop to populate the global LLM credentials:

```bash
source $HOME/.env_vars
vault kv put secret/ai-platform-engineering/global \
  LLM_PROVIDER=azure-openai \
  AZURE_OPENAI_API_KEY="${AZURE_OPENAI_API_KEY}" \
  AZURE_OPENAI_ENDPOINT="${AZURE_OPENAI_ENDPOINT}" \
  AZURE_OPENAI_DEPLOYMENT="${AZURE_OPENAI_DEPLOYMENT}" \
  AZURE_OPENAI_API_VERSION="${AZURE_OPENAI_API_VERSION}" \
  AWS_ACCESS_KEY_ID="" \
  AWS_SECRET_ACCESS_KEY="" \
  AWS_REGION="" \
  AWS_BEDROCK_MODEL_ID="" \
  AWS_BEDROCK_PROVIDER="" \
  OPENAI_API_KEY="" \
  OPENAI_ENDPOINT="" \
  OPENAI_MODEL_NAME=""
```

and now check this secret has been correctly stored in vault:

```bash
vault kv get secret/ai-platform-engineering/global
```

<div style="border: 1px solid #17a2b8; border-left: 4px solid #17a2b8; background-color: #f0ffff; padding: 16px; margin: 16px 0; border-radius: 4px;">
<strong>📝 Note:</strong> We support other LLM providers as well. Currently, we support Azure OpenAI, OpenAI, and AWS Bedrock. Check out our <a href="https://cnoe-io.github.io/ai-platform-engineering/getting-started/idpbuilder/setup#step-3-update-secrets">documentation</a> for more details.
</div>

### 4.6: Configure Agent-Specific Secrets

As you saw in [Step 4.4](#step-4-4), we have several sub-agents configured to work in this platform. For this workshop, we will only use a subset of the agents, but if you have personal credentials for other agents, feel free to populate the secrets for those agents as well.

**4.5.1: GitHub Agent**

Github token has already been configured in the `.env_vars` file you have been using for the workshop. Now, we will populate the github-secret in vault:

```bash
vault kv put secret/ai-platform-engineering/github-secret \
  GITHUB_PERSONAL_ACCESS_TOKEN="${GITHUB_PERSONAL_ACCESS_TOKEN}"
```

Verify the github-secret has been correctly stored in vault:

```bash
vault kv get secret/ai-platform-engineering/github-secret
```

**4.5.2: ArgoCD Agent**

First open a new terminal and port forward the ArgoCD service:

```bash
kubectl port-forward -n argocd svc/argocd-server 8080:80
```

Then now we will populate:

```bash
export ARGOCD_TOKEN=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)
vault kv put secret/ai-platform-engineering/argocd-secret \
  ARGOCD_API_URL="http://localhost:8080" \
  ARGOCD_VERIFY_SSL="false" \
  ARGOCD_TOKEN="${ARGOCD_TOKEN}"
```

Verify the argocd-secret has been correctly stored in vault:

```bash
vault kv get secret/ai-platform-engineering/argocd-secret
```

**4.5.3: [Optional] Configure other agents**

For the remaining agents (Backstage, Jira, PagerDuty, Slack), you can populate their secrets using the same approach if you have credentials for those services. To see what keys each agent requires, first examine their placeholder secrets in Vault:

```bash
vault kv get secret/ai-platform-engineering/$AGENT_NAME-secret
```

Then, you can populate the secrets in the same way as the github and argocd agents:

```
vault kv put secret/ai-platform-engineering/$AGENT_NAME-secret \
  <key1>=<value1> \
  <key2>=<value2> \
  ...
```

### 4.6: Refresh Colony Secrets

First, we need to force the secret refresh across the colony:

```bash
kubectl delete secret --all -n ai-platform-engineering
```

Once deleted, external secrets manager will automatically re-create the secrets with the latest values. Run below command to verify that the secrets have been re-created:

```bash
kubectl get secrets -n ai-platform-engineering
```

Then, we need to restart the agent pods to pick up the new secrets:

```bash
kubectl delete pod --all -n ai-platform-engineering
```

## Step 5: Access Colony Developer Portal (Backstage)

Configure and access the main developer portal for the colony.

### 5.1: Verify Backstage Deployment

First, ensure Backstage is synced in ArgoCD. If there are issues, go to ArgoCD and click sync. Select only the postgres and backstage deployment resources if they're marked as missing.

### 5.2: Pause Auto-Sync for Configuration

Pause syncing for Backstage and Keycloak deployments so we can make lab-specific changes:

```bash
kubectl -n argocd patch application backstage --type=merge -p='{"spec":{"syncPolicy":{"automated":{"prune":false,"selfHeal":false}}}}'
kubectl -n argocd patch application keycloak --type=merge -p='{"spec":{"syncPolicy":{"automated":{"prune":false,"selfHeal":false}}}}'
```

### 5.3: Configure Lab Environment URLs

Update Keycloak configuration for the lab environment:

```bash
export LABURL=`head -n 3 /usr/share/etilabs/details | tail -1`
kubectl get configmap keycloak-config -n keycloak -o yaml | \
  sed "s/hostname=cnoe.localtest.me/hostname=${LABURL}/" | \
  sed 's/hostname-port=8443/hostname-port=6101/' | \
  sed "s/hostname-admin=cnoe.localtest.me:8443/hostname-admin=${LABURL}:6101/" | \
  kubectl apply -f -
```

Update Backstage external secrets configuration:

```bash
export LABURL=`head -n 3 /usr/share/etilabs/details | tail -1`
kubectl -n backstage patch externalsecret backstage-oidc --type=merge -p="{\"spec\":{\"target\":{\"template\":{\"data\":{\"AGENT_FORGE_URL\":\"https://${LABURL}:6101/ai-platform-engineering\",\"BACKSTAGE_FRONTEND_URL\":\"https://${LABURL}:6101\",\"KEYCLOAK_NAME_METADATA\":\"https://${LABURL}:6101/keycloak/realms/cnoe/.well-known/openid-configuration\"}}}}}"
```

Update Backstage app configuration:

```bash
# Get current config, modify specific lines, and escape for JSON
MODIFIED_CONFIG=$(kubectl -n backstage get configmap backstage-config -o jsonpath='{.data.app-config\.yaml}' | \
  sed 's|^    baseUrl: https://cnoe.localtest.me:8443|    baseUrl: https://'${LABURL}':6101|' | \
  sed 's|^      baseUrl: https://cnoe.localtest.me:8443|      baseUrl: https://'${LABURL}':6101|' | \
  sed 's|^        origin: https://cnoe.localtest.me:8443|        origin: https://'${LABURL}':6101|' | \
  sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

kubectl -n backstage patch configmap backstage-config --type merge -p "{\"data\":{\"app-config.yaml\":\"$MODIFIED_CONFIG\"}}"
```

### 5.4: Update Environment Variables

Set the Backstage deployment environment variables:

```bash
LABURL=$(head -n 3 /usr/share/etilabs/details | tail -1)
kubectl -n backstage set env deploy/backstage \
  APP_CONFIG_app_baseUrl=https://$LABURL:6101 \
  APP_CONFIG_backend_baseUrl=https://$LABURL:6101 \
  KEYCLOAK_NAME_METADATA=https://$LABURL:6101/keycloak/realms/cnoe/.well-known/openid-configuration \
  APP_CONFIG_backend_cors_origin=https://$LABURL:6101
```

### 5.5: Reset Database and Services

Reset the PostgreSQL database and restart services:

```bash
# Namespace
NS=backstage

# Scale Postgres down
kubectl -n $NS scale sts/postgresql --replicas=0

# Capture PV name and delete PVC (wipes DB data)
PV=$(kubectl -n $NS get pvc data-postgresql-0 -o jsonpath='{.spec.volumeName}')
kubectl -n $NS delete pvc data-postgresql-0

# If PV reclaim policy is Retain, delete the PV as well
kubectl get pv "$PV" -o jsonpath='{.spec.persistentVolumeReclaimPolicy}'; echo
kubectl delete pv "$PV" || true

# Scale Postgres up (re-initializes with POSTGRES_* from backstage-env-vars)
kubectl -n $NS scale sts/postgresql --replicas=1
kubectl -n $NS rollout status sts/postgresql

# Restart Backstage to connect to fresh DB and pick up overrides
kubectl -n $NS rollout restart deploy/backstage
kubectl -n $NS rollout status deploy/backstage
```

Also restart the keycloak pod:

```bash
kubectl -n keycloak rollout restart deploy/keycloak
kubectl -n keycloak rollout status deploy/keycloak
```

### 5.6: Get Keycloak Admin Credentials

In a new terminal:

```bash
kubectl -n keycloak port-forward svc/keycloak 18080:8080 &
```

Then back in the original terminal, run below commands to get the keycloak admin credentials:

```bash
KC=http://127.0.0.1:18080/keycloak
ADMIN_PASS=$(kubectl -n keycloak get secret keycloak-config -o jsonpath='{.data.KEYCLOAK_ADMIN_PASSWORD}' | base64 -d)

# Fresh token
TOKEN=$(curl -sS -X POST -H 'Content-Type: application/x-www-form-urlencoded' \
  --data 'username=cnoe-admin' --data-urlencode "password=$ADMIN_PASS" \
  --data 'grant_type=password' --data 'client_id=admin-cli' \
  $KC/realms/master/protocol/openid-connect/token | jq -r .access_token)

MID=$(curl -sS -H "Authorization: Bearer $TOKEN" \
  "$KC/admin/realms/master/clients?clientId=security-admin-console" | jq -r '.[0].id')

# Backstage client id
CID=$(curl -sS -H "Authorization: Bearer $TOKEN" \
  "$KC/admin/realms/cnoe/clients?clientId=backstage" | jq -r '.[0].id')
```

```bash
curl -sS -H "Authorization: Bearer $TOKEN" "$KC/admin/realms/master/clients/$MID" \
| jq --arg origin "https://${LABURL}:6101" \
     --arg r1 "https://cnoe.localtest.me:8443/keycloak/admin/master/console/*" \
     --arg r2 "https://${LABURL}:6101/keycloak/admin/master/console/*" '
  .webOrigins   = ((.webOrigins   // []) + [$origin]    | unique) |
  .redirectUris = ((.redirectUris // []) + [$r1, $r2]    | unique)
' > /tmp/sec-admin.json
```

```bash
curl -sS -X PUT -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" \
  --data @/tmp/sec-admin.json "$KC/admin/realms/master/clients/$MID"
```

```bash
# Add exact LAB redirect + origin (run immediately)
LABURL=$(head -n 3 /usr/share/etilabs/details | tail -1)
LAB_CB="https://${LABURL}:6101/api/auth/keycloak-oidc/handler/frame"
LAB_ORIGIN="https://${LABURL}:6101"

CFG=$(curl -sS -H "Authorization: Bearer $TOKEN" "$KC/admin/realms/cnoe/clients/$CID")
echo "$CFG" \
| jq --arg cb "$LAB_CB" --arg origin "$LAB_ORIGIN" \
   '.redirectUris = ((.redirectUris // []) + [$cb] | unique)
  | .webOrigins   = ((.webOrigins   // []) + [$origin] | unique)' \
> /tmp/client.json
```

```bash
curl -sS -X PUT -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" \
  --data @/tmp/client.json \
  "$KC/admin/realms/cnoe/clients/$CID"
```

### 5.7: Optional: Get Colony Portal Credentials

Now check keycloak admin console:

```bash
kubectl -n keycloak get secret keycloak-config -o jsonpath='{.data.KEYCLOAK_ADMIN_PASSWORD}' | base64 -d; echo
```

Username: cnoe-admin
Password: <from the command above>

### 5.8: Login to Colony Developer Portal

Open Backstage in your browser:

<a href="/" onclick="javascript:event.target.port=6101" target="_blank">Open Backstage by clicking here (opens in new tab)</a>

Then login with:

- Username: `user1`
- Password: `<from the command above>`

## Step 6: Activate Colony AI Assistant

Access and test the multi-agent AI system integrated into Backstage.

### 6.1: Access the AI Assistant

Once logged into the Developer Portal:

1. 🤖 Look for the AI agent icon in the bottom-right corner
2. 🚀 Click to open the colony AI assistant
3. 💬 Start interacting with the multi-agent platform engineering system

### 6.2: Test Basic Functionality

Try these essential colony operations:

```bash
What can you do?
```

### 6.3: Test Agent-Specific Features

If you configured additional agent secrets, test their functionality:

**PagerDuty Agent** (if configured):
```bash
Who is on call right now?
```

**Jira Agent** (if configured):
```bash
Show me existing projects in Jira.
```

### 6.4: Explore the Platform

## Useful URLs

Use the links below to open the various colony services in your browser:

<a href="/argocd/" onclick="javascript:event.target.port=6101" target="_blank">Open ArgoCD (opens in new tab)</a>

<a href="/gitea/" onclick="javascript:event.target.port=6101" target="_blank">Open Gitea (opens in new tab)</a>

Vault accessible via kubectl port-forward on localhost:8200

<a href="/" onclick="javascript:event.target.port=6101" target="_blank">Open Backstage (opens in new tab)</a>

<a href="/keycloak/admin/master/console/" onclick="javascript:event.target.port=6101" target="_blank">Open Keycloak Admin Console (opens in new tab)</a>

## Step 7: Tear down the colony platform

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
