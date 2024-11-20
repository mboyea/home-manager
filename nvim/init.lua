vim.opt.clipboard = 'unnamedplus'
vim.opt.copyindent = true
vim.opt.preserveindent = true
vim.opt.scrolloff = 10
vim.opt.number = true;
vim.opt.relativenumber = true;

function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })
end

LineNumberColors()

