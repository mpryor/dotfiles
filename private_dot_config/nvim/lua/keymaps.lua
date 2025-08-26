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
set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }) -- Vinegar-like movement using Oil

-- Terminal keymaps
set('t', '<C-h>', [[<Cmd>wincmd h<CR>]])
set('t', '<C-j>', [[<Cmd>wincmd j<CR>]])
set('t', '<C-k>', [[<Cmd>wincmd k<CR>]])
set('t', '<C-l>', [[<Cmd>wincmd l<CR>]])

-- Tab management
set("n", "<Leader>tc", ":tabclose<CR>", { desc = "Close current tab" })   -- Mainly useful for git difftool
set("n", "<Leader>to", ":tabonly<CR>", { desc = "Close all other tabs" }) -- Mainly useful for git difftool
set("n", "]t", ":tabnext<CR>", { desc = "Go to next tab" })               -- I don't see ctags in my future
set("n", "[t", ":tabprev<CR>", { desc = "Go to previous tab" })           -- I don't see ctags in my future

local zen = require("zen-mode")
set("n", "<C-w>o", function() zen.toggle({ window = { width = 1 } }) end, { desc = "Toggle zen mode" })

-- Telescope bindings
local telescope = require('telescope.builtin')
local telescope_extensions = require('telescope').extensions
local session_picker = require('auto-session.pickers.telescope')
set('n', '<Leader>p', telescope.find_files, { desc = "Telescope find files" })
set('n', '<Leader>P', telescope_extensions.smart_open.smart_open, { desc = "Telescope smart open" })
set('n', '<Leader>b', telescope.buffers, { desc = "Telescope current [b]uffers" })
set('n', '<Leader>fd', telescope.diagnostics, { desc = "Telescope find diagnostics" })
set('n', '<Leader>fc', telescope.commands, { desc = "Telescope find commands" })
set('n', '<Leader>fh', telescope.help_tags, { desc = "Telescope find help" })
set('n', '<Leader>fk', telescope.keymaps, { desc = "Telescope find keymaps" })
set('n', '<Leader>ff', telescope.builtin, { desc = "Telescope pickers" })
set('n', '<Leader>fs', session_picker.open_session_picker, { desc = "Telescope find sessions" })
set('n', '\\', telescope.live_grep, { desc = "Telescope live grep [\\]" })

-- Flash bindings (like easymotion)
local flash = require("flash")

---@param opts Flash.Format
local function format(opts)
  -- always show first and second label
  return {
    { opts.match.label1, "FlashMatch" },
    { opts.match.label2, "FlashLabel" },
  }
end

function Jump2d()
  flash.jump({
    search = { mode = "search" },
    label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
    pattern = [[\<]],
    action = function(match, state)
      state:hide()
      flash.jump({
        search = { max_length = 0 },
        highlight = { matches = false },
        label = { format = format },
        matcher = function(win)
          -- limit matches to the current label
          return vim.tbl_filter(function(m)
            return m.label == match.label and m.win == win
          end, state.results)
        end,
        labeler = function(matches)
          for _, m in ipairs(matches) do
            m.label = m.label2 -- use the second label
          end
        end,
      })
    end,
    labeler = function(matches, state)
      local labels = state:labels()
      for m, match in ipairs(matches) do
        match.label1 = labels[math.floor((m - 1) / #labels) + 1]
        match.label2 = labels[(m - 1) % #labels + 1]
        match.label = match.label1
      end
    end,
  })
end

set('n', '<Leader><Leader>', Jump2d, { desc = "quickly jump anywhere" })
set({ 'n', 'x', 'o' }, 'S', flash.treesitter, { desc = "Flash treesitter" })
set({ 'n', 'x', 'o' }, 's', function ()
  flash.jump({labels="abcdefghijklmnopqrstuvwyxz"})
end, { desc = "Flash jump" })

-- LSP bindings
set('n', 'gd', telescope.lsp_definitions, { desc = '[G]oto [d]efinition' })
set('n', 'gr', telescope.lsp_references, { desc = '[G]oto [r]eferences', nowait = true })
set('n', 'gO', telescope.lsp_document_symbols, { desc = 'Open Document Symbols' })
set('n', 'gW', telescope.lsp_dynamic_workspace_symbols, { desc = 'Open Workspace Symbols' })
set('n', 'gi', telescope.lsp_implementations, { desc = '[G]oto [I]mplementation' })
set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
set('n', '<Leader>rn', vim.lsp.buf.rename, { desc = '[r]e[n]ame' })
set('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' })
set('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat' })

-- Debugging
local dap = require("dap")
local dapui = require("dapui")

local function start_debug()
  dap.continue()
  dapui.open()
end

local function stop_debug()
  dapui.close()
  dap.terminate()
end

set('n', '<leader>ds', start_debug, { desc = "Start debugging" })
set('n', '<leader>dd', stop_debug, { desc = "Toggle breakpoint" })
set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
set('n', '<F5>', dap.continue, { desc = "Continue" }) -- technically duplicative of <leader>ds
set('n', '<F10>', dap.step_over, { desc = "Step over" })
set('n', '<F11>', dap.step_into, { desc = "Step into" })

-- Git
set("n", "<Leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
set("n", "<Leader>gd", ":Git difftool -y<CR>", { desc = "[G]it [D]ifftool" })
set("n", "<Leader>gD", ":Git difftool -y HEAD<CR>", { desc = "[G]it [D]ifftool" })
set("n", "<Leader>ga.", ":Git add .<CR>", { desc = "[G]it [a]dd [.]" })
set("n", "<Leader>gaa", ":Git add %<CR>", { desc = "[G]it [a]dd current file" })
set("n", "<Leader>gc", ":Git commit -v<CR>", { desc = "[G]it [c]ommit" })
set("n", "<Leader>gp", ":Git push origin<CR>", { desc = "[G]it [p]ush" })
set("n", "<Leader>gb", ":Gitsigns blame<CR>", { desc = "[G]it [b]lame" })
set("n", "ga", ":Gitsigns stage_hunk<CR>", { desc = "[G]it [add] hunk" })
set("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "Next hunk" })
set("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "Previous hunk" })

-- Move stuff around
set("n", "<A-up>", ":m -2<CR>==")
set("n", "<A-down>", ":m +1<CR>==")
set("v", "<A-up>", ":m -2<CR>gv")
set("v", "<A-down>", ":m '>+1<CR>gv")
set("v", ">", ">gv")
set("v", "<", "<gv")
set("v", "<A-right>", ">gv")
set("n", "<A-right>", ">>")
set("v", "<A-left>", "<gv")
set("n", "<A-left>", "<<")

-- Yanky
vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- Uncategorized
set('t', '<ESC>', '<C-\\><C-n>', { desc = 'Leave terminal mode with ESC' })
set('v', 'p', 'pgvy', { desc = 'Paste without overwriting register' })
set('n', '<Leader>R', ':vsplit | startinsert | term ',
  { desc = 'Start a vsplit in terminal mode with the input command' })
set("n", "J", "mzJ`z")
set('n', '<C-d>', '<C-d>zz', { desc = 'Page down, stay centered' })
set('n', '<C-u>', '<C-u>zz', { desc = 'Page up, stay centered' })
set("n", "N", "Nzzzv", { desc = "Keep (prev) search result centered" })
set("n", "n", "nzzzv", { desc = "Keep (next) search result centered" })
