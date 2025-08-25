# 📡 Welcome: Mission Director’s Briefing

<img src="images/mission-control.svg" alt="Mission Control" width="450">

After months of preparation, your crew has finally landed on Mars 🟠. Now it’s time to establish Mission Control operations with Agentic AI 📡🤖🚀 to keep the colony running smoothly.

## 🎯 Your mission:

Set up 🛰️ communication and 🌦️ weather monitoring systems to support life in the new habitat, while staying connected to Earth 🌍 with regular updates on your progress.

And most importantly, bring up the full CAIPE system — your command center for running Mission Control — so every operation is coordinated, automated, and mission-ready.

Along the way, you’ll complete a series of Mission Checks to ensure your systems — and your crew — are ready for anything.

With CAIPE — your superhero “cape” for platform engineering 🦸 — you’ll deploy agents to handle communications, weather tracking, and mission-critical operations.

Now, let’s start with a **quick intro to CAIPE** before the full mission checklist briefing.

&nbsp;

## What is CAIPE (Community AI Platform Engineering)

<img src="images/caipe.svg" width="200" height="200" alt="CAIPE Logo">

[Intro Slides](https://cisco.sharepoint.com/:p:/r/sites/CAIPE/_layouts/15/Doc.aspx?sourcedoc=%7B2F08FE8C-B1E8-4058-9322-24A24368420B%7D&file=CREA-1183%20CAIPE%20Pitch%20Deck_Generic.pptx&action=edit&mobileredirect=true)


- [**Community AI Platform Engineering (CAIPE)**](https://cnoe-io.github.io/ai-platform-engineering) (pronounced as `cape`) is an open-source, Multi-Agentic AI System (MAS) supported by the [CNOE (Cloud Native Operational Excellence)](https://cnoe.io) forum.
- CAIPE provides a secure, scalable, persona-driven reference implementation with built-in knowledge base retrieval that streamlines platform operations, accelerates workflows, and fosters innovation for modern engineering teams.
- It integrates seamlessly with Internal Developer Portals like Backstage and developer environments such as VS Code, enabling frictionless adoption and extensibility.

_CAIPE is empowered by a set of specialized sub-agents that integrate seamlessly with essential engineering tools. Below are some common platform agents leveraged by the MAS agent:_

* ☁️ AWS Agent for cloud ops
* 🚀 ArgoCD Agent for continuous deployment
* 🚨 PagerDuty Agent for incident management
* 🐙 GitHub Agent for version control
* 🗂️ Jira/Confluence Agent for project management
* ☸ Kubernetes Agent for K8s ops
* 💬 Slack/Webex Agents for team communication
* 📊 Splunk Agent for observability

...and many more platform agents are available for additional tools and use cases.

**_Tip:💡 CAIPE (Community AI Platform Engineering), pronounced like cape (as in a superhero cape 🦸‍♂️🦸‍♀️). Just as a 🦸‍♂️ cape empowers a superhero, CAIPE empowers platform engineers with 🤖 Agentic AI automation! 🚀_**

**References:**

- [https://cnoe-io.github.io/ai-platform-engineering/](https://cnoe-io.github.io/ai-platform-engineering/)
- [Intro Slides](https://cisco.sharepoint.com/:p:/r/sites/CAIPE/_layouts/15/Doc.aspx?sourcedoc=%7B2F08FE8C-B1E8-4058-9322-24A24368420B%7D&file=CREA-1183%20CAIPE%20Pitch%20Deck_Generic.pptx&action=edit&mobileredirect=true)

&nbsp;

## CAIPE Badges

Here’s a polished version of your text with improved flow and consistency:

* 🎖️ Everyone who completes the workshop and reaches **Level 7** will earn the **`Explorer` badge**. You can proudly showcase this achievement on your **Cisco Directory profile** or **LinkedIn**.
* 📧 After the workshop, we’ll send you and your manager a **formal email** confirming your participation in the CAIPE workshop.
* 🚀 You can earn additional badges by continuing your learning journey: **attending monthly office hours**, **joining open-source community meetings**, and **contributing to the CAIPE project**.

**More details about badges, progression, and the learning path can be found here:
[https://cisco.sharepoint.com/sites/CAIPE/SitePages/CAIPE-Digital-Badges.aspx](https://cisco.sharepoint.com/sites/CAIPE/SitePages/CAIPE-Digital-Badges.aspx)**

| Badge Level        |   |   | Badge Image                                                                 |
|--------------------|---|---|-----------------------------------------------------------------------------|
| 🚀 CAIPE Explorer  |   |   | <img src="images/badge-explorer.svg" alt="CAIPE Explorer" width="50">      |
| ⚡ CAIPE Improver  |   |   | <img src="images/badge-improver.svg" alt="CAIPE Improver" width="50">      |
| 🎯 CAIPE Expert    |   |   | <img src="images/badge-expert.svg" alt="CAIPE Expert" width="50">          |
| 👑 CAIPE Master    |   |   | <img src="images/badge-master.svg" alt="CAIPE Master" width="50">          |

&nbsp;

## Mission Checks

- **Mission Check 1 — Start Ignition: Download Mission and Learn the Controls** 🚀📝
    - Clone the repo, set up prerequisites, and bring Mission Control online. 🛰️
    - Learn the basics of Agentic AI and AGNTCY. 🤖

- **Mission Check 2 — Create Life** 🧬✨
    - Run the **Petstore Agent** 🐾 and confirm your first AI agent is alive. ⚡

- **Mission Check 3 — Cosmic Forecast** 🌌🌫️
    - Introduce the **Weather Agent** to monitor weather on Earth and Mars
    - Run the **CAIPE** multi-agent system with Petstore and Weather agents. ☁️

- **Mission Check 4 — Reconnaissance & Reporting: Knowledge Base RAG and Reporting** 📚🧠
    - Integrate the Retrieval Augmented Generation Agent.
    - Launch the **Knowledge Base RAG system** 🗂️, ingest docs, and query them. 🔍
    - Use the **GitHub + Work Tracking Agent** 🐙📋 to write a combined report from Petstore, Weather, and RAG. 📨

- **Mission Check 5 — Assemble Full CAIPE with idpbuilder** 🛠️📦
    - Package the full CAIPE stack into reproducible, deployable bundles. 🎁
    - **Bonus:** Run CAIPE with AGNTCY SLIM. 🦾

- **Mission Check 6 — Tracing and Evaluation** 🕵️‍♂️📊
    - Customize prompts, enable tracing, and evaluate agent workflows. 🧪

- **Mission Debrief** 🛰️🤝
    - Conclusion and Next Steps. 🌟

- **Bonus — AGNTCY**
    - Learn and try out AGNTCY components.

&nbsp;

## Workshop Logistics and Support

- **🔍 Demo Lab Navigation**
  - Easily switch between the **Lab Guide**, **Terminal**, and **IDE** using the toggles in the **top right corner** of your screen.
  - Familiarize yourself with the interface before starting your missions for a smoother experience.

- **💻 Workspace Directory**
  - Your main workspace is located at: `/home/ubuntu/work`
  - Use the **IDE** toggle (top right) to access your files and code editor.
  - For terminal navigation, try using [`mc` - Midnight Commander](https://linuxcommand.org/lc3_adv_mc.php) (a visual file manager). Launch it in the terminal for a split-pane view.

- **🆘 Need Help?**
  - Raise your hand and chat with a workshop team member during the session so a team member can start a breakout session.
  - For additional help, check out the [CAIPE FAQs](https://cisco.sharepoint.com/sites/CAIPE/SitePages/CAIPE-FAQs.aspx) for answers to common workshop and platform questions.

- **🤝 Breakout Sessions**
  - The instructor will guide the lab at a steady pace, but each Mission Check is timed to ensure we cover all the key objectives.
  - For help during any Mission Check, a **dedicated Webex breakout session is available**. You can join the breakout room to get assistance, then return to the main session once your question is answered.
  - Feel free to move between the main session and the breakout as needed—this way, everyone can get support without missing the overall mission flow.

- **⏳ Lab Availability**
  - Your lab environment will remain active for **36 hours** after the workshop, until **EOD Thursday (Pacific Time)**.
  - Please save your work and download any important files before your instance is terminated (as hosting VMs incurs costs).

---

## 🛰️ **Optional: Local Setup Preflight**

**We got you covered with lab environment. No need to bring any extra setup**

* **Integrated Lab Access**
  We’ve set up a ready-to-go lab environment. You’ll also have **temporary LLM access** during the workshop **and for 36 hours afterward** — so you can keep tinkering after we land.

* **Optional Local Launch Pad**
  Want to try running the stack on your own setup? Here are the **recommended specs** for smooth orbit:

  * **8 CPUs**
  * **16 GB RAM**
  * Docker installed and ready
    This ensures your systems don’t burn up during re-entry.

* **LLM Keys**
  For access to long-term LLM usage beyond the lab, request your keys via the Circuit portal:
  [🔗 **Circuit SharePoint: API & RAG Options**](https://cisco.sharepoint.com/sites/CIRCUIT/SitePages/API-RAG-options.aspx?web=1)


If you run into turbulence or want to study up before or after the mission, check out our [🔗 **CAIPE Sharepoint**](https://cisco.sharepoint.com/sites/CAIPE/)

---

## 🌠 **Final Call**

Suit up, power up your consoles, and get ready to take control of the **next frontier of AI-driven operations**. The future of our Mars colony — and the safety of your crew — depends on your engineering skills.

**Countdown to launch starts now…**
**T-minus 3… 2… 1… 🚀**