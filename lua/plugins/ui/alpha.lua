return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    init = function()
      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "alpha" },
        callback = function()
          vim.cmd([[
            set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
            set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
          ]])
        end,
      })
    end,
    config = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[                _             _             _                  _              _             _       _  ]],
        [[               _\ \          / /\          /\_\               /\ \     _    /\ \           / /\    / /\]],
        [[              /\__ \        / /  \        / / /         _    /  \ \   /\_\ /  \ \         / / /   / / /]],
        [[             / /_ \_\      / / /\ \       \ \ \__      /\_\ / /\ \ \_/ / // /\ \ \       / /_/   / / / ]],
        [[            / / /\/_/     / / /\ \ \       \ \___\    / / // / /\ \___/ // / /\ \ \     / /\ \__/ / /  ]],
        [[           / / /         / / /  \ \ \       \__  /   / / // / /  \/____// / /  \ \_\   / /\ \___\/ /   ]],
        [[          / / /         / / /___/ /\ \      / / /   / / // / /    / / // / /    \/_/  / / /\/___/ /    ]],
        [[         / / / ____    / / /_____/ /\ \    / / /   / / // / /    / / // / /          / / /   / / /     ]],
        [[        / /_/_/ ___/\ / /_________/\ \ \  / / /___/ / // / /    / / // / /________  / / /   / / /      ]],
        [[       /_______/\__\// / /_       __\ \_\/ / /____\/ // / /    / / // / /_________\/ / /   / / /       ]],
        [[       \_______\/    \_\___\     /____/_/\/_________/ \/_/     \/_/ \/____________/\/_/    \/_/        ]],
        [[                           _            _              _      _                _                       ]],
        [[                         / /  \       /  \ \         /  \ \ / / /         _   \_\ \                    ]],
        [[                        / / /\ \__   / /\ \ \       / /\ \ \\ \ \__      /\_\ /\__ \                   ]],
        [[                       / / /\ \___\ / / /\ \ \     / / /\ \ \\ \___\    / / // /_ \ \                  ]],
        [[                       \ \ \ \/___// / /  \ \_\   / / /  \ \_\\__  /   / / // / /\ \ \                 ]],
        [[                        \ \ \     / / /    \/_/  / / /   / / // / /   / / // / /  \/_/                 ]],
        [[                    _    \ \ \   / / /          / / /   / / // / /   / / // / /                        ]],
        [[                   /_/\__/ / /  / / /________  / / /___/ / // / /___/ / // / /                         ]],
        [[                   \ \/___/ /  / / /_________\/ / /____\/ // / /____\/ //_/ /                          ]],
        [[                    \_____\/   \/____________/\/_________/ \/_________/ \_\/                           ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("w", "𝌸  Find workspace", "<cmd>Telescope workspaces<CR>"),
        dashboard.button("c", "  Nvim Configuration", "<cmd>Oil --float /home/andrew/.config/nvim/lua/<cr>"),
        dashboard.button("q", "  🟔 🟔 🟔  🟔 🟔 🟔 ", ":qa!<CR>"),
      }

      local function footer()
        -- NOTE: requires the fortune-mod package to work
        local handle = io.popen("fortune -s")
        local fortune = handle:read("*a")
        handle:close()
        local border = "------------------------------------------------------------------------------\n"
        return border .. fortune .. border
      end

      dashboard.section.footer.val = footer()

      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"

      dashboard.opts.opts.noautocmd = false

      local opts = dashboard.opts

      require("alpha").setup(opts)
    end,
  },
}
