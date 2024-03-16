{
  pkgs,
  config,
  ...
}: {
  programs.neovim = let
    toLua = str: ''
      lua << EOF
      ${str}
      EOF
    '';
    toLuaFile = file: ''
      lua << EOF
      ${builtins.readFile file}
      EOF
    '';
  in {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [xclip lua-language-server rnix-lsp ripgrep];

    plugins = with pkgs.vimPlugins; [
      playground
      tokyonight-nvim

      # ThePrimeagen Goodies
      vim-be-good
      nvim-treesitter-context
      harpoon
      refactoring-nvim
      plenary-nvim

      fugitive
      trouble-nvim
      friendly-snippets
      neogen
      neotest
      neotest-plenary
      neotest-vitest
      FixCursorHold-nvim
      fidget-nvim
      telescope-nvim
      undotree
      zen-mode-nvim

      # LSP
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      luasnip
      cmp_luasnip

      {
        plugin =
          nvim-treesitter.withPlugins
          (p: [
            p.tree-sitter-nix
            p.tree-sitter-vim
            p.tree-sitter-vimdoc
            p.tree-sitter-bash
            p.tree-sitter-lua
            p.tree-sitter-typescript
            p.tree-sitter-javascript
            p.tree-sitter-rust
            p.tree-sitter-c
          ]);
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      ${builtins.readFile ./remap.lua}
      ${builtins.readFile ./set.lua}
      ${builtins.readFile ./plugins/lsp.lua}
      ${builtins.readFile ./plugins/treesitter.lua}
      ${builtins.readFile ./plugins/telescope.lua}
      ${builtins.readFile ./plugins/undotree.lua}
      ${builtins.readFile ./plugins/snippets.lua}
      ${builtins.readFile ./plugins/fugitive.lua}
      ${builtins.readFile ./plugins/trouble.lua}
      ${builtins.readFile ./plugins/harpoon.lua}
      ${builtins.readFile ./plugins/zenmode.lua}
      ${builtins.readFile ./plugins/trouble.lua}
      ${builtins.readFile ./plugins/neotest.lua}
      ${builtins.readFile ./plugins/neogen.lua}
      ${builtins.readFile ./plugins/colors.lua}
    '';
  };
}
