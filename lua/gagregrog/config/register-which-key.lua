local wk = require("which-key")

wk.register({
  n = { name = "Navigate" },
  s = { name = "Split" },
  w = { name = "Workspace" },
  f = { name = "Fuzzy Find" },
  t = { name = "Tab" },
  e = { name = "Explorer" },
  g = { name = "Git" },
}, { prefix = "<leader>" })
