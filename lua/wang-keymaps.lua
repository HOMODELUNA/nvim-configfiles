vim.api.nvim_create_user_command("WangFormatJson", "%!jq .", {
  nargs = 0,
  desc = "Format json file with 'jq'",
  bang = false,
})
