# Setup

Create a link in onecol folder to the keymap.toml at the root, which will just reuse existing keymap.

## Plugins

### bookmarks.yazi

Installed via `ya pkg add dedukun/bookmarks`. The plugin has been customized to use only QWERTY home row keys for bookmarks.

**Keybindings** (defined in `keymap.toml`):
| Key | Action |
|-----|--------|
| `m` | Save bookmark - then press a home row key |
| `'` | Jump to bookmark |
| `bd` | Delete a bookmark |
| `bD` | Delete all bookmarks |

**Available bookmark keys**: `a s d f g h j k l ;`

**Customization**: To change the available keys, edit `plugins/bookmarks.yazi/main.lua` and modify the `SUPPORTED_KEYS` table at the top of the file:

```lua
local SUPPORTED_KEYS = {
	{ on = "a", desc = "Free" }, { on = "s", desc = "Free" }, { on = "d", desc = "Free" }, { on = "f", desc = "Free" },
	{ on = "g", desc = "Free" }, { on = "h", desc = "Free" }, { on = "j", desc = "Free" }, { on = "k", desc = "Free" },
	{ on = "l", desc = "Free" }, { on = ";", desc = "Free" },
}
```

**Note**: Running `ya pkg upgrade` will overwrite this customization. Re-apply changes after upgrading.
