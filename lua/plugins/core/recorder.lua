return {

  -- better macros, no more qaqq@a@@ stuff
  {
    "chrisgrieser/nvim-recorder",
    lazy = false,
    config = function()
      require("recorder").setup({
        slots = { "a", "b", "c" },
        mapping = {
          startStopRecording = "q",
          playMacro = "Q",
          switchSlot = "<C-q>",
          editMacro = "cq",
          yankMacro = "yq", -- also decodes it for turning macros to mappings
          addBreakPoint = "##", -- ⚠️ this should be a string you don't use in insert mode during a macro
        },
        clear = false,
        logLevel = vim.log.levels.INFO,
        dapSharedKeymaps = false,
      })
    end,
  },
}
