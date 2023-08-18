return {
  'johmsalas/text-case.nvim',
  cmd = {
    'CaseUpper',
    'CaseLower',
    'CaseSnake',
    'CaseDash',
    'CaseConstant',
    'CaseDot',
    'CasePhrase',
    'CaseCamel',
    'CasePascal',
    'CaseTitle',
    'CasePath',
  },
  config = function()
    local textcase = require('textcase')
    vim.api.nvim_create_user_command('CaseUpper', function() textcase.current_word('to_upper_case') end, {})
    vim.api.nvim_create_user_command('CaseLower', function() textcase.current_word('to_lower_case') end, {})
    vim.api.nvim_create_user_command('CaseSnake', function() textcase.current_word('to_snake_case') end, {})
    vim.api.nvim_create_user_command('CaseDash', function() textcase.current_word('to_dash_case') end, {})
    vim.api.nvim_create_user_command('CaseConstant', function() textcase.current_word('to_constant_case') end, {})
    vim.api.nvim_create_user_command('CaseDot', function() textcase.current_word('to_dot_case') end, {})
    vim.api.nvim_create_user_command('CasePhrase', function() textcase.current_word('to_phrase_case') end, {})
    vim.api.nvim_create_user_command('CaseCamel', function() textcase.current_word('to_camel_case') end, {})
    vim.api.nvim_create_user_command('CasePascal', function() textcase.current_word('to_pascal_case') end, {})
    vim.api.nvim_create_user_command('CaseTitle', function() textcase.current_word('to_title_case') end, {})
    vim.api.nvim_create_user_command('CasePath', function() textcase.current_word('to_path_case') end, {})
  end
}
