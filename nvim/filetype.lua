vim.filetype.add({
  pattern = {
    [".*%.asl%.json"] = "asl",
  },
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
    ["Caddyfile"] = "caddy",
  },
})

vim.treesitter.language.register("json", "asl")
vim.treesitter.language.register("lua", "p8")
