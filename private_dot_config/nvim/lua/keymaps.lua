local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

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
set("n", "<Leader>-", function ()
  require("oil").open(nil, {preview = {vertical=true}})
end, { desc = "Open parent directory" }) -- Vinegar-like movement using Oil
local zen = require("zen-mode")
set("n", "<C-w>o", function() zen.toggle({ window = { width = 1 } }) end, { desc = "Toggle zen mode" })
set("n", "<Leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle CopilotChat" })
set("n", "<Leader>a", ":AerialNavToggle<CR>", { desc = "Toggle Code Outlines" })

-- Terminal keymaps
set({ 'n', 't' }, '<C-h>', [[<Cmd>wincmd h<CR>]])
set({ 'n', 't' }, '<C-j>', [[<Cmd>wincmd j<CR>]])
set({ 'n', 't' }, '<C-k>', [[<Cmd>wincmd k<CR>]])
set({ 'n', 't' }, '<C-l>', [[<Cmd>wincmd l<CR>]])
set('t', '<ESC><ESC>', '<C-\\><C-n>', { desc = 'Leave terminal mode with ESC' })

-- Tab management
set("n", "<Leader>tc", ":tabclose<CR>", { desc = "Close current tab" })   -- Mainly useful for git difftool
set("n", "<Leader>to", ":tabonly<CR>", { desc = "Close all other tabs" }) -- Mainly useful for git difftool
set("n", "]t", ":tabnext<CR>", { desc = "Go to next tab" })               -- I don't see ctags in my future
set("n", "[t", ":tabprev<CR>", { desc = "Go to previous tab" })           -- I don't see ctags in my future

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

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local actions_list = {
  {
    label = "Python: run current file",
    fn = function() vim.cmd("TermExec cmd='python %'") end
  },
  {
    label = "Poetry: run current file",
    fn = function() vim.cmd("TermExec cmd='poetry run python %'") end
  },
  {
    label = "Poetry: run CMD",
    fn = function()
      local termcode = vim.api.nvim_replace_termcodes("<Left>", true, false, true)
      vim.api.nvim_feedkeys(":TermExec cmd='poetry run '", "n", true)
      vim.api.nvim_feedkeys(termcode, "n", true)
    end
  },
}

local executor = function(opts)
  opts = opts or {}
  local action_map = {}
  local results = {}
  for _, act in ipairs(actions_list) do
    action_map[act.label] = act.fn
    table.insert(results, act.label)
  end
  pickers.new(opts, {
    prompt_title = "Execute",
    finder = finders.new_table { results = results },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection and action_map[selection[1]] then
          action_map[selection[1]]()
        else
          local cmd = action_state.get_current_line()
          vim.cmd("TermExec cmd='" .. cmd .. "'")
        end
      end)
      return true
    end,
  }):find()
end

set("n", "<Leader>R", function()
  executor(require("telescope.themes").get_dropdown {})
end, { desc = "Execute command" })

-- Flash bindings (like easymotion)
local flash = require("flash")
set({ 'n', 'x', 'o' }, 'S', flash.treesitter, { desc = "Flash treesitter" })
set({ 'n', 'x', 'o' }, 's', flash.jump, { desc = "Flash jump" })
set({ 'o' }, 'r', flash.remote, { desc = "Flash jump" })

