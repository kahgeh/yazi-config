# Migration from lf to Yazi

## Existing lf Features Summary

### Core Configuration (`lfrc`)

| Feature | Description | Keybinding |
|---------|-------------|------------|
| **Preview system** | Custom previewer with timg (images), bat (text), pdftotext (PDFs), mediainfo (videos) | automatic |
| **Archive extraction** | tar.bz/gz/xz, zip, rar, 7z | `extract` cmd |
| **Zip creation** | Create zip from selection | `zip` cmd |
| **Yank relative path** | Copy git-relative path to clipboard | `Yr` |
| **Yank absolute path** | Copy full path to clipboard | `Ya` |
| **Yank filename** | Copy filename to clipboard | `Yn` |
| **Yank content** | Copy file contents to clipboard | `Yc` |
| **Yank browser path** | Copy file:// URL to clipboard | `Yb` |
| **Trash** | Move to trash (macOS trash) | `Dr` |
| **Permanent delete** | rm -rf | `Dd` |
| **Create directory** | mkdir prompt | `A` |
| **Create file** | touch prompt | `a` |
| **Open with VSCode** | Open file in VSCode | `oc` |
| **Default open** | Open with system default | `od` |
| **Open tmux session** | Launch tmux-sessionizer on folder | `<enter>` |
| **FZF jump** | Find and jump to location | `gs` |
| **FZF search in file** | ripgrep + fzf search | `gS` |
| **Go to repo root** | Navigate to git root | `gr` |
| **Quick navigation** | Downloads, Documents, Dev/p, Dev/xn, ~/.config, ~ | `gd`, `gf`, `gp`, `gx`, `gc`, `gh` |
| **Toggle order** | Reverse sort order | `To` |
| **Sort by time** | Sort files by time | `st` |
| **Toggle hidden** | Show/hide hidden files | `.` |

### One-Column Mode (`onecol`) - Neovim Integration

| Feature | Description | Keybinding |
|---------|-------------|------------|
| **Attach to editor** | Register lf client with nvim via tmux | `Re` / auto on start |
| **Send to editor** | Open file in nvim pane | `o` |
| **Maximise/Minimise** | Resize tmux panes | `.` / `,` |
| **on-select** | Show eza file stats in status | automatic |
| **No preview mode** | Single column layout | automatic |

### Tmux Integration (`tmux_mgt.zsh`)

| Feature | Description | Function |
|---------|-------------|----------|
| **mh** | Split layout with lf in file manager pane | `mh` |
| **ms** | Dev layout: nvim + lf + lazygit + shell | `ms` |
| **ml** | ML layout with multiple panes | `ml` |
| **sdev** | Name panes and start nvim/lf/lazygit | internal |
| **lfx** | Maximise lf pane | `lfx` |
| **lfvim** | Launch lf in onecol mode | `lfvim` |

### Neovim Integration (`keymaps.lua`)

| Feature | Description | Keybinding |
|---------|-------------|------------|
| **LFGoTo** | Jump to current file in lf pane, uses `lf -remote` | `<leader>e` |

### Shell Integration (`.zshrc`)

| Feature | Description |
|---------|-------------|
| **y function** | yazi wrapper with cwd change on exit (already exists!) |
| **lfvim function** | Launch lf with onecol config |

---

## Migration Plan to Yazi

### Phase 1: Install and Basic Setup

1. Install yazi and dependencies:
   ```bash
   brew install yazi ffmpegthumbnailer poppler fd ripgrep fzf zoxide imagemagick
   ```
2. Create `~/.config/yazi/` directory structure
3. Create `yazi.toml` with basic settings

### Phase 2: Migrate Preview System

1. Configure `yazi.toml` with previewers for:
   - Images (built-in with Sixel/Kitty/iTerm2 support)
   - Text files with bat/syntax highlighting
   - PDFs with poppler
   - Videos with ffmpegthumbnailer
2. Yazi has better built-in preview support than lf

### Phase 3: Migrate Keybindings (`keymap.toml`)

1. **Yank operations:**
   - `Yr` → yank relative path
   - `Ya` → yank absolute path
   - `Yn` → yank filename
   - `Yc` → yank content
   - `Yb` → yank browser path

2. **Delete operations:**
   - `Dr` → trash
   - `Dd` → permanent delete

3. **Create operations:**
   - `A` → create directory
   - `a` → create file

4. **Open operations:**
   - `oc` → open with VSCode
   - `od` → default open
   - `<enter>` → tmux-sessionizer

5. **Navigation:**
   - `gs` → fzf jump (can use yazi's built-in `z` for zoxide)
   - `gS` → search in files
   - `gr` → go to repo root
   - `gd`, `gf`, `gp`, `gx`, `gc`, `gh` → bookmarks

6. **Sort/view:**
   - `To` → toggle reverse
   - `st` → sort by time
   - `.` → toggle hidden

### Phase 4: Migrate Neovim Integration

1. Create custom yazi plugin or use `yazi.nvim` plugin
2. Implement equivalent of `LFGoTo` command
3. Configure tmux communication for editor sync

### Phase 5: Migrate Tmux Integration

1. Update `tmux_mgt.zsh`:
   - Replace `lf` with `yazi` in `mh`, `sdev`, `sml` functions
   - Replace `lfvim` with yazi equivalent
2. Update `lfx` function for yazi pane management

### Phase 6: Create Yazi Plugins (if needed)

1. Plugin for tmux pane communication
2. Plugin for custom archive operations

---

## Feature Mapping: lf → Yazi

| lf Feature | Yazi Equivalent | Notes |
|------------|-----------------|-------|
| `set previewer` | Built-in | Yazi has superior previewing |
| `cmd extract` | Built-in plugin | Use `ya pack` or shell command |
| `map Yr` | Custom keymap | Shell command in keymap.toml |
| `map Ya` | `y` (built-in) | Yazi has built-in yank |
| `map Yn` | Custom keymap | Shell command |
| `lf -remote` | `ya emit` | IPC mechanism |
| `$id` (client id) | `$YAZI_ID` | Environment variable |
| `$f` (current file) | `$1` in shell | Or use `ya emit` |
| `$fx` (selected files) | Selected files | Via shell or plugin |

---

## Files to Create

- [ ] `~/.config/yazi/yazi.toml` - Main configuration
- [ ] `~/.config/yazi/keymap.toml` - Keybindings
- [ ] `~/.config/yazi/theme.toml` - Theme (optional)
- [ ] `~/.config/yazi/plugins/` - Custom plugins directory
- [ ] Update `~/.config/zsh/tmux_mgt.zsh` - Replace lf with yazi
- [ ] Update `~/.config/nvim/lua/keymaps.lua` - Replace LFGoTo with YaziGoTo
