The error `Unknown arguments: all-files, allFiles` means **Gemini CLI does not have a `--all-files` or `--allFiles` flag**. The CLI automatically includes the current working directory as its workspace; you don't need a flag to "enable all files."

Here is how to actually control file/workspace scope in Gemini CLI:

### 1. Include additional directories (multi-directory workspace)

If you want Gemini to see files **outside** the current directory, use `--include-directories` (or `-I`):

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

### 2. Explicitly reference files in a prompt

To force Gemini to read a specific file or directory **right now**, use the `@` syntax:

```bash
# Single file
gemini "@src/main.js Explain this function"

# Multiple files
gemini "@src/components/User.tsx @src/types/User.ts Refactor the component"

# Entire directory
gemini "@src/utils/ Check for deprecated APIs"
```

### 3. Persistent multi-directory setup

If you always want certain directories included, add them to your `settings.json`:

```json
{
  "includeDirectories": ["../shared-library", "~/common-utils"]
}
```

### Quick summary of what you tried vs. what works

| What you tried | Status | What to use instead |
| --- | --- | --- |
| `--all-files` / `--allFiles` | ❌ Does not exist | Current directory is auto-included |
| Include other folders | Use `--include-directories` or `@path` | See examples above |

If you were looking for a different behavior (e.g., ignoring `.gitignore` or including hidden files), let me know and I can point you to the right setting.
