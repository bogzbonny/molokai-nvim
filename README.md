# molokai-nvim

A Lua port of the classic [molokai](https://github.com/tomasr/molokai)
colorscheme for Neovim, originally based on the Monokai theme for TextMate by
Wimer Hazenberg and its darker variant by Hamish Stuart Macpherson.

Supports Treesitter, LSP diagnostics, semantic tokens, and popular plugins
out of the box.

## Requirements

- Neovim >= 0.9.0
- A terminal with true color (24-bit) support

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "jakubkarlicek/molokai-nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("molokai-nvim").setup()
    vim.cmd.colorscheme("molokai-nvim")
  end,
}
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  "jakubkarlicek/molokai-nvim",
  config = function()
    require("molokai-nvim").setup()
    vim.cmd.colorscheme("molokai-nvim")
  end,
}
```

### [mini.deps](https://github.com/echasnovski/mini.deps)

```lua
MiniDeps.add("jakubkarlicek/molokai-nvim")
require("molokai-nvim").setup()
vim.cmd.colorscheme("molokai-nvim")
```

## Usage

Call `setup()` before loading the colorscheme:

```lua
require("molokai-nvim").setup({
  -- your options here
})
vim.cmd.colorscheme("molokai-nvim")
```

Or use the defaults with no arguments:

```lua
require("molokai-nvim").setup()
vim.cmd.colorscheme("molokai-nvim")
```

## Configuration

These are the default values. All fields are optional.

```lua
require("molokai-nvim").setup({
  italic = true,        -- enable italic styling globally
  bg = "dark",          -- "dark" (#1B1D1E) or "alt" (#272822, original Monokai bg)
  styles = {
    comments  = {},     -- e.g. { italic = true }
    keywords  = {},     -- e.g. { bold = true, italic = false }
    functions = {},
    variables = {},
    types     = {},     -- e.g. { italic = true }
  },
  on_colors = function(colors)
    -- Override palette colors before highlights are computed
    -- colors.bg = "#000000"
  end,
  on_highlights = function(hl, colors)
    -- Override specific highlight groups
    -- hl.Normal = { fg = colors.white, bg = "#000000" }
  end,
})
```

### Options

| Option    | Type     | Default  | Description                                                |
| --------- | -------- | -------- | ---------------------------------------------------------- |
| `italic`  | boolean  | `true`   | Enable italic styling for comments, keywords, types, etc.  |
| `bg`      | string   | `"dark"` | Background variant: `"dark"` or `"alt"` (original Monokai) |
| `styles`  | table    | `{}`     | Per-group style overrides (see below)                      |

### Style overrides

The `styles` table lets you override the styling for specific syntax groups.
Each entry accepts any valid `nvim_set_hl` attributes (e.g. `italic`, `bold`,
`underline`). An empty table `{}` uses the theme defaults.

```lua
styles = {
  comments  = { italic = true },
  keywords  = { bold = true },
  functions = {},              -- uses theme default
  variables = {},
  types     = { italic = true },
}
```

### Hooks

**`on_colors(colors)`** is called after the palette is loaded but before
highlights are computed. Use it to tweak individual palette colors:

```lua
on_colors = function(colors)
  colors.pink = "#FF6188"
  colors.bg = "#000000"
end
```

**`on_highlights(hl, colors)`** is called after all highlight groups are
built. Use it to override or add specific groups:

```lua
on_highlights = function(hl, colors)
  hl.CursorLine = { bg = "#1a1a2e" }
  hl.TelescopeBorder = { fg = colors.cyan }
end
```

## Accessing colors

You can access the theme colors for use in other plugins:

```lua
-- Raw palette
local palette = require("molokai-nvim").palette()

-- Resolved colors (respects the bg config option)
local colors = require("molokai-nvim").colors()
```

## Lualine

molokai-nvim includes a lualine theme that is automatically discovered when
you set `theme = "auto"` in your lualine config:

```lua
require("lualine").setup({
  options = {
    theme = "auto",
  },
})
```

You can also set it explicitly:

```lua
require("lualine").setup({
  options = {
    theme = "molokai-nvim",
  },
})
```

## Supported plugins

The following plugins have highlight groups defined out of the box:

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (full highlight + semantic token support)
- [LSP diagnostics](https://neovim.io/doc/user/diagnostic.html) (signs, virtual text, underlines)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [blink.cmp](https://github.com/Saghen/blink.cmp)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

## Credits

- [Tomas Restrepo](https://github.com/tomasr) -- original
  [molokai.vim](https://github.com/tomasr/molokai) colorscheme
- [Wimer Hazenberg](https://monokai.pro) -- Monokai theme for TextMate
- Hamish Stuart Macpherson -- darker Monokai variant

## License

[MIT](LICENSE)
