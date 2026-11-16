import { afterEach, expect, test } from "bun:test"
import { $ } from "bun"
import { mkdtemp, mkdir, readFile, readlink, rm, writeFile } from "node:fs/promises"
import { tmpdir } from "node:os"
import { dirname, join, resolve } from "node:path"
import { fileURLToPath, pathToFileURL } from "node:url"

const root = resolve(dirname(fileURLToPath(import.meta.url)), "../..")
const homes = []

afterEach(async () => {
  await Promise.all(homes.splice(0).map((home) => rm(home, { recursive: true, force: true })))
})

async function createHome() {
  const home = await mkdtemp(join(tmpdir(), "opencode-sound-test-"))
  homes.push(home)
  return home
}

async function install(home, ...args) {
  return $`bash ${join(root, "scripts/install_opencode.sh")} ${args}`.env({
    ...process.env,
    HOME: home,
  }).quiet()
}

test("installer links plugins for both profiles and preserves existing config on rerun", async () => {
  for (const profile of ["work", "personal"]) {
    const home = await createHome()
    const target = join(home, ".config/opencode")
    await install(home, "--settings", profile)
    expect(await readlink(join(target, "plugins"))).toBe(join(root, "opencode/plugins"))
    expect(await readlink(join(target, "opencode.json"))).toBe(join(root, `opencode/opencode-${profile}.json`))
    await install(home)
    expect(await readlink(join(target, "opencode.json"))).toBe(join(root, `opencode/opencode-${profile}.json`))
    expect(await readlink(join(target, "plugins"))).toBe(join(root, "opencode/plugins"))
  }
})

test("installer preserves an existing plugins directory without --replace", async () => {
  const home = await createHome()
  const plugins = join(home, ".config/opencode/plugins")
  await mkdir(plugins, { recursive: true })
  await writeFile(join(plugins, "existing.txt"), "keep")
  await install(home)
  expect(await readFile(join(plugins, "existing.txt"), "utf8")).toBe("keep")
})

test("installed plugin plays all three real macOS sounds and ignores unrelated events", async () => {
  const home = await createHome()
  await install(home)
  const { SoundPlugin } = await import(pathToFileURL(join(home, ".config/opencode/plugins/sound.js")).href)
  const sounds = []
  const logs = []
  const hooks = await SoundPlugin({
    $: (strings, ...values) => {
      sounds.push(...values)
      return $(strings, ...values)
    },
    client: { app: { log: async (entry) => { logs.push(entry) } } },
  })

  await hooks.event({ event: { type: "session.updated" } })
  expect(sounds).toEqual([])
  await hooks["tool.execute.after"]()
  await hooks.event({ event: { type: "permission.asked" } })
  await hooks.event({ event: { type: "session.idle" } })
  expect(sounds).toEqual([
    "/System/Library/Sounds/Funk.aiff",
    "/System/Library/Sounds/Ping.aiff",
    "/System/Library/Sounds/Purr.aiff",
  ])
  expect(logs).toEqual([])
}, 30000)

test("a missing sound file is logged without rejecting the tool hook", async () => {
  const { SoundPlugin } = await import("../../opencode/plugins/sound.js")
  const logs = []
  const hooks = await SoundPlugin({
    $: (strings, ...values) => $(strings, ...values.map((sound) => `${sound}.missing`)),
    client: { app: { log: async (entry) => { logs.push(entry) } } },
  })

  await expect(hooks["tool.execute.after"]()).resolves.toBeUndefined()
  expect(logs).toHaveLength(1)
  expect(logs[0].body.level).toBe("warn")
  expect(logs[0].body.message).toContain("Funk.aiff")
  expect(logs[0].body.extra.exitCode).not.toBe(0)
})
