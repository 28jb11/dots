-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.cmdheight = 1                      -- more space in the neovim command line for displaying messages
vim.opt.guifont = "Iosevka Nerd Font Mono" -- the font used in graphical neovim applications
-- vim.opt.shiftwidth = 2                     -- the number of spaces inserted for each indentation
-- vim.opt.tabstop = 2                        -- insert 2 spaces for a tab
vim.opt.relativenumber = true -- relative line numbers
vim.opt.wrap = true           -- wrap lines


lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree

lvim.plugins = {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = 6006,
      }

      dap.configurations.gdscript = {
        {
          type = "godot",
          request = "launch",
          port = 6007,
          name = "Launch scene",
          --          project = "${workspaceFolder}",
          launch_scene = true,
        },
      }
    end
  },
  {
    "neovim/nvim-lspconfig",
    require("lspconfig")["gdscript"].setup({
      name = "godot",
      cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
    })
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          close_if_last_window = true,
          width = 30,
        },
        buffers = {
          follow_current_file = true,
        },
        filesystem = {
          follow_current_file = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              "node_modules"
            },
            never_show = {
              ".DS_Store",
              "thumbs.db"
            },
          },
        },
      })
    end
  },
  {
    "habamax/vim-godot",
  },
}
lvim.builtin.which_key.mappings["e"] = {
  "<cmd>NeoTreeFocusToggle<CR>", "explorer"
}

lvim.builtin.cmp.completion = {}
lvim.format_on_save.enabled = true

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.gd" },
  command = "setlocal noexpandtab tabstop=4 shiftwidth=4"
})
