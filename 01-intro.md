
# Your Mission - Mission Control for Mars Colony

<img src="images/mission-control.svg" alt="Mission Control" width="450">

You and your team have landed on **Mars** 🟠 to establish **Mission Control operations with Agentic AI**. 📡🤖🚀

🎯 Your **mission** is to set up 🛰️ communication and 🌦️ weather monitoring systems so life in the new habitat runs smoothly, while staying connected to Earth 🌍 by reporting your findings. 📡

Along the way, you’ll complete a **series of Mission Checks**. _We will go over the mission checks shortly_

<!-- - Starting with a single agent 🤖 using MCP and A2A and verify communication over A2A using [agent-chat-cli](https://github.com/cnoe-io/agent-chat-cli)
- Expanding to a distributed multi-agent system using A2A and MCP 🌐 with multiple example agents to build the usecase
- And finally running CAIPE (Community AI Platform Engineering) MAS and interacting with it using rich Backstage Web UI or agent-chat-cli interface. 🖥️🛸 -->

&nbsp;

## CAIPE Badges

- Everyone who participates and go through level in this workshop will receive the `Explorer` badge. You can proudly display this achievement badge on your Cisco Directory profile or on LinkedIn.
- After the workshop has concluded, we will send you and your manager a formal email confirming your participation in the CAIPE workshop.
- Future badges can be earned by continuing your learning progression, attending monthly office hours, participating in open source community meetings, and contributing to the CAIPE project.

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

- **Mission Check 1 — Download Mission and Learn the Controls** 🛰️📝
    - Clone the repo, set up prerequisites, and bring Mission Control online. 🚀

- **Mission Check 2 — Create Life** 🧬🤖
    - Run the **Petstore Agent** 🐾 and confirm your first AI agent is alive. 💡

- **Mission Check 3 — Scan the Skies** 🌌🌪️
    - Introduce the **Multi-Agent Mars Weather** system ☁️ to monitor dust storms. 🌫️

- **Mission Check 4 — Mission Control Manual (KB RAG)** 📚🧠
    - Launch the **Knowledge Base RAG system** 🗂️, ingest docs, and query them. 🔍

- **Mission Check 5 — Report Findings to Earth** 🌍📝
    - Use the **GitHub + Work Tracking Agent** 🐙📋 to write a combined report from Petstore, Weather, and RAG. 📨

- **Mission Check 6 — Assemble with idpbuilder** 🛠️📦
    - Package the full CAIPE stack into reproducible deployable bundles. 🎁

- **Mission Check 7 — Tracing and Evaluation** 🕵️‍♂️📊
    - Customize prompts, enable tracing, and evaluate agent workflows. 🧪

- **Mission Check 8 — Run CAIPE with AGNTCY SLIM** 🌐🤝
    - Deploy with AGNTCY integrations for production-like workflows. 🏭

&nbsp;

## Bonus Missions

* **AGNTCY Intro**
* **AGNTCY — Agent Directory**
* **AGNTCY — SLIM**
* **AGNTCY — Agent Identity**

&nbsp;

## Final Debrief and Takeaways

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
  - Click the **Mission Help** button (the last button on the mission navigation guide) at any time for mission assistance, troubleshooting tips, or to revisit these instructions.
  - For additional help, check out the [CAIPE FAQs](https://cisco.sharepoint.com/sites/CAIPE/SitePages/CAIPE-FAQs.aspx) for answers to common workshop and platform questions.

- **🤝 Breakout Sessions**
  - Each mission begins with a **3–5 minute explanation** from the instructor, followed by group breakout sessions for hands-on practice.
  - Breakout sessions are time-constrained, but if you need more time to complete a mission, just let your instructor know!
  - At the end of each breakout session, you will rejoin the main group for the next mission. Adjustments will be made to ensure everyone can keep up with the missions.

- **⏳ Lab Availability**
  - Your lab environment will remain active for **48 hours** after the workshop, until **EOD Friday (Pacific Time)**.
  - Please save your work and download any important files before your instance is terminated (as hosting VMs incurs costs).

- **📅 Office Hours & Community**
  - Join our **CAIPE Cisco Month Office Hours** for live Q&A, troubleshooting, and networking with the CAIPE community.
  - Find the schedule and join links here: [CAIPE Office Hours](https://cisco.sharepoint.com/sites/CAIPE/SitePages/CAIPE-Office-Hours.aspx)

- **💬 Stay Connected**
  - For ongoing support, updates, and to connect with fellow participants, join our [CAIPE Community Slack Channel and Community meetings](https://cnoe-io.github.io/ai-platform-engineering/community/).

- **📝 Feedback**
  - Share your feedback and suggestions to help us improve future workshops!
  - You will receive a survey email directly from Webex.
 
Here’s a **fun, theme-aligned foreword** in markdown format that you can use for your workshop:

---

## 🛰️ **Preflight Checklist**

Before you begin, make sure you’ve got these essentials in place:

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
