import { execFile } from "node:child_process"
import { promisify } from "node:util"

const execute = promisify(execFile)

const sounds = (log) => {
  const play = async (sound) => {
    try {
      await execute("afplay", [sound])
    } catch (error) {
      await log({
        service: "sound",
        level: "warn",
        message: `Could not play ${sound}`,
        extra: { error: String(error) },
      })
    }
  }

  return {
    "tool.execute.after": async () => {
      await play("/System/Library/Sounds/Funk.aiff")
    },
    event: async ({ event }) => {
      if (event.type === "permission.asked") {
        await play("/System/Library/Sounds/Ping.aiff")
      } else if (event.type === "session.idle") {
        await play("/System/Library/Sounds/Purr.aiff")
      }
    },
  }
}

export const SoundPlugin = async ({ client }) => sounds((entry) => client.app.log({ body: entry }))

export default {
  id: "sound",
  server: SoundPlugin,
  async setup(ctx) {
    if (typeof ctx.tool?.hook !== "function") return

    const hooks = sounds((entry) => console.warn(entry))
    await ctx.tool.hook("execute.after", hooks["tool.execute.after"])

    const controller = new AbortController()
    const events = ctx.event.subscribe({
      types: ["permission.asked", "session.status"],
      signal: controller.signal,
    })

    void (async () => {
      for await (const event of events) {
        if (event.type === "session.status") {
          if (event.data.status.type === "idle") {
            await hooks.event({ event: { type: "session.idle" } })
          }
        } else {
          await hooks.event({ event })
        }
      }
    })().catch((error) => {
      if (!controller.signal.aborted) console.warn("Sound event subscription failed", error)
    })

    return () => controller.abort()
  },
}
