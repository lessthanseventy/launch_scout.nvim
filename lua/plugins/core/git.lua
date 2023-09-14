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

  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

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
    "ldelossa/gh.nvim",
    lazy = true,
    dependencies = "ldelossa/litee.nvim",
    config = function()
      require("litee.lib").setup()
      require("litee.gh").setup({
        map_resize_keys = true,
      })

      local wk = require("which-key")
      wk.register({
        g = {
          name = "+Git",
          h = {
            name = "+Hunk",
          },
          b = {
            name = "+Buffer",
          },
          G = {
            name = "+Github",
            c = {
              name = "+Commits",
              c = { "<cmd>GHCloseCommit<cr>", "Close" },
              e = { "<cmd>GHExpandCommit<cr>", "Expand" },
              o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
              p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
              z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
            },
            i = {
              name = "+Issues",
              p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
            },
            l = {
              name = "+Litee",
              t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
            },
            r = {
              name = "+Review",
              b = { "<cmd>GHStartReview<cr>", "Begin" },
              c = { "<cmd>GHCloseReview<cr>", "Close" },
              d = { "<cmd>GHDeleteReview<cr>", "Delete" },
              e = { "<cmd>GHExpandReview<cr>", "Expand" },
              s = { "<cmd>GHSubmitReview<cr>", "Submit" },
              z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
            },
            p = {
              name = "+Pull Request",
              c = { "<cmd>GHClosePR<cr>", "Close" },
              d = { "<cmd>GHPRDetails<cr>", "Details" },
              e = { "<cmd>GHExpandPR<cr>", "Expand" },
              o = { "<cmd>GHOpenPR<cr>", "Open" },
              p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
              r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
              t = { "<cmd>GHOpenToPR<cr>", "Open To" },
              z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
            },
            t = {
              name = "+Threads",
              c = { "<cmd>GHCreateThread<cr>", "Create" },
              n = { "<cmd>GHNextThread<cr>", "Next" },
              t = { "<cmd>GHToggleThread<cr>", "Toggle" },
            },
          },
        },
      }, { prefix = "<leader>" })
    end,
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
