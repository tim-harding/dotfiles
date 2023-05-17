return {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },

    {
      "<S-F5>",
      function()
        require("dap").continue()
      end,
      desc = "Stop",
    },

    {
      "<F6>",
      function()
        require("dap").step_over()
      end,
      desc = "Step over",
    },

    {
      "<F9>",
      function()
        require("dap").step_into()
      end,
      desc = "Step into",
    },

    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "Step out",
    },
  },
}
