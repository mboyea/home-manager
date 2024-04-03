vim.opt.clipboard = 'unnamedplus'
-- vim.opt.shiftwidth = 2
-- vim.opt.expandtab = true
-- vim.opt.tabstop = 2
-- vim.opt.softtabstop = 2
-- vim.opt.guicursor = 'i:block'
-- vim.opt.termguicolors = true
-- vim.opt.completeopt = 'menu'
-- vim.opt.cursorline = false
-- vim.opt.nu = true
-- vim.opt.rnu = false
-- vim.opt.list = true
-- vim.opt.listchars = "tab:  ,trail:·,eol: ,nbsp:_"
-- vim.opt.cmdheight = 1

-- vim.keymap.set('n', '<leader>g', function()
--   local filename = string.gsub(vim.fn.expand('%'), os.getenv('PWD') or "", "")
--   local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
--   vim.cmd('! gh browse ' .. filename .. ':' .. row)
-- end, { noremap = true, silent = true })
-- 
-- -- https://github.com/ibhagwan/fzf-lua
-- require('fzf-lua').setup { 'default', winopts = { fullscreen = false, preview = { layout = 'vertical' } } }
-- vim.keymap.set('n', '<leader>-', require('fzf-lua').files, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>[', function() vim.cmd('bn') end, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>]', function() vim.cmd('bp') end, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader><leader>', require('fzf-lua').grep_project, { noremap = true, silent = true })
-- vim.keymap.set('n', '``', require('fzf-lua').grep_cword, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>`', require('fzf-lua').builtin, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>w', require('fzf-lua').grep_cword, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>W', require('fzf-lua').grep_cWORD, { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>=', require('fzf-lua').blines, { noremap = true, silent = true })
-- 
-- -- https://github.com/hrsh7th/cmp-nvim-lsp
-- -- https://github.com/hrsh7th/cmp-buffer
-- -- https://github.com/hrsh7th/nvim-cmp
-- -- https://github.com/hrsh7th/cmp-vsnip
-- -- https://github.com/hrsh7th/vim-vsnip
-- require('cmp').setup({
--   snippet = { expand = function(args) vim.fn["vsnip#anonymous"](args.body) end, },
--   mapping = require('cmp').mapping.preset.insert({
--     ['<C-b>'] = require('cmp').mapping.scroll_docs(-4),
--     ['<C-f>'] = require('cmp').mapping.scroll_docs(4),
--     ['<C-Space>'] = require('cmp').mapping.complete(),
--     ['<C-e>'] = require('cmp').mapping.abort(),
--     ['<CR>'] = require('cmp').mapping.confirm({ select = true }),
--   }),
--   sources = require('cmp').config.sources({ { name = 'nvim_lsp' } })
-- })
-- 
-- -- https://github.com/neovim/nvim-lspconfig
-- vim.diagnostic.config({ virtual_text = true, signs = false, update_in_insert = false })
-- 
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- 
-- local function on_attach(_, bufnr)
--   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--   vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr })
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })
--   vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { noremap = true, silent = true, buffer = bufnr })
--   vim.keymap.set('n', '<leader>p', function() vim.lsp.buf.format { async = true } end,
--     { noremap = true, silent = true, buffer = bufnr })
--   vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references, { noremap = true, silent = true, buffer = bufnr })
--   vim.keymap.set('n', 'ga', require('fzf-lua').lsp_code_actions, { noremap = true, silent = true, buffer = bufnr })
--   vim.keymap.set('n', '<leader>b', require('fzf-lua').lsp_document_diagnostics, { noremap = true, silent = true })
--   vim.keymap.set('n', '<leader>y', require('fzf-lua').lsp_document_symbols, { noremap = true, silent = true })
--   vim.keymap.set('n', '<leader>T', vim.diagnostic.open_float, { noremap = true, silent = true })
-- end
-- 
-- require('lspconfig')['rust_analyzer'].setup({ capabilities = capabilities, on_attach = on_attach })
-- require('lspconfig')['gopls'].setup({ capabilities = capabilities, on_attach = on_attach })
-- 
-- require('lspconfig')['tsserver'].setup({
--   capabilities = capabilities,
--   on_attach = function(client, bufnr)
--     on_attach(client, bufnr)
--     vim.keymap.del('n', '<leader>p', { buffer = bufnr })
-- 
--     vim.keymap.set('n', '<leader>p', function()
--       vim.cmd(':w %')
--       local filename = vim.fn.expand('%')
--       vim.cmd('! npx prettier --write ' .. filename)
--       vim.cmd(':e %')
--     end, { noremap = true, silent = true })
-- 
--     vim.keymap.set('n', '<leader>t', function()
--       local filename = vim.fn.expand('%')
--       local targetfilename = filename:sub(-string.len('test.ts')) == 'test.ts'
--           and string.gsub(filename, ".test.ts$", ".ts")
--           or string.gsub(filename, ".ts$", ".test.ts")
-- 
--       vim.cmd('vsplit ' .. targetfilename)
--     end, { noremap = true, silent = true })
-- 
--     vim.keymap.set('n', '<leader>r', function()
--       local filename = vim.fn.expand('%')
--       local workspace = {}
--       for p in string.gmatch(filename, "([^/]+)") do table.insert(workspace, p) end
-- 
--       local testfilename = filename:sub(-string.len('test.ts')) == 'test.ts'
--           and filename
--           or string.gsub(filename, ".ts$", ".test.ts")
-- 
--       vim.cmd('! tmux split-window pnpm --filter ' .. workspace[2] .. ' test -- --watch ' .. testfilename)
--       vim.cmd('! tmux select-pane -l')
--       vim.cmd('! tmux send-keys Enter')
--     end, { noremap = true, silent = true })
--   end
-- })
-- 
-- require('lspconfig')['lua_ls'].setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     Lua = {
--       telemetry = { enable = false, },
--       runtime = { version = 'LuaJIT', },
--       diagnostics = { globals = { 'vim', 'ngx', 'describe', 'it' }, },
--       workspace = { checkThirdParty = false }
--     }
--   }
-- })
-- 
-- -- https://github.com/terrortylor/nvim-comment
-- require('nvim_comment').setup()
-- 
-- -- https://github.com/catppuccin/nvim catppuccin
-- 
-- -- https://github.com/balazs4/zeitgeist
-- vim.cmd("colorscheme zeitgeist")
-- 
-- -- https://github.com/navarasu/onedark.nvim
-- 
-- -- https://github.com/nvim-treesitter/nvim-treesitter
-- require('nvim-treesitter').setup()


--[[
-- Lazy.nvim {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
-- }}}

-- Options {{{
vim.opt.background = "dark"
vim.opt.backup = false
vim.opt.bufhidden = "wipe"
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "120"
vim.opt.completeopt = "menu,menuone,preview,noselect,noinsert"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars = { eob = " " }
vim.opt.foldenable = true
vim.opt.formatoptions:remove("t")
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = { tab = "**", trail = "·" }
vim.opt.modelines = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.runtimepath:append("/opt/homebrew/opt/fzf")
vim.opt.runtimepath:prepend(lazypath)
vim.opt.shiftwidth = 2
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.swapfile = false
vim.opt.switchbuf:remove("split")
vim.opt.tabstop = 2
vim.opt.termencoding = "utf8"
vim.opt.termguicolors = true
vim.opt.textwidth = 120
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"
vim.opt.undofile = true
vim.opt.updatetime = 1000
vim.opt.wrap = false

vim.g.mapleader = ","

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.editorconfig_enable = false

local disabled_builtin_plugins = { "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "tutor" }
for _, plugin in pairs(disabled_builtin_plugins) do
   vim.g["loaded_" .. plugin] = 1
end
-- }}}

-- Plugins {{{
require("lazy").setup({
  -- gruvbox.nvim {{{
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = false,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false
        },
        strikethrough = true
      })
      vim.cmd.colorscheme("gruvbox")
    end
  },
  -- }}}
  -- nvim-treesitter {{{
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = { "ruby", "dockerfile", "fish", "json", "yaml", "html", "javascript", "scss", "rust",
                           "terraform", "toml", "lua", "pascal", "go" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" }
      },
      indent = {
        enable = true,
        disable = { "ruby" } -- Treesitter indentation is broken for Ruby so we use vim-ruby instead
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<space>",
          node_incremental = "<space>",
          node_decremental = "<bs>",
          scope_incremental = false
        }
      }
    }
  },
  -- }}}
  -- telescope-fzf-native {{{
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    commit = "580b6c48651cabb63455e97d7e131ed557b8c7e2",
    build = "make" -- this command may fail on M1, in this case run "make clean && make" manually from the plugin's dir
  },
  -- }}}
  -- telescope {{{
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
                     "nvim-telescope/telescope-fzf-native.nvim", "nvim-telescope/telescope-ui-select.nvim",
                     "debugloop/telescope-undo.nvim" },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "^.git/", ".lock", ".keep", ".enc", "db/schema.rb" }
        },
        pickers = {
          find_files = { hidden = true }
        },
        extensions = {
          undo = {
            mappings = {
              n = {
                ["<CR>"] = require("telescope-undo.actions").restore,
              },
            },
          },
        }
      })
      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
      telescope.load_extension("undo")
    end
  },
  -- }}}
  -- nvim-cmp {{{
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = { autocomplete = false },
        sources = {
          { name = "nvim_lsp" }
        },
        mapping = {
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
        }
      })
    end
  },
  -- }}}
  -- nvim-lspconfig {{{
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local nvim_lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      nvim_lsp.solargraph.setup({
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 }
      })
      nvim_lsp.stylelint_lsp.setup({
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 },
        settings = {
          stylelintplus = { autoFixOnFormat = true }
        }
      })
      nvim_lsp.rust_analyzer.setup({
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 },
        settings = {
          ["rust-analyzer"] = {
            diagnostics = { enable = true },
            imports = {
              granularity = { group = "module" },
              prefix = "self",
            },
            cargo = {
              buildScripts = { enable = true }
            },
            procMacro = { enable = true }
          }
        }
      })
      -- efm-langserver must be installed: brew install efm-langserver
      nvim_lsp.efm.setup({
        capabilities = capabilities,
        init_options = { documentFormatting = true, formatting = true },
        filetypes = { "pascal" },
        settings = {
          rootMarkers = { ".git/" },
          languages = {
            pascal = {
              -- the dumbest way to format Pascal code
              { formatCommand = "ptop ${FILENAME} ptop.tmp; cat ptop.tmp; rm ptop.tmp", formatStdin = false }
            }
          }
        }
      })
      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          virtual_text = false,
          signs = true,
          update_in_insert = false
        }
      )
    end
  },
  -- }}}
  -- bufferline {{{
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "none",
        close_command = "bdelete! %d",
        indicator = { style = "none" },
        max_name_length = 20,
        max_prefix_length = 15,
        tab_size = 20,
        diagnostics = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = function()
              return vim.fn.getcwd()
            end,
            text_align = "left"
          }
        },
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        separator_style = { "", "" },
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = "id"
      },
      highlights = {
        fill = { bg = "#282828" },
        background = { bg = "#282828" },
        buffer_selected = { bg = "#3c3836" }
      }
    }
  },
  -- }}}
  -- nvim-tree {{{
  {
    "kyazdani42/nvim-tree.lua",
    opts = {
      open_on_tab = true,
      git = { enable = true },
      renderer = {
        root_folder_label = false,
        special_files = { "README.md", "Gemfile" },
        icons = {
          git_placement = "signcolumn",
          show = {
            file = false,
            folder = false,
            folder_arrow = false,
            git = false
          }
        }
      },
      filters = {
        custom = { "^.git$" }
      },
      actions = {
        change_dir = { enable = false },
      },
      view = {
        signcolumn = "no",
        width = 40
      }
    }
  },
  -- }}}
  -- lualine {{{
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-tree.lua" },
    config = function()
      local custom_gruvbox = require("lualine.themes.gruvbox")
      custom_gruvbox.normal.c.bg = "#3c3836"
      custom_gruvbox.normal.c.fg = "#928374"
      custom_gruvbox.insert.c.bg = "#3c3836"
      custom_gruvbox.insert.c.fg = "#928374"
      custom_gruvbox.visual.c.bg = "#3c3836"
      custom_gruvbox.visual.c.fg = "#928374"
      custom_gruvbox.replace.c.bg = "#3c3836"
      custom_gruvbox.replace.c.fg = "#928374"
      custom_gruvbox.command.c.bg = "#3c3836"
      custom_gruvbox.command.c.fg = "#928374"

      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = custom_gruvbox,
          component_separators = "",
          section_separators = "",
          always_divide_middle = true,
          globalstatus = true
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "filetype" },
          lualine_c = {
            {
              "filename",
              path = 1
            }
          },
          lualine_x = { "branch" },
          lualine_y = { "location" },
          lualine_z = {
            {
              "diagnostics",
              sections = { "error", "warn", "info" },
              colored = false,
              always_visible = true,
              symbols = { error = "", warn = "/", info = "/" },
              fmt = function(str)
                return str:gsub("%s+", "")
              end
            }
          }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {}
        },
        extensions = { "nvim-tree" }
      })
    end
  },
  -- }}}
  -- gitsigns {{{
  {
    "lewis6991/gitsigns.nvim",
    config = true
  },
  -- }}}
  -- vim-fugitive {{{
  {
    "tpope/vim-fugitive"
  },
  -- }}}
  -- vim-sayonara {{{
  {
    "mhinz/vim-sayonara"
  },
  -- }}}
  -- auto-save {{{
  {
    "pocco81/auto-save.nvim",
    branch = "dev",
    commit = "9aceacfd184c34a2d878492a67bbd6b909b9480c",
    opts = {
      execution_message = { message = "" },
      trigger_events = { "InsertLeave", "TextChanged" }
    }
  },
  -- }}}
  -- nvim-comment {{{
  {
    "terrortylor/nvim-comment",
    main = "nvim_comment",
    opts = {
      marker_padding = true,
      create_mappings = false
    }
  },
  -- }}}
  -- copilot {{{
  {
    "github/copilot.vim",
    config = function()
      -- Apparently there is a bug somewhere (Copilot?) that adds extra characters when using <C-J>
      -- This is why I have to rely on the default mapping for now (<Tab>), which may conflict with other plugins
      -- Also to prevent Copilot from reporing errors at :Copilot status, I have to set copilot_assume_mapped = true
      -- Also copilot_no_tab_map doesn't seem to work :/
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      -- vim.keymap.set("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end
  },
  -- }}}
  -- nvim-lastplace {{{
  {
    "ethanholz/nvim-lastplace",
    config = true
  },
  -- }}}
  -- vim-ruby {{{
  {
    "vim-ruby/vim-ruby",
    config = function()
      vim.g.ruby_indent_assignment_style = "variable"
    end
  },
  -- }}}
  -- vim-test {{{
  {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },
    config = function()
      vim.g["test#strategy"] = "vimux"
      vim.g.VimuxOrientation = "h"
      vim.g.VimuxHeight = "40"
    end
  },
  -- }}}
  -- vim-rails {{{
  {
    "tpope/vim-rails",
    dependencies = { "vim-ruby/vim-ruby" },
    config = function()
      vim.g.rails_projections = {
        ["app/lib/*.rb"] = {
          test = "spec/lib/{}_spec.rb",
        }
      }
    end
  },
  -- }}}
  -- nvim-osc52 {{{
  {
    "ojroques/nvim-osc52"
  },
  -- }}}
  -- NeoTest {{{
  {
  "nvim-neotest/neotest",
    dependencies = { "olimorris/neotest-rspec" },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec")
        }
      })
    end
  }
  -- }}}
})
-- }}}

-- Keymaps {{{
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true, desc = "Toggle NvimTree" })
vim.keymap.set("n", "//", ":nohlsearch<CR>", { silent = true, desc = "Clear selection highlight" })
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Go to next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Go to previous buffer" })
vim.keymap.set("n", "<C-w>", ":Sayonara!<CR>", { silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "J", "<PageDown>", { silent = true, desc = "Next page" })
vim.keymap.set("n", "K", "<PageUp>", { silent = true, desc = "Previous page" })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true, desc = "Navigate left" })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, desc = "Navigate down" })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true, desc = "Navigate up" })
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, desc = "Navigate right" })
vim.keymap.set("n", "<C-o>", ":Telescope find_files<CR>", { silent = true, desc = "Find file" })
vim.keymap.set("n", "<C-g>", ":Telescope live_grep<CR>", { silent = true, desc = "Search text in all files" })
vim.keymap.set("n", "<C-f>", ":Telescope lsp_document_symbols<CR>", { silent = true, desc = "List LSP symbols from current file" })
vim.keymap.set("n", "<C-t>", ":Telescope lsp_workspace_symbols<CR>", { silent = true, desc = "List LSP symbols from all files" })
vim.keymap.set("n", "<C-u>", ":Telescope undo<CR>", { silent = true, desc = "Show undo tree" })
vim.keymap.set({ "n", "v" }, "<Leader>c", ":CommentToggle<CR>", { silent = true, desc = "Toggle line comment" })
vim.keymap.set("n", "<C-s>", function() vim.lsp.buf.format({ async = true }) end, { silent = true, desc = "Format code" })
vim.keymap.set("n", "<C-]>", function() vim.lsp.buf.definition() end, { silent = true, desc = "Go to definition" })
vim.keymap.set("n", "<Leader>g", ":0G<CR>", { silent = true, desc = "Show Git window" })
vim.keymap.set("n", "<Leader>tn", function() require("neotest").run.run() end, { silent = true, desc = "Run nearest test" })
vim.keymap.set("n", "<Leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, { silent = true, desc = "Run test file" })
-- }}}

-- Abbreivations {{{
vim.cmd("inoreabbrev bi binding.irb")
vim.cmd("inoreabbrev bp binding.pry")
-- }}}

-- Autocmd {{{
vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable spell checking for certain file types",
  pattern = { "text", "markdown", "mail", "gitcommit", "cucumber" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end
})

vim.api.nvim_create_autocmd("CursorHold", {
  desc = "Show LSP diagnostics window on cursor hold",
  pattern = "",
  callback = function()
    vim.diagnostic.open_float(0, { scope = "cursor", focus = false })
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Copy to clipboard/tmux/OSC52",
  pattern = "",
  callback = function()
    if vim.v.event.operator == "y" and vim.v.event.regname == "" then
      require("osc52").copy_register(vim.v.event.regname)
    end
    vim.highlight.on_yank({ timeout = 250 })
  end
})
-- }}}

-- Functions {{{
vim.cmd("command! FormatXML :%!python3 -c 'import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())'")
-- }}}

-- vim:foldmethod=marker:foldlevel=0
--]]

