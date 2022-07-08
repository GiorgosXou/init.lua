_G['__strict_toggle'] = true


local config = {
  updater    = {
    commit         = nil      , -- commit hash (NIGHTLY ONLY)
    branch         = "main"   , -- branch name (NIGHTLY ONLY)
    remote         = "origin" , -- remote to use
    channel        = "nightly", -- "stable" or "nightly"
    version        = "latest" , -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    pin_plugins    = nil      , -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts   = false    , -- skip prompts about breaking changes
    show_changelog = true     , -- show the changelog after performing an update
  },
  colorscheme = 'ayu-dark', -- Set colorscheme

  options = { -- set vim options here (vim.<first_key>.<second_key> =  value)
    opt   = { -- clipboard = "",
      relativenumber = true, -- sets vim.opt.relativenumber
    },
    g = {
      mkdp_theme      = 'dark',
      mapleader       = " "   , -- sets vim.g.mapleader
      VM_maps         = {
        ['Find Under']      = '<C-d>'      ,
        ["Add Cursor Down"] = '<C-A-Down>' ,
        ["Add Cursor Up"]   = '<C-A-Up>'   ,
      },
      go_to_relative_line = function (num) -- maybe add str for reasons like: goto d = next douplicate?
        local win = vim.api.nvim_get_current_win() --vim.api.nvim_input(
        vim.api.nvim_win_set_cursor(win, {vim.api.nvim_win_get_cursor(win)[1] +  num,0})
      end,

      jump_word_e = function (v) -- meh
        local col = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[2]
        vim.api.nvim_input((vim.api.nvim_get_current_line():sub(col+1,col+1) == '.' and '<right>' or '').. (v and '' or '<C-o>').. 'e<right>')
      end,

      jump_word_b = function (v) -- meh v.2 | Added: repeating code, lol | Better than having multiple local variables and an if statment
        local col = vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[2]
        vim.api.nvim_input((vim.api.nvim_get_current_line():sub(col,col)     == '.' and '<left>'  or '').. (v and '' or '<C-o>').. 'b')
      end, -- TODO: make it work in visual mode

      paste_check = function ()
        local clipboard = vim.fn.getreg('+')
        if string.find(clipboard, "\n") then                  -- that find, meh..
          local win = vim.api.nvim_get_current_win()
          local pos = vim.api.nvim_win_get_cursor(win)        --vim.api.nvim_buf_set_lines(0, pos[1], pos[1], false, {''})
          vim.api.nvim_command('pu')                          -- TODO: 'u' only if not line.trim is nothing| https://stackoverflow.com/a/1346747/11465149
          vim.api.nvim_win_set_cursor(win, {pos[1]+1,pos[2]})
          return ''                                           --clipboard:sub(0,-2)
        end
        return clipboard
      end,

      paste_on_visual = function ()
        print("test v paste")
      end,

      toggle_strict_mode = function () -- eew!
        local c
        if _G['__strict_toggle'] then
          _G['__strict_toggle'] = false
          for i = 32, 126, 1 do
            c = string.char(i)
            vim.keymap.set('v', c, '"_di'.. c)
          end
          vim.keymap.set('v', '<CR>', '"_di<CR>')
          print('Strict mode enabled')
        else
          _G['__strict_toggle'] = true
          for i = 32, 126, 1 do
            c = string.char(i)
            vim.keymap.del('v', c)
          end
          vim.keymap.del('v', '<CR>')
          print('Strict mode disabled')
        end
      end
  },},


  header = {
        '             \\                                      [            ',
        '              @                 ⟡                  ╢             ',
        '      /       ╣▒                                  ]▒       \\     ',
        '     ╔       ]Ñ▒                                  ╟╣┐       ▓    ',
        '    ╢╣       ╣▓            √          t            ▓╣       ▓╣   ',
        '   ▓╣▒╖    ╓╫╜           ╥▓   ASTROν   ▓@           ╙▓╖    ╔╣╢║  ',
        '   ▓▓▓▓  ,p▓,,,,,,      ╜╙▓▄╖,      ,╓╥╜╙╙    ,,,,,,,,▓▓,  ▀▓▓╣U ',
        '   ▀▓Ö   ╙█▓▓▓▓▓▓╢╫╣▓▓▓▓▓╦, ▀▓▓╗  g╢▓╝ ,╓H╢╢╢╢╢╢▓▓▓▓▓▓▒▓╜   ]▓▓  ',
        '    ▓▓▓╦╥╖ ╙╙╙╙`     `""▀▓▓@ ▐█▓L]▓╫╛ Æ▒╨╜"       ""╙╙` ╓╖∩▒▒▓   ',
        ' ╒▓▒╜""╙▀▓▓                ▀  █▒Γ▐▓▓  ╩                ▓╢╜""╙▀█╫L',
        ' ▐▌`      └╝                  ▓▒` █▓                  ╜       └█▓',
        '▐▓                            ▓▒  █╢                           ▐▓',
        ' ▐Γ                            ╛  ▐"                           ▐[',
        ' ¬U                                                            jU',
        '  C                                                            j ',
        '   L                                                          ]  ',
  },


  default_theme       = { -- Default theme configuration
    diagnostics_style = { italic = true },
    colors            = { -- Modify the color table
      fg              = "#abb2bf"        ,
    },

    highlights          = function(highlights) -- Modify the highlight groups
      local C           = require "default_theme.colors"
      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,

    plugins = { -- enable or disable extra plugin highlighting
      aerial                = true ,
      notify                = true ,
      rainbow               = true ,
      telescope             = true ,
      dashboard             = true ,
      bufferline            = true ,
      highlighturl          = true ,
      indent_blankline      = true ,
      ["nvim-web-devicons"] = true ,
      ["neo-tree"         ] = true ,
      ["which-key"        ] = true ,
      ["nvim-tree"        ] = false,
      hop                   = false,
      vimwiki               = false,
      beacon                = false,
      lightspeed            = false,
      symbols_outline       = false,
  },},


  ui                 = { -- Disable AstroNvim ui features
    nui_input        = true,
    telescope_select = true,
  },


  plugins = { -- Configure plugins
    init  = { -- Add plugins, the packer syntax without the "use"
      {'mg979/vim-visual-multi'     },
      {'m-pilia/vim-smarthome'      },
      {'projekt0n/github-nvim-theme'},
      {'fcpg/vim-orbital'           },
      {'romainl/vim-malotru'        },
      {'tpope/vim-sleuth'           },
      {'tpope/vim-commentary'       },
      {'Mofiqul/vscode.nvim'        },
      {'iamcco/markdown-preview.nvim', run    = function() vim.fn["mkdp#util#install"]() end},
      {'petertriho/nvim-scrollbar'   , config = function() require("scrollbar").setup () end},
      {'Shatur/neovim-ayu'           , config = function() require('ayu'      ).setup (     {
        overrides                    = {                 -- :Telescope highlights 
          Type                       = {fg = '#FF5F00'},
          Macro                      = {fg = '#FF5F00'},
          Normal                     = {bg = '#0C0C0C'}, -- 'NONE'
          Repeat                     = {fg = '#FF5F00'},
          Method                     = {fg = '#FF5F00'},
          PreProc                    = {fg = '#FF5F00'},
          Include                    = {fg = '#FF5F00'},
          Keyword                    = {fg = '#FF5F00'},
          Exception                  = {fg = '#FF5F00'},
          Statement                  = {fg = '#FF5F00'},
          Constructor                = {fg = '#FF5F00'},
          FuncBuiltin                = {fg = '#FF5F00'},
          TypeDefinition             = {fg = '#FF5F00'},
          KeywordFunction            = {fg = '#FF5F00'},
          IndentBlanklineContextChar = {fg = '#FF5F00'},
          -- #FFC26B #860000 #64BAAA #006B5D  #Maybe?
      }}) end                       },
    },

    cmp = function(config)
      local cmp                    = require "cmp"
      config.mapping["<ESC>"     ] = cmp.mapping.abort()
      config.mapping["<C-Space>" ] = cmp.mapping      ({
        i = function() if cmp.visible() then cmp.abort() else cmp.complete() end end,
        c = function() if cmp.visible() then cmp.close() else cmp.complete() end end,
      })
      config.mapping["<F7>"      ] = config.mapping["<C-Space>"] -- Windows only
      config.enabled               = function         ()         -- https://www.reddit.com/r/neovim/comments/skkp1r/disable_cmp_inside_comments/
        local context = require("cmp.config.context")
        return cmp.visible() or not(
          context.in_treesitter_capture("comment") or
          context.in_treesitter_capture('string' ) or
          context.in_syntax_group      ("Comment")
        )
      end
      return config
    end,

    ["neo-tree"]                = {
      default_component_configs = {
        indent                  = {
          last_indent_marker    = "╰",
    },},},

    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        null_ls.builtins.formatting.rufo    , -- Set a formatter
        null_ls.builtins.diagnostics.rubocop, -- Set a linter
      }

      config.on_attach = function(client)                        -- set up null-ls's on_attach function
        if client.resolved_capabilities.document_formatting then -- NOTE: You can remove this on attach function to disable format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc     = "Auto format before save"   ,
            pattern  = "<buffer>"                  ,
            callback = vim.lsp.buf.formatting_sync ,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter             = { ensure_installed = { "lua"         } },
    ["nvim-lsp-installer"] = { ensure_installed = { "sumneko_lua" } },
    packer                 = {
      compile_path         = vim.fn.stdpath "data" .. "/packer_compiled.lua",
  },},


  luasnip                = {   -- LuaSnip Options
    vscode_snippet_paths = {}, -- Add paths for including more VS Code style snippets in luasnip
    filetype_extend      = {
      javascript         = { "javascriptreact" }
  },}, -- Extend filetypes


  ["which-key"]       = { -- Modify which-key registration
    register_mappings = { -- Add bindings
      n               = { -- first key is the mode, n == normal mode
        ["<leader>"]  = { -- second key is the prefix, <leader> prefixes
          -- which-key registration table for normal mode, leader prefix
          -- ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
  },},},},


  cmp               = {
    source_priority = {
      nvim_lsp      = 1000 ,
      luasnip       = 750  ,
      buffer        = 500  ,
      path          = 250  ,
  },},


  lsp       = { -- Extend LSP configuration
    servers = { -- enable servers that you already have installed without lsp-installer
      -- "pyright"
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = { --[[
      example for addings schemas to yamlls
      yamlls        = {
        settings    = {
          yaml      = {
            schemas = {
              ["http://json.schemastore.org/github-workflow"   ] = ".github/workflows/*.{yml,yaml}",
              ["http://json.schemastore.org/github-action"     ] = ".github/action.{yml,yaml}"     ,
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}"      ,
      },},},},              ]]--
  },},


  diagnostics    = { -- Diagnostics configuration (for vim.diagnostics.config({}))
    virtual_text = true,
    underline    = true,
  },



  polish = function() -- This function is run last -- good place to configure mappings and vim options
    local map     = vim.keymap
    local bufopts = { silent=true }

    vim.api.nvim_command('set shiftwidth=4'         ) -- default if not Sleuth?
    vim.api.nvim_command('call toggle_strict_mode()')

    --vim.api.nvim_command('set im!')
    --vim.api.nvim_input('i')
    --vim.api.nvim_command('set iskeyword+=.')
    --Set Keybindings

    -- Shift l h to switch tabs
    --map.set('n', 'dil'         , "dd:let @+=matchlist(strtrans(@+),'[ ]*\\zs.*\\ze\\^@')[0]<CR>", { desc = "(Delete-in-line) Delete\\Cut line without \\n"}) --Delete in line

    map.set('i', '<C-A-up>'          , '<ESC>:call vm#commands#add_cursor_up(0,1)<CR>'           , bufopts)
    map.set('i', '<C-A-down>'        , '<ESC>:call vm#commands#add_cursor_down(0,1)<CR>'         , bufopts)
    map.set('v', '<Tab>'             , '>gv'                                                     , bufopts)
    map.set('v', '<S-Tab>'           , '<gv'                                                     , bufopts)
    map.set('i', '<S-Tab>'           , '<ESC>v<<ESC>i<right>'                                    , bufopts)
    map.set("i", "<C-s>"             , "<C-o>:w!<CR>"                                            , bufopts) -- On black line stays on normal mode
    map.set("n", "<C-s>"             , ":w!<CR>"                                                 , bufopts)
    map.set("i", "<C-q>"             , '<C-o>:q!<CR>'                                            , bufopts)
    map.set("v", "<C-q>"             , ':q!<CR>'                                                 , bufopts)
    map.set('n', '<A-j>'             , ':m+<CR>=='                                               , bufopts)
    map.set('n', '<A-down>'          , ':m+<CR>=='                                               , bufopts)
    map.set('n', '<A-k>'             , ':m-2<CR>=='                                              , bufopts)
    map.set('n', '<A-up>'            , ':m-2<CR>=='                                              , bufopts)
    map.set('i', '<A-j>'             , '<Esc>:m+<CR>==gi'                                        , bufopts)
    map.set('i', '<A-down>'          , '<Esc>:m+<CR>==gi'                                        , bufopts)
    map.set('i', '<A-k>'             , '<Esc>:m-2<CR>==gi'                                       , bufopts)
    map.set('i', '<A-up>'            , '<Esc>:m-2<CR>==gi'                                       , bufopts)
    map.set('v', '<A-j>'             , ':m\'>+<CR>gv=gv'                                         , bufopts)
    map.set('v', '<A-down>'          , ':m\'>+<CR>gv=gv'                                         , bufopts)
    map.set('v', '<A-k>'             , ':m-2<CR>gv=gv'                                           , bufopts)
    map.set('v', '<A-up>'            , ':m-2<CR>gv=gv'                                           , bufopts)
    map.set('i', '<C-right>'         , '<C-o>:call jump_word_e()<CR>'                            , bufopts)
    map.set('i', '<C-left>'          , '<C-o>:call jump_word_b()<CR>'                            , bufopts)
    map.set('n', '<C-right>'         , 'e'                                                       , bufopts) -- https://vi.stackexchange.com/questions/12614/prevent-w-from-jumping-to-next-line#comment21820_12614
    map.set('n', '<C-left>'          , 'b'                                                       , bufopts)
    map.set('v', '<C-c>'             , 'ygv'                                                     , bufopts) -- https://stackoverflow.com/questions/47842041/
    map.set('i', '<C-c>'             , '<C-o>yy'                                                 , bufopts)
    map.set('v', '<C-v>'             , "\"_dgP"                                                  , bufopts)
    map.set('i', '<C-v>'             , "<C-r>=paste_check()<CR>"                                 , bufopts)
    map.set('i', '<C-Up>'            , '<C-o><C-y>'                                              , bufopts)
    map.set('i', '<C-S-Up>'          , '<C-o><C-v>k'                                             , bufopts) -- WTF HAPPENED WITH C-S-UpDown | C-v to see what key
    map.set('i', '<C-S-Down>'        , '<C-o><C-v>j'                                             , bufopts) -- WTF HAPPENED WITH C-S-UpDown | C-v to see what key
    map.set('i', '<F8>'              , '<C-o><C-v>k'                                             , bufopts) -- WTF HAPPENED WITH C-S-UpDown | C-v to see what key
    map.set('i', '<F6>'              , '<C-o><C-v>j'                                             , bufopts) -- WTF HAPPENED WITH C-S-UpDown | C-v to see what key
    map.set('i', '<A-M>'             , '<C-o>o'                                                  , bufopts) -- Alacritty for some reason (Alt capital M?)
    map.set('i', '<C-cr>'            , '<C-o>o'                                                  , bufopts)
    map.set('i', '<F9>'              , '<C-o>o'                                                  , bufopts) -- On Windows | PowerToys > Keyboard Manager
    map.set('v', '<C-cr>'            , '<ESC>o'                                                  , bufopts)
    map.set('v', '<F9>'              , '<ESC>o'                                                  , bufopts) -- On Windows | PowerToys > Keyboard Manager
    map.set('i', '<C-Down>'          , '<C-o><C-e>'                                              , bufopts)
    map.set('i', '<S-Up>'            , '<left><C-o>vk'                                           , bufopts)
    map.set('i', '<S-Down>'          , '<C-o>vj'                                                 , bufopts)
    map.set('i', '<S-left>'          , '<left><C-o>v'                                            , bufopts)
    map.set('i', '<S-right>'         , '<C-o>v'                                                  , bufopts)
    map.set('i', '<C-S-left>'        , '<left><C-o>vb'                                           , bufopts)
    map.set('i', '<C-S-right>'       , '<C-o>vw'                                                 , bufopts)
    map.set('i', '<C-x>'             , '<C-o>dd'                                                 , bufopts) -- i fucked up termux or this messes up with termux
    map.set('v', '<C-x>'             , 'di'                                                      , bufopts)
    map.set('v', '<BS>'              , '"_di'                                                    , bufopts)
    map.set('v', '<left>'            , 'O<ESC>i'                                                 , bufopts) -- Make it jump like in vscode vim.fn.col('O')?
    map.set('v', '<right>'           , '<ESC>i<right>'                                           , bufopts) -- Make it jump like in vscode
    map.set('v', '<up>'              , '<ESC><up>i'                                              , bufopts) -- fix right or left
    map.set('v', '<down>'            , '<ESC><down>i'                                            , bufopts) -- fix right or left
    map.set('v', '<S-right>'         , 'l'                                                       , bufopts)
    map.set('v', '<S-left>'          , 'h'                                                       , bufopts)
    map.set('v', '<S-up>'            , 'k'                                                       , bufopts)
    map.set('v', '<S-down>'          , 'j'                                                       , bufopts)
    map.set('i', '<C-_>'             , '<C-o>:Commentary<cr>'                                    , bufopts) -- On Windows
    map.set('i', '<C-/>'             , '<C-o>:Commentary<cr>'                                    , bufopts)
    map.set('v', '<C-_>'             , ':Commentary<cr>'                                         , bufopts) -- On Windows
    map.set('v', '<C-/>'             , ':Commentary<cr>'                                         , bufopts)
    map.set('i', '<C-b>'             , '<ESC>:Neotree toggle<cr>'                                , bufopts)
    map.set('n', '<C-b>'             , ':Neotree toggle<cr>'                                     , bufopts)
    map.set('i', '<C-z>'             , '<C-o>u'                                                  , bufopts)
    map.set('v', '<C-z>'             , '<ESC>ui'                                                 , bufopts)
    map.set('i', '<C-r>'             , '<C-o>:redo<cr>'                                          , bufopts)
    map.set('i', '<C-S-z>'           , '<C-o>:redo<cr>'                                          , bufopts)
    map.set('i', '<F10>'             , '<C-o>:redo<cr>'                                          , bufopts) -- On Windows | PowerToys > Keyboard Manager
    map.set('i', '<C-BS>'            , '<esc><right>"_dbi'                                       , bufopts) -- ESC because last char (for now)
    map.set('i', '<C-h>'             , '<esc><right>"_dbi'                                       , bufopts)
    map.set('i', '<C-j>'             , '<esc>:ToggleTerm direction=horizontal<cr>'               , bufopts)
    map.set('i', '<C-d>'             , '<esc><right>:call vm#commands#ctrln(1)<cr>'              , bufopts)
    map.set('i', '<F4>'              , '<C-o>"_dd'                                               , bufopts) -- On Windows Only?
    map.set('i', '<C-S-k>'           , '<C-o>"_dd'                                               , bufopts)
    map.set('i', '<A-m>'             , '<C-o>:call toggle_strict_mode()<cr>'                              )
    map.set('n', '<A-m>'             , ':call toggle_strict_mode()<cr>'                                   )
    map.set('i', '<C-g>'             , '<C-o>:call go_to_relative_line()<left>'                           )
    map.set('i', '<F12>'             , vim.lsp.buf.definition                                    , bufopts) -- Go to definition
    -- May i make <C-a> to select all in the block and <C-S-a> to select ALL?
    -- map.set('i', '<C-w>'       , '<ESC>:tabclose<cr>i'                                     ) -- Go to definition | hmm...

    -- MOUSE
    map.set('v', '<RightMouse>'      , 'yi'                                               , bufopts)
    map.set('i', '<RightMouse>'      , '<C-o>p'                                           , bufopts)
    map.set('i', '<ScrollWheelUp>'   , '<C-o>4<C-Y>'                                      , bufopts) -- MAYBE only for termux if indeed issue with <C-x>
    map.set('i', '<ScrollWheelDown>' , '<C-o>4<C-E>'                                      , bufopts) -- MAYBE only for termux if indeed issue with <C-x>
    map.set('i', '<C-LeftMouse>'     , '<LeftMouse><C-o>:lua vim.lsp.buf.definition()<CR>', bufopts) -- Go to definition
    map.set('n', '<C-LeftMouse>'     , '<LeftMouse>:lua vim.lsp.buf.definition()<CR>'     , bufopts) -- Go to definition
    --TODO: Add vertical scroll

    -- ADD ctrl+x on v mode
    -- Sto else vale variable to <CR> giati alla commands mporei na to kanoun overide
    vim.api.nvim_command("cnoremap <expr> <CR> (getcmdtype() ==# ':' && getcmdline() =~# '^call go_to_relative_line') ? '<CR><C-o>^' : '<CR>'") -- https://noahfrederick.com/log/vim-streamlining-grep
    --vim.keymap.set('n', '<C-r>'     , 'i') -- because of some issue when at the end of change list
    -- maybe use bacspace as dd on visual
    -- -- About Search
    vim.keymap.set('i', '<C-f>'    , '<esc>:let mode=1<cr>/')
    vim.keymap.set('n', '<esc>'    , ':noh<cr>') -- https://vi.stackexchange.com/a/28063/42370

    --vim.api.nvim_command("cnoremap <expr> <ESC> (getcmdtype() ==# '/' && mode == 1) ? '<ESC>:let mode=0<cr>:noh<cr>i' : '<ESC>'")
    --vim.api.nvim_command("cnoremap <expr> <CR> (getcmdtype() ==# '/' && mode == 1) ? '<CR>:let mode=0<cr>i' : '<CR>'")

    --vim.api.nvim_command("let mode=2")
    --vim.api.nvim_command("inoremap <expr> <CR> mode == 2 ? 'n' : '<CR>'")

    --vim.keymap.set('i', '<CR>' , 'N')
    -- -- Navigate\jump back fotrh change list
    vim.keymap.set('i', '<A-left>' , '<C-o>g;') -- Going pass the changelist "overwrites" it?
    vim.keymap.set('i', '<A-right>', '<C-o>g,') -- Going pass the changelist "overwrites" it?
    vim.keymap.set('n', '<A-left>' , 'g;'     )
    vim.keymap.set('n', '<A-right>', 'g,'     )
    --vim.api.nvim_command("cnoremap <ESC> <ESC>:noh<cr>i")
    --vim.api.nvim_command("cnoremap <expr> <tab> getcmdtype() =~ '^[colorscheme ?]$' ? '<ESC>:noh<cr>i' : '<tab>'")
    --vim.api.nvim_command("cnoremap <expr> jk getcmdtype() =~ '^[/?]$' ? '<CR>' : 'jk'")
    --vim.keymap.set('n', '<A-left>' , ''  )
    --vim.keymap.set('n', '<A-right>', ''  )
    -- -- smarthome
    map.set('n', "<Home>"   , ":call smarthome#SmartHome('n')<cr>"             , bufopts)
    map.set('n', "<End>"    , ":call smarthome#SmartEnd('n')<cr>"              , bufopts)
    map.set('i', "<Home>"   , "<C-r>=smarthome#SmartHome('i')<cr>"             , bufopts) -- I guess? https://stackoverflow.com/a/10863134/11465149
    map.set('i', "<End>"    , "<C-r>=smarthome#SmartEnd('i')<cr>"              , bufopts)
    map.set('v', "<Home>"   , "<ESC>i<C-r>=smarthome#SmartHome('i')<cr>"       , bufopts)
    map.set('v', "<End>"    , "<ESC>i<C-r>=smarthome#SmartEnd('i')<cr>"        , bufopts)
    map.set('v', "<S-Home>" , "<Esc>:call smarthome#SmartHome('v')<cr>"        , bufopts)
    map.set('v', "<S-End>"  , "<Esc>:call smarthome#SmartEnd('v')<cr>"         , bufopts)
    map.set('i', '<S-End>'  , "<C-o>v:call smarthome#SmartEnd('v')<cr>"        , bufopts)
    map.set('i', '<S-Home>' , "<left><C-o>v:call smarthome#SmartHome('v')<cr>" , bufopts)

    vim.api.nvim_create_augroup("packer_conf" , { clear = true }) -- Set autocommands
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc    = "Sync packer after modifying plugins.lua",
      group   = "packer_conf"                            ,
      pattern = "plugins.lua"                            ,
      command = "source <afile> | PackerSync"            ,
    })

    -- vim.filetype.add { -- Set up custom filetypes
    --   extension    = { foo                   = "fooscript", },
    --   filename     = { ["Foofile"]           = "fooscript", },
    --   pattern      = { ["~/%.config/foo/.*"] = "fooscript", },
    -- }
  end,
}

return config



--[[
  =====================================================================
                            TODO STUFF
  =====================================================================
  TODO: create cursor shortcut to save cursor position
  use https://neovim.io/doc/user/api.html#nvim_buf_add_highlight() ?
  https://vi.stackexchange.com/questions/22577/how-to-ident-the-cursor-to-the-indentation-of-the-above-line?noredirect=1&lq=1
  https://github.com/folke/which-key.nvim/issues/115
  https://github.com/folke/which-key.nvim/pull/278


  =====================================================================
                           Random STUFF
  =====================================================================
  https://github.com/neovim/neovim/issues/8139
  vim.api.nvim_command('SessionManager! load_current_dir_session')
  https://vim-use.narkive.com/2k4cOVT2/getting-the-insert-mode-cursor-position-in-vim-script
  C:/Users/gxous/AppData/Local/nvim-data/
  C:\Users\gxous\.config\nvim


  =====================================================================
                           Keymap Tests
  =====================================================================

]]--

