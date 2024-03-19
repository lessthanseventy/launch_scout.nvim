return {

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signcolumn = true,
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map("n", "<leader>gbR", gs.reset_buffer, "Reset Buffer")
      end,
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },

  -- {
  --   "kdheepak/lazygit.nvim",
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  -- },

  {
    "ruifm/gitlinker.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>gy", "<cmd>lua require('gitlinker').get_buf_range_url('n')<cr>", desc = "Copy Github Link" },
    },
    config = function()
      require("gitlinker").setup({ mappings = nil })
    end,
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
  },

  {
    "NeogitOrg/neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
  },

  {
    "tanvirtin/vgit.nvim",
    keys = {
      { "<leader>ghr", "<cmd>lua require('vgit').buffer_hunk_reset()<cr>", desc = "Reset Hunk" },
      { "<leader>ghp", "<cmd>lua require('vgit').buffer_hunk_preview()<cr>", desc = "Preview Hunk" },
      { "<leader>gbb", "<cmd>lua require('vgit').buffer_blame_preview()<cr>", desc = "Preview Blame" },
      { "<leader>gbd", "<cmd>lua require('vgit').buffer_diff_preview()<cr>", desc = "Diff" },
      { "<leader>gbh", "<cmd>lua require('vgit').buffer_history_preview()<cr>", desc = "History" },
      { "<leader>gbg", "<cmd>lua require('vgit').buffer_gutter_blame_preview()<cr>", desc = "Gutter Blame" },
      { "<leader>gd", "<cmd>lua require('vgit').project_diff_preview()<cr>", desc = "Diff Project" },
      { "<leader>gq", "<cmd>lua require('vgit').project_hunks_qf()<cr>", desc = "Hunks QF" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
}
