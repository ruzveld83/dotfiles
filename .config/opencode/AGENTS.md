# Agent Delegation Rules

**CRITICAL: Subagent Prompting & Context Management**
When you (the primary agent) delegate a task to the Explore subagent, you must instruct it to protect our context window. 

When writing the prompt for the Explore subagent, you MUST explicitly include the following conditional rules:
1. **Summarize over dumping:** "You are encouraged to read file contents internally to search for specific logic or context. If you find the relevant information, return a concise summary and only the specific, relevant code snippets."
2. **Never dump full files:** "Under NO circumstances should you output the complete raw contents of a file in your response."
3. **Pass addresses for deep work:** "If you determine that I (the main agent) need to read, analyze, or modify the entire file, return ONLY the exact file path. I will use that path to read the file directly into my own context."
