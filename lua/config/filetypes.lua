-- Custom filetype detection tweaks
-- Use Neovim's built-in filetype API for robust detection

vim.filetype.add({
  -- Extensions
  extension = {
    mdx = "markdown",
  },

  -- Exact filenames
  filename = {
    ["Dockerfile"] = "dockerfile",
    ["Containerfile"] = "dockerfile",
  },

  -- Patterns (match anywhere in the path)
  pattern = {
    [".*/[Dd]ockerfile%..*"] = "dockerfile",   -- e.g. Dockerfile.dev, dockerfile.prod
    [".*/Containerfile%..*"] = "dockerfile",
  },
})
