local remap = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command

require'compe'.setup {
  enabled = true;
  debug = false;
  min_length = 2;
  auto_preselect = false;
  source_timeout = 200;
  incomplete_delay = 400;
  allow_prefix_unmatch = false;
  source = {
    path = true;
    buffer = true;
    vsnip = true;
    nvim_lsp = true;
  };
}

vim.g.lexima_no_default_rules = 1
vim.fn['lexima#set_default_rules']()

-- check prev character, depending on previous char
-- it will do special stuff or just `<CR>`
-- i.e: accept completion item, indent html, autoindent braces/etc, just enter
remap(
  'i', '<CR>',
  table.concat{
  'pumvisible()',
  '? complete_info()["selected"] != "-1"',
  '? compe#confirm(lexima#expand("<LT>CR>", "i"))',
  ': "<C-g>u".lexima#expand("<LT>CR>", "i")',
  ': v:lua.Util.check_html_char() ? lexima#expand("<LT>CR>", "i")."<ESC>O"',
  ': lexima#expand("<LT>CR>", "i")'
  },
  { silent = true, expr = true }
)

-- cycle tab or insert tab depending on prev char
remap(
  'i', '<Tab>',
  'pumvisible() ? "<C-n>" : v:lua.Util.check_backspace() ? "<Tab>" : compe#confirm(lexima#expand("<LT>CR>", "i"))',
  { silent = true, noremap = true, expr = true }
)
remap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, expr = true })
