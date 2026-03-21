---
description: Make AGENTS.md file up to date
agent: build
---

Goal: make AI agents have the most up-to-date and most relevant info about this project.

We should have an @AGENTS.md file that contains all the relevant and up-to-date information about current project. Relevant here means that it would be most helpful for AI agents to work with this project. Example topics to cover:

- Short intro about waht this project does
- If this project has modules, shortly describe each of them
- List technologies used in this project (language, data stores, etc)
- If this project has modules and they communicate with each other by some means (HTTP, gRPC, message queues, etc), add this to the file.
- If there is communication with external services, mention this as well.
- Add commands to build and test (if there are any tests) the project.

Don't mention anything that is not done yet (even if it is planned).

If @AGENTS.md doesn't exist, create it. If @AGENTS.md already exists, make all the necessary adjustments to this file to make it up to date. You can do this in two ways, choose the one that takes less context space:

- Analyze the project from ground up, rewriting the file entirely
- Take a git ref of the last change to that file and inspect all the git diff to the project made since that ref.

If you see the file gets too large (more than, say 200 lines), revise the document and choose the lowest-level information that could be safely removed from the file while preserving the Goal.
