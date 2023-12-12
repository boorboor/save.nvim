local M = {}

M.cmds = {
  {
    name = 'no cmd',
    cmd = function() vim.cmd('echo "auto save off"') end 
  },
  {
    name = 'write',
    cmd = function() vim.cmd('silent! write |echo "file saved"') end 
  },
  {
    name = 'write all',
    cmd = function() vim.cmd('silent! write all |echo "files saved"') end 
  },
  {
    name = 'last command',
    cmd = function() vim.cmd('silent! @: |echo "last command executed"') end
  },
}

M.setup = function()
  -- auto run command on focus loss, default false
  vim.api.nvim_create_autocmd('FocusLost', {
    callback = function() M.cmds[1].cmd() end,
  })

  vim.keymap.set('n', '<F4>', function()
    table.insert(M.cmds, 1, table.remove(M.cmds))
    print('FocusLost mode:', M.cmds[1].name)
  end)
end

return M
