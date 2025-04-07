require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Telescope
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep <cr>", { desc = "Telescope Find files" })
map("n", "<C-o>", "o <Esc>", { desc = "NewLine" })

-- Comments
map("n", "<C-_>", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment line" })

map(
  "v",
  "<C-_>",
  "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
  { desc = "Comment line in Visual Mode" }
)

-- Python helpers
map("n", "<C-b>", function()
  vim.api.nvim_put({ "import pdb; pdb.set_trace()" }, "", true, true)
end, { desc = "Python Breakpoint" })

-- Copilot
map(
  "i",
  "<C-j>",
  'copilot#Accept("\\<CR>")',
  { desc = "Use copilot", remap = false, expr = true, replace_keycodes = false }
)

vim.g.copilot_no_tab_map = true

map("n", "<leader>ccq", function()
  local input = vim.fn.input "Quick Chat: "
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { desc = "CopilotChat - Quick chat" })

map("n", "<leader>cc", "<cmd>:CopilotChatToggle<cr>", { desc = "CopilotChat - Toggle" })

-- Disable mappings
local nomap = vim.keymap.del
nomap("n", "<M-i>")


-- Function to toggle floating terminal
local function toggle_floating_terminal()
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = math.floor(vim.o.columns * 0.7),
    height = math.floor(vim.o.lines * 0.4),
    row = math.floor(vim.o.lines * 0.1),
    col = math.floor(vim.o.columns * 0.1),
    style = 'minimal',
    border = 'rounded',  -- Add rounded borders
  })
  vim.fn.termopen(vim.o.shell)
  vim.api.nvim_win_set_option(win, 'winblend', 10)  -- Set transparency
end

-- Add new mapping for terminal toggle floating
map("n", "<leader>i", toggle_floating_terminal, { desc = "Toggle floating terminal" })
