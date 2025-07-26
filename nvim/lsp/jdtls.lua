return {
  filetypes = { "java", "gradle", "kotlin" },
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "OpenJDK 21",
            path = "/home/mashu/.sdkman/candidates/java/21.0.2-open",
            default = true,
          }
        }
      }
    }
  }
}
