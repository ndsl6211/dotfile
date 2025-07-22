return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        typeCheckingMode = "on",
        diagnosticMode = "openFilesOnly",
        ignore = { "*" },
      }
    }
  }
}
