local augroup = vim.api.nvim_create_augroup('Commands', {})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd('normal! g`"zz')
    end
  end,
})

-- Registering this autocommand stops
-- 'file no longer available'
-- errors after deleting a file in Oil
vim.api.nvim_create_autocmd('FileChangedShell', {
  group = augroup,
  pattern = '*',
  callback = function()
    if vim.v.fcs_reason == 'deleted' then
      -- TODO: Ask whether to close file?
    else
      vim.v.fcs_choice = 'edit'
    end
  end
})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command('SetIndent', function(opts)
  local n = tonumber(opts.args)
  vim.bo.shiftwidth = n
  vim.bo.tabstop = n
  vim.bo.softtabstop = n
  vim.bo.expandtab = true
end, { nargs = 1 })

vim.api.nvim_create_user_command('GoFast', function()
  vim.treesitter.stop()
  vim.cmd.syntax(false)
  vim.cmd('IBLDisable')
  vim.opt.cursorline = false
  vim.opt.wrap = false
end, {})

vim.api.nvim_create_autocmd('FocusGained', {
  group = augroup,
  pattern = '*',
  callback = function()
    pcall(vim.cmd.checktime)
  end
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup,
  pattern = '*',
  callback = function()
    vim.cmd.startinsert()
  end
})

vim.api.nvim_create_autocmd('TermClose', {
  group = augroup,
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd.bd { bang = true }
    end
  end
})

local bufviews = {}

vim.api.nvim_create_autocmd('BufLeave', {
  group = augroup,
  pattern = '*',
  callback = function()
    bufviews[vim.api.nvim_get_current_buf()] = vim.fn.winsaveview()
  end
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup,
  pattern = '*',
  callback = function()
    local saved = bufviews[vim.api.nvim_get_current_buf()]
    if saved == nil then
      return
    end
    vim.fn.winrestview(saved)
  end
})

-- Open current file/line in GitHub
vim.api.nvim_create_user_command('OpenInGitHub', function(opts)
  local filepath = vim.fn.expand('%:p')
  if filepath == '' then
    vim.notify('No file open', vim.log.levels.WARN)
    return
  end

  -- Get git root directory
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(vim.fn.expand('%:p:h')) .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    vim.notify('Not in a git repository', vim.log.levels.ERROR)
    return
  end

  -- Get relative path from git root
  local relative_path = vim.fn.fnamemodify(filepath, ':p'):sub(#git_root + 2)

  -- Get remote URL
  local remote_url = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(git_root) .. ' config --get remote.origin.url')[1]
  if vim.v.shell_error ~= 0 then
    vim.notify('No remote origin found', vim.log.levels.ERROR)
    return
  end

  -- Convert SSH URL to HTTPS if needed (works for github.com and GitHub Enterprise)
  -- Handles: git@DOMAIN:org/repo.git -> https://DOMAIN/org/repo
  remote_url = remote_url:gsub('git@([^:]+):', 'https://%1/')
  remote_url = remote_url:gsub('%.git$', '')

  -- Get current branch or commit hash
  local branch = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(git_root) .. ' rev-parse --abbrev-ref HEAD')[1]
  if branch == 'HEAD' then
    -- Detached HEAD, use commit hash
    branch = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(git_root) .. ' rev-parse HEAD')[1]
  end

  -- Get line numbers
  local line_start, line_end
  if opts.range == 2 then
    -- Visual mode selection
    line_start = opts.line1
    line_end = opts.line2
  else
    -- Normal mode, current line
    line_start = vim.fn.line('.')
    line_end = line_start
  end

  -- Construct GitHub URL
  local url
  if line_start == line_end then
    url = string.format('%s/blob/%s/%s#L%d', remote_url, branch, relative_path, line_start)
  else
    url = string.format('%s/blob/%s/%s#L%d-L%d', remote_url, branch, relative_path, line_start, line_end)
  end

  -- Open in browser
  vim.fn.system('open ' .. vim.fn.shellescape(url))
  vim.notify('Opened in GitHub: ' .. url, vim.log.levels.INFO)
end, { range = true })
