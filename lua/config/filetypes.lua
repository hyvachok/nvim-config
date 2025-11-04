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
    -- Helm templates: only match files in templates/ directory to avoid false positives
    -- .tpl extension is used by many template systems, so we scope it to Helm's templates/ directory
    [".*/templates/.*%.yaml"] = "helm",         -- Helm templates/*.yaml
    [".*/templates/.*%.yml"] = "helm",          -- Helm templates/*.yml
    [".*/templates/.*%.tpl"] = "helm",         -- Helm templates/*.tpl
  },
})

