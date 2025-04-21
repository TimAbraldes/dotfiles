return {
  "folke/flash.nvim",
  opts = {
    modes = {
      char = {
        -- disable f F t T overrides. Preserve the original behavior for those keys
        enabled = false,
      },
    },
  },
  keys = {
    -- disable s override. Preserve the original behavior for that key
    { "s", mode = { "n", "x", "o" }, false },
  },
}
