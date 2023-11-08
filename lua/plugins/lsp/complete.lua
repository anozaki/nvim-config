local kind_icons = {
  Class = "ﴯ",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Keyword = "",
  Method = "",
  Module = "",
  Operator = "",
  Property = "ﰠ",
  Reference = "",
  Snippet = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  { "SirVer/ultisnips" },
  { "honza/vim-snippets" },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      local select_next = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end

      local select_prev = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end

      local abort_cmp = function(fallback)
        if cmp.visible() then
          cmp.abort()
        else
          fallback()
        end
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) --Concatonate the icons with name of the item-kind
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              spell = "[Spellings]",
              zsh = "[Zsh]",
              buffer = "[Buffer]",
              ultisnips = "[Snip]",
              treesitter = "[Treesitter]",
              calc = "[Calculator]",
              nvim_lua = "[Lua]",
              path = "[Path]",
              nvim_lsp_signature_help = "[Signature]",
              cmdline = "[Vim Command]",
            })[entry.source.name]
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", "s" }),
          ["<c-j>"] = cmp.mapping(select_next, { "i", "c" }),
          ["<c-k>"] = cmp.mapping(select_prev, { "i", "c" }),
          ["<tab>"] = cmp.mapping(select_next, { "i", "s" }),
          ["<s-tab>"] = cmp.mapping(select_prev, { "i", "s" }),
          ["<esc>"] = cmp.mapping(abort_cmp, { "i", "s" }),
          ["<cr>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), { "i", "c", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "vsnip" },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "ultisnips" },
          { name = "nvim_lsp_signature_help" },
          { name = "calc" },
          { name = "spell" },
          { name = "path" },
        }),
      })
      cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    config = true,
  },
  { "hrsh7th/vim-vsnip" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-calc" },
  { "f3fora/cmp-spell" },
  { "tamago324/cmp-zsh" },
  {
    "quangnguyen30192/cmp-nvim-ultisnips",
    config = true,
  },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
}
