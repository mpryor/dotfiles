local set = vim.keymap.set
set("i", "jj", "<ESC>")

-- Window management
set("n", "<Leader>v", "<C-w>v", { desc = "Split window vertically" })
set("n", "<Leader>l", "<C-w>l", { desc = "Move to next window" })
set("n", "<Leader>h", "<C-w>h", { desc = "Move to previous window" })
set("n", "<Leader>j", "<C-w>j", { desc = "Move to window below" })
set("n", "<Leader>k", "<C-w>k", { desc = "Move to window above" })
set("n", "<Leader>q", "<C-w>q", { desc = "Close current window" })
set("n", "<Leader>Q", ":qa!<CR>", { desc = "Close all windows, without saving" })
set("n", "<Leader>o", ":b#<CR>", { desc = "Flip to previous buffer" })
set("n", "<Leader>O", "<C-w>O", { desc = "Focus on current buffer" })
set("n", "<Leader>cd", ":cd %:p:h<CR>", { desc = "Change working directory to current buffer's path" })
set("n", "<Leader>w", ":w!<CR>", { desc = "Save current buffer" })

local zen = require("zen-mode")
set("n", "<C-w>o", function() zen.toggle({window = {width=1}}) end, {desc = "Toggle zen mode"})

-- Telescope bindings
local telescope = require('telescope.builtin')
local telescope_extensions = require('telescope').extensions
set('n', '<Leader>p', telescope_extensions.smart_open.smart_open, { desc = "Telescope find files" })
set('n', '<Leader>b', telescope.buffers, { desc = "Telescope current [b]uffers" })
set('n', '\\', telescope.live_grep, { desc = "Telescope live grep [\\]" })

-- Flash bindings (like easymotion)
local flash = require("flash")
local function jumpline()
    flash.jump({
      jump = { register = false },
      search = { mode = "search", max_length = 0},
      label = { after = { 0, 0 } },
      continue=false,
      pattern = "^"
    })
end
set('n', '<Leader><Leader>', jumpline, { desc = "quickly jump to a line" })
set({'n', 'x', 'o'}, 'S', flash.treesitter, { desc = "Flash treesitter" })

-- LSP bindings
set('n', 'gd', telescope.lsp_definitions, { desc = '[G]oto [d]efinition' })
set('n', 'gr', telescope.lsp_references, { desc = '[G]oto [r]eferences' })
set('n', 'gO', telescope.lsp_document_symbols, { desc = 'Open Document Symbols' })
set('n', 'gW', telescope.lsp_dynamic_workspace_symbols, { desc = 'Open Workspace Symbols' })
set('n', 'gi', telescope.lsp_implementations, { desc = '[G]oto [I]mplementation' })
set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
set('n', 'grn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
set('n', 'gra', vim.lsp.buf.code_action, { desc = '[G]oto Code [A]ction' })
set('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat' })

-- Debugging
local dap = require("dap")
local dapui = require("dapui")

local function start_debug()
  dap.continue()
  dapui.open()
end

local function stop_debug()
  dap.terminate()
  dapui.close()
end

set('n', '<leader>ds', start_debug, { desc = "Start debugging" })
set('n', '<leader>dd', stop_debug, { desc = "Toggle breakpoint" })
set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
set('n', '<F5>', dap.continue, { desc = "Continue" }) -- technically duplicative of <leader>ds
set('n', '<F10>', dap.step_over, { desc = "Step over" })
set('n', '<F11>', dap.step_into, { desc = "Step into" })

-- Uncategorized
set('t', '<ESC>', '<C-\\><C-n>', { desc = 'Leave terminal mode with ESC' })
set('v', 'p', 'pgvy', { desc='Paste without overwriting register'})
set('n', '<Leader>R', ':vsplit | startinsert | term ', { desc='Start a vsplit in terminal mode with the input command'})
