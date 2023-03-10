local ls = require "luasnip"

-- Lazy load snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  -- require("luasnip.loaders.from_snipmate").lazy_load()
  -- require("luasnip.loaders.from_lua").lazy_load { paths = snippets_folder }

  -- vim.cmd [[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]

  -- Load custom typescript snippets
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/typescript/" } }
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/angular/" } }
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/python/" } }
  require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/rust/" } }

  ls.filetype_extend("all", { "_" })
