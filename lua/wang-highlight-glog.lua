vim.cmd("syntax match GlogErrorMsg /^E[0-9].*$/")
vim.cmd("syntax match GlogWarningMsg /^W[0-9].*$/")
vim.cmd("hi GlogErrorMsg guifg=red")
vim.cmd("hi GlogWarningMsg guifg=yellow")

return {}