-- LSP bindings
set('n', 'gd', telescope.lsp_definitions, { desc = '[G]oto [d]efinition' })
set('n', 'gr', telescope.lsp_references, { desc = '[G]oto [r]eferences', nowait = true })
set('n', 'gO', telescope.lsp_document_symbols, { desc = 'Open Document Symbols' })
set('n', 'gW', telescope.lsp_dynamic_workspace_symbols, { desc = 'Open Workspace Symbols' })
set('n', 'gi', telescope.lsp_implementations, { desc = '[G]oto [I]mplementation' })
set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })
set('n', 'gt', vim.lsp.buf.type_definition, { desc = '[G]oto [T]ype' })
set('n', '<Leader>rn', vim.lsp.buf.rename, { desc = '[r]e[n]ame' })
set('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = '[c]ode [a]ction' })
set('n', '<leader>f', vim.lsp.buf.format, { desc = '[F]ormat' })

-- Debugging
local dap = require("dap")
local dapui = require("dapui")

local function start_debug()
  dap.continue()
  dapui.open({reset = true})
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
set('n', '<F23>', dap.step_out, { desc = "Step out" }) -- Shift + F11

-- Git
set("n", "<Leader>gs", ":Git<CR>", { desc = "[G]it [S]tatus" })
set("n", "<Leader>gd", ":Git difftool -y<CR>", { desc = "[G]it [D]ifftool" })      -- for staging area
set("n", "<Leader>gD", ":Git difftool -y HEAD<CR>", { desc = "[G]it [D]ifftool" }) -- for last commit
set("n", "<Leader>ga.", ":Git add .<CR>", { desc = "[G]it [a]dd [.]" })
set("n", "<Leader>gaa", ":Git add %<CR>", { desc = "[G]it [a]dd current file" })
set("n", "<Leader>gc", ":Git commit -v<CR>", { desc = "[G]it [c]ommit" })
set("n", "<Leader>gp", ":Git push origin<CR>", { desc = "[G]it [p]ush" })
set("n", "<Leader>gb", ":Gitsigns blame<CR>", { desc = "[G]it [b]lame" })
set("n", "ga", ":Gitsigns stage_hunk<CR>", { desc = "[G]it [add] hunk" })
local gitsigns = require("gitsigns")

local function nav_hunk_preview(forward)
  if forward then
    direction = "next"
  else
    direction = "prev"
  end
  -- Use gitsigns navigation with preview
  gitsigns.nav_hunk(direction, { preview = true, target = 'all' })
end

next_hunk, prev_hunk = ts_repeat_move.make_repeatable_move_pair(
  function() nav_hunk_preview(true) end,
  function() nav_hunk_preview(false) end
)

set("n", "]h", next_hunk, { desc = "Next hunk" })
set("n", "[h", prev_hunk, { desc = "Previous hunk" })

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
vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

-- Uncategorized
set('x', 'p', 'pgvy', { desc = 'Paste without overwriting register' })
set("n", "J", "mzJ`z")
set('n', '<C-d>', '<C-d>zz:set hlsearch<CR>', { desc = 'Page down, stay centered' })
set('n', '<C-u>', '<C-u>zz:set hlsearch<CR>', { desc = 'Page up, stay centered' })
set("n", "N", "Nzzzv:set hlsearch<CR>", { desc = "Keep (prev) search result centered" })
set("n", "n", "nzzzv:set hlsearch<CR>", { desc = "Keep (next) search result centered" })

-- Text objects
-- Repeat movement with ; and ,
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
-- Set up default f, F, t, T to be repeatable
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

vim.keymap.set('', '[-', '<Plug>(IndentWisePreviousLesserIndent)', {})
vim.keymap.set('', '[=', '<Plug>(IndentWisePreviousEqualIndent)', {})
vim.keymap.set('', '[+', '<Plug>(IndentWisePreviousGreaterIndent)', {})
vim.keymap.set('', ']-', '<Plug>(IndentWiseNextLesserIndent)', {})
vim.keymap.set('', ']=', '<Plug>(IndentWiseNextEqualIndent)', {})
vim.keymap.set('', ']+', '<Plug>(IndentWiseNextGreaterIndent)', {})
vim.keymap.set('', '[%', '<Plug>(IndentWiseBlockScopeBoundaryBegin)', {})
vim.keymap.set('', ']%', '<Plug>(IndentWiseBlockScopeBoundaryEnd)', {})

-- Diagnostic pairs
set('n', ']e', function()
  vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR, wrap = true })
end, {})
set('n', '[e', function()
  vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR, wrap = true })
end, {})

-- Chunk pairs, complements `ic` textobjects from hlchunk
local chunk_helper = require("hlchunk.utils.chunkHelper")

function get_current_chunk_range()
  local pos = vim.api.nvim_win_get_cursor(0)
  local retcode, cur_chunk_range = chunk_helper.get_chunk_range({
    pos = { bufnr = 0, row = pos[1] - 1, col = pos[2] },
    use_treesitter = true,
  })
  return cur_chunk_range
end

function prev_chunk()
  vim.api.nvim_win_set_cursor(0, { get_current_chunk_range().start + 1, 0 })
end

function next_chunk()
  vim.api.nvim_win_set_cursor(0, { get_current_chunk_range().finish + 1, 0 })
end

set({ 'n', 'o' }, '[c', prev_chunk, {})
set({ 'n', 'o' }, ']c', next_chunk, {})
