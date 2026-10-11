// Tests for .opencode/plugins/guards.js. Run: node --test tests/
import { test } from "node:test"
import assert from "node:assert/strict"
import path from "node:path"
import { fileURLToPath } from "node:url"
import GuardsPlugin from "../.opencode/plugins/guards.js"

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..")
const hooks = await GuardsPlugin({ directory: root })
const before = hooks["tool.execute.before"]
const call = (tool, args) => before({ tool }, { args })

test("reading .env is blocked", async () => {
  await assert.rejects(call("read", { filePath: `${root}/.env` }), /\.env holds real secrets/)
  await assert.rejects(call("read", { filePath: "config/.env.local" }), /\.env holds real secrets/)
})

test("reading .env.example and normal files is allowed", async () => {
  await call("read", { filePath: `${root}/.env.example` })
  await call("read", { filePath: `${root}/AGENTS.md` })
})

test("a test command piped into tail is blocked", async () => {
  await assert.rejects(call("bash", { command: "npm test 2>&1 | tail -5" }), /pipes it into tail\/head/)
  await assert.rejects(call("bash", { command: "scripts/check | head" }), /pipes it into tail\/head/)
})

test("normal commands are allowed", async () => {
  await call("bash", { command: "scripts/check" })
  await call("bash", { command: "git log --oneline | head -5" })
  await call("bash", { command: "npm test | tail -5; echo EXIT=${PIPESTATUS[0]}" })
})
