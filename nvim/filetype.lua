vim.filetype.add({
  extension = {
    astro = "astro",
    postcss = "css",
    mdx = "mdx",
    webc = "html",
    soql = "soql",
    p8 = "p8",
  },
  filename = {
    ["JenkinsFile"] = "groovy",
    ["Jenkinsfile"] = "groovy",
    ["APIJenkinsFile"] = "groovy",
    ["APIJenkinsfile"] = "groovy",
    ["tsconfig.json"] = "jsonc",
    ["jsconfig.json"] = "jsonc",
  },
})
