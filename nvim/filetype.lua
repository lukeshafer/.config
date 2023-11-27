vim.filetype.add({
  extension = {
    astro = "astro",
    postcss = "css",
    mdx = "mdx",
    webc = "html",
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
