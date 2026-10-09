# Gemini CLI — File & Workspace Scoping

> **Note:** This document covers the **Gemini CLI** — Google's interactive
> terminal tool (`gemini` command). It is *not* about the Gemini LLM API
> integration used by this project's Agent Builder API.
> For the project-level Gemini LLM provider, see
> [`agentbuilder/llm/gemini_llm.py`](../agentbuilder/llm/gemini_llm.py)
> and the [Gemini configuration section in the README](../README.md#configuring-models).

## Background

The error:

```
Unknown arguments: all-files, allFiles
```

means **Gemini CLI does not have a `--all-files` or `--allFiles` flag**.
The CLI automatically includes the current working directory as its workspace;
you don't need a flag to "enable all files."

This guide explains how to actually control file / workspace scope in Gemini
CLI when working on the Agent Builder API project or any other
multi-directory codebase.

---

## 1. Include additional directories (multi-directory workspace)

If you want Gemini to see files **outside** the current directory, use
`--include-directories` (or `-I`):

```bash
# Include one extra directory
gemini --include-directories ../backend

# Include multiple directories (colon-separated)
gemini --include-directories "../backend:../frontend"

# Or pass them as separate arguments
gemini --include-directories path/to/dir1 path/to/dir2
```

You can also add directories dynamically during an interactive session:

```bash
gemini> /directory add ../shared-lib
gemini> /directory show
```

### Agent Builder API example

When developing this project, you might want Gemini CLI to read both the
main source tree and dependency files:

```bash
gemini --include-directories "../agent-builder-api:../common-utils"
```

## 2. Explicitly reference files in a prompt

To force Gemini to read a specific file or directory **right now**, use the
`@` syntax:

```bash
# Single file
gemini "@src/main.js Explain this function"

# Multiple files
gemini "@src/components/User.tsx @src/types/User.ts Refactor the component"

# Entire directory
gemini "@src/utils/ Check for deprecated APIs"
```

### Agent Builder API example

Reference the Gemini LLM provider module directly when asking about the
project's model configuration:

```bash
gemini "@agentbuilder/llm/gemini_llm.py Explain how the Google API key is used"
```

## 3. Persistent multi-directory setup

If you always want certain directories included, add them to your
`settings.json`:

```json
{
  "includeDirectories": ["../shared-library", "~/common-utils"]
}
```

For the Agent Builder API project you might persist:

```json
{
  "includeDirectories": ["agentbuilder", "docs", "../mcp-servers"]
}
```

---

## Summary table

| What you tried | Status | What to use instead |
| --- | --- | --- |
| `--all-files` / `--allFiles` | ❌ Does not exist | Current directory is auto-included |
| Include other folders | — | `--include-directories` or `@path` |

## Related project configuration

This project integrates with Gemini via the **LLM API** (not the CLI):

| Purpose | Setting | Code reference |
| --- | --- | --- |
| Gemini LLM provider | `GOOGLE_API_KEY` env var | [`agentbuilder/llm/gemini_llm.py`](../agentbuilder/llm/gemini_llm.py) |
| Gemini model name | `MODEL_NAME="gemini/gemini-pro"` | [README — Configuring models](../README.md#configuring-models) |
| Gemini embed model | `EMBED_MODEL_NAME="gemini/embedding-001"` | [README — Configuring models](../README.md#configuring-models) |
| Gemini dependency pack | `gemini` (via Poetry extras) | [README — Dependency packs](../README.md#customization) |

If you were looking for a different behavior (e.g., ignoring `.gitignore` or
including hidden files), let me know and I can point you to the right setting.