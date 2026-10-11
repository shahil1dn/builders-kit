// guards.js — OpenCode's version of the kit's guards.
//
// Blocks two things before a tool runs:
//   1. reading a real .env file (placeholders in .env.example are fine)
//   2. a test or check command piped into tail/head, which hides whether it passed
//
// The second rule is NOT re-written here: it calls the same .agents/hooks/masked-verdict.sh that
// Claude Code and Codex use, so there is one copy of the rule to keep right.
//
// OpenCode can't stop the agent from ending a reply, so the kit's "proof check" has no OpenCode
// version; AGENTS.md and the pull request template carry that rule instead.
import { spawnSync } from "node:child_process"
import path from "node:path"

const isRealEnvFile = (file) => {
  const name = path.basename(String(file || ""))
  return /^\.env($|\.)/.test(name) && !name.endsWith(".example")
}

const maskedVerdictReason = (hooksDir, command) => {
  const run = spawnSync("bash", [path.join(hooksDir, "masked-verdict.sh")], {
    input: JSON.stringify({ tool_name: "bash", tool_input: { command } }),
    encoding: "utf8",
  })
  if (run.status !== 0 || !run.stdout) return null // fail open, like the hook itself
  try {
    const out = JSON.parse(run.stdout).hookSpecificOutput
    return out && out.permissionDecision === "deny" ? out.permissionDecisionReason : null
  } catch {
    return null
  }
}

const GuardsPlugin = async ({ directory }) => {
  const hooksDir = path.join(directory, ".agents", "hooks")
  return {
    "tool.execute.before": async (input, output) => {
      const args = (output && output.args) || {}
      if (input.tool === "read" && isRealEnvFile(args.filePath)) {
        throw new Error("Blocked: .env holds real secrets. Use .env.example for the variable names.")
      }
      if (input.tool === "bash" && args.command) {
        const reason = maskedVerdictReason(hooksDir, args.command)
        if (reason) throw new Error(`Blocked: ${reason}`)
      }
    },
  }
}

export default GuardsPlugin
