{ pkgs, config, ... }: {
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

    extraPackages = with pkgs; [ xclip lua-language-server rnix-lsp ripgrep ];

    plugins = with pkgs.vimPlugins; [
      playground
      tokyonight-nvim
      vim-be-good

      # TODO: migrate to harpoon2 branch
      harpoon
      plenary-nvim # harpoon2 dependency

      # LSP from NeoVim
      mason-nvim
      mason-lspconfig-nvim

      # LSP Support
      nvim-lspconfig

      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      luasnip

      # Other 
      cmp-buffer
      cmp-path
      cmp_luasnip
      cmp-nvim-lua
      friendly-snippets

      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      {
        plugin = undotree;
        config = toLuaFile ./plugins/undotree.lua;
      }
      {
        plugin = fugitive;
        config = toLuaFile ./plugins/fugitive.lua;
      }
      {
        plugin = lsp-zero-nvim;
        config = toLuaFile ./plugins/lsp.lua;
      }
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-vimdoc
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-typescript
          p.tree-sitter-javascript
          p.tree-sitter-rust
          p.tree-sitter-c
        ]));
        config = toLuaFile ./plugins/treesitter.lua;
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./init.lua}
      ${builtins.readFile ./remap.lua}   
      ${builtins.readFile ./set.lua}  
      ${builtins.readFile ./plugins/colors.lua}  
      ${builtins.readFile ./plugins/telescope.lua}  
      ${builtins.readFile ./plugins/harpoon.lua}  
      ${builtins.readFile ./plugins/fugitive.lua}  
      ${builtins.readFile ./plugins/undotree.lua}  
    '';
  };
}
