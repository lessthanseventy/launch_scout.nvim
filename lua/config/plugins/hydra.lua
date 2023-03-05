local M = {}

local function cmd(command)
  return table.concat { "<Cmd>", command, "<CR>" }
end

local function telescope_menu()
  local Hydra = require "hydra"

  local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _h_: vim help    _c_: execute command
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _k_: keymap      _;_: commands history
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _r_: registers   _?_: search history

                 _<Enter>_: Telescope           _<Esc>_ 
]]

  Hydra {
    name = "Telescope",
    hint = hint,
    config = {
      color = "teal",
      invoke_on_body = true,
      hint = {
        position = "middle",
        border = "rounded",
      },
    },
    mode = "n",
    body = "<LocalLeader>f",
    heads = {
      { "f", cmd "Telescope find_files" },
      { "g", cmd "Telescope live_grep" },
      { "h", cmd "Telescope help_tags", { desc = "Vim help" } },
      { "o", cmd "Telescope oldfiles", { desc = "Recently opened files" } },
      { "m", cmd "MarksListBuf", { desc = "Marks" } },
      { "k", cmd "Telescope keymaps" },
      { "r", cmd "Telescope registers" },
      { "p", cmd "Telescope projects", { desc = "Projects" } },
      { "/", cmd "Telescope current_buffer_fuzzy_find", { desc = "Search in file" } },
      { "?", cmd "Telescope search_history", { desc = "Search history" } },
      { ";", cmd "Telescope command_history", { desc = "Command-line history" } },
      { "c", cmd "Telescope commands", { desc = "Execute command" } },
      { "<Enter>", cmd "Telescope", { exit = true, desc = "List all pickers" } },
      { "<Esc>", nil, { exit = true, nowait = true } },
    },
  }
end

function M.setup()
  telescope_menu()
end

return M
