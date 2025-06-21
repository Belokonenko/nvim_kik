require 'core.options' -- Load general options
require 'core.keymaps' -- Load general keymaps
require 'core.snippets' -- Custom code snippets

-- Set up the Lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require('lazy').setup {
  require 'plugins.neotree',
  require 'plugins.colortheme',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.none-ls',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.indent-blankline',
  require 'plugins.misc',
  require 'plugins.comment',
}

-------------------------------------------------------------------
-- Функция для генерации CSS
function GenerateCssClasses()
  GenerateStylesheet('css', false)
end

-- Функция для генерации SCSS
function GenerateScssClasses()
  GenerateStylesheet('scss', true)
end

-- Общая функция для CSS/SCSS
function GenerateStylesheet(extension, use_nesting)
  -- Получаем путь к текущему HTML-файлу
  local file_path = vim.api.nvim_buf_get_name(0)

  -- Извлекаем путь к директории и имя файла без расширения
  local dir_path, file_name = file_path:match '(.*/)([^/]+)%.html$'

  if not file_name or not dir_path then
    print 'Ошибка: файл не HTML или путь не найден!'
    return
  end

  -- Формируем путь к CSS/SCSS-файлу
  local style_file = dir_path .. file_name .. '.' .. extension

  -- Собираем классы из HTML в порядке появления
  local classes = {}
  local class_order = {}

  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    for class_block in line:gmatch 'class="([^"]+)"' do
      for c in class_block:gmatch '[^ ]+' do
        if not classes[c] then
          classes[c] = true
          table.insert(class_order, c)
        end
      end
    end
  end

  -- Читаем уже существующие классы из CSS/SCSS
  local existing_classes = {}
  local style_f = io.open(style_file, 'r')
  if style_f then
    for line in style_f:lines() do
      local class = line:match '^%.([%w%-_]+) %{$'
      if class then
        existing_classes[class] = true
      end
    end
    style_f:close()
  end

  -- Формируем структуру SCSS или CSS
  local structure = {}

  for _, class in ipairs(class_order) do
    if not existing_classes[class] then
      if use_nesting then
        local parent, child = class:match '([^_]+)__([^_]+)'
        if parent and child then
          if not structure[parent] then
            structure[parent] = {}
          end
          table.insert(structure[parent], child)
        else
          structure[class] = structure[class] or {}
        end
      else
        structure[class] = structure[class] or {}
      end
      existing_classes[class] = true
    end
  end

  -- Если новых классов нет – выходим
  if next(structure) == nil then
    print('Все классы уже есть в ' .. style_file)
    return
  end

  -- Открываем файл на дозапись
  style_f = io.open(style_file, 'a')
  if style_f then
    style_f:write '\n' -- Добавляем отступ

    if use_nesting then
      -- SCSS с вложенностью
      for parent, children in pairs(structure) do
        style_f:write('.' .. parent .. ' {\n')
        for _, child in ipairs(children) do
          style_f:write('    &__' .. child .. ' { }\n')
        end
        style_f:write '}\n\n'
      end
    else
      -- Обычный CSS
      for parent, _ in pairs(structure) do
        style_f:write('.' .. parent .. ' {\n')
        style_f:write('    /* Стили для ' .. parent .. ' */\n')
        style_f:write '}\n\n'
      end
    end

    style_f:close()
    print('Добавлены новые классы в ' .. style_file)
  else
    print('Ошибка: не удалось открыть ' .. style_file)
  end
end

-- Регистрируем команды
vim.api.nvim_create_user_command('GenerateCSS', GenerateCssClasses, {})
vim.api.nvim_create_user_command('GenerateSCSS', GenerateScssClasses, {})

-- Назначаем хоткеи
vim.keymap.set('n', '<C-M-c>', ':GenerateCSS<CR>', { noremap = true, silent = true }) -- Ctrl + Alt + C → CSS
vim.keymap.set('n', '<C-M-s>', ':GenerateSCSS<CR>', { noremap = true, silent = true }) -- Ctrl + Alt + S → SCSS
