-- Debugger plugin specifications
-- Configuration in after/plugin/debugger.lua

return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'leoluz/nvim-dap-go',
      'theHamsta/nvim-dap-virtual-text',
      'mfussenegger/nvim-dap-python'
    }
  },
}
