vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Fira Code Retina"
vim.g.neovide_transparency = 0.6

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function ()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

ChangeTransparency = function(delta)
  vim.g.neovide_transparency = vim.g.neovide_transparency + delta
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps

local opts = { noremap = true, silent = true }

vim.keymap.set({'n', 'i'}, "<C-+>", function() ResizeGuiFont(1)  end, opts)
vim.keymap.set({'n', 'i'}, "<C-->", function() ResizeGuiFont(-1) end, opts)

vim.keymap.set({'n', 'i'}, "<C-*>", function() ChangeTransparency(0.1) end, opts)
vim.keymap.set({'n', 'i'}, "<C-/>", function() ChangeTransparency(-0.1) end, opts)
