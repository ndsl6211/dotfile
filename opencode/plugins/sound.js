export const SoundPlugin = async ({ $, client }) => {
  const play = async (sound) => {
    const result = await $`afplay ${sound}`.quiet().nothrow()
    if (result.exitCode !== 0) {
      await client.app.log({
        body: {
          service: "sound",
          level: "warn",
          message: `Could not play ${sound}`,
          extra: { exitCode: result.exitCode, stderr: result.stderr.toString() },
        },
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
