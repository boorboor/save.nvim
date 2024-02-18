local M = {}

local modes = {
    {
        name = 'no action',
    },
    {
        name = 'last command',
        cmd = function()
            local success, err = pcall(vim.cmd, '@:')
            if not success then
                vim.api.nvim_echo({ { "Error: " .. err } }, false, {})
            end
        end
    },
    {
        name = 'write all',
        cmd = function()
            local success, err = pcall(vim.cmd, 'wall')
            if not success then
                vim.api.nvim_echo({ { "Error: " .. err } }, false, {})
            end
        end
    },
    {
        name = 'write',
        cmd = function()
            if vim.bo.modified then
                local success, err = pcall(vim.cmd, 'write')
                if not success then
                    vim.api.nvim_echo({ { "Error: " .. err } }, false, {})
                end
            end
        end
    },
}

local focus_lost_autocmd_id = nil
-- Default configuration
local config = {
    change_mode_mapping = '<F4>',
}

local function merge_config(conf)
    if conf then
        for key, value in pairs(conf) do
            config[key] = value
        end
    end
end

M.setup = function(conf)
    merge_config(conf)
    vim.api.nvim_create_augroup('SaveFocusLostGroup', { clear = true })

    vim.keymap.set('n', config.change_mode_mapping, function()
        table.insert(modes, 1, table.remove(modes))
        if modes[1].name == 'no action' then
            if focus_lost_autocmd_id then
                vim.api.nvim_del_autocmd(focus_lost_autocmd_id)
                focus_lost_autocmd_id = nil
            end
        else
            vim.api.nvim_clear_autocmds({ group = 'SaveFocusLostGroup' })
            focus_lost_autocmd_id = vim.api.nvim_create_autocmd('FocusLost', {
                group = 'SaveFocusLostGroup',
                callback = function() modes[1].cmd() end,
            })
        end
        vim.api.nvim_echo({ { 'FocusLost mode: ' .. modes[1].name } }, false, {})
    end)
end

return M
