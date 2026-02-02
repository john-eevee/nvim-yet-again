-- Java LSP Configuration (JDTLS)
-- Eclipse JDT Language Server for Java development

return {
  settings = {
    java = {
      project = {
        referencedLibraries = {
          '$JAVA_HOME/lib/**/*.jar',
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementation = {
        searchAllProjectsScope = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
      contentProvider = 'fernflower',
      autobuild = {
        enabled = true,
      },
      saveActions = {
        organizeImports = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = '${object}.toString()',
        },
        hashCodeEquals = {
          useInstanceof = true,
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = os.getenv('JAVA_HOME') or '/usr/lib/jvm/java-11',
            default = true,
          },
          {
            name = 'JavaSE-17',
            path = os.getenv('JAVA_HOME_17') or '/usr/lib/jvm/java-17',
          },
        },
      },
      format = {
        enabled = true,
        settings = {
          url = os.getenv('JAVA_FORMAT_SETTINGS_URL'),
          profile = os.getenv('JAVA_FORMAT_SETTINGS_PROFILE'),
        },
      },
    },
  },
}
