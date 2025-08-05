# IdeaVim Keymaps & Shortcuts Reference

This document contains all the keymaps and shortcuts configured in your `.ideavimrc` file with examples and explanations.

## Table of Contents
- [Basic Settings](#basic-settings)
- [Leader Key](#leader-key)
- [Plugins](#plugins)
- [Navigation](#navigation)
- [Text Editing](#text-editing)
- [Window & Buffer Management](#window--buffer-management)
- [Search & Find](#search--find)
- [Git Version Control](#git-version-control)
- [Code Actions](#code-actions)
- [Refactoring](#refactoring)
- [Running & Debugging](#running--debugging)
- [Testing](#testing)
- [Tool Windows](#tool-windows)
- [File Operations](#file-operations)
- [Bookmarks](#bookmarks)
- [Code Generation](#code-generation)
- [Documentation & Help](#documentation--help)
- [Advanced Features](#advanced-features)
- [Custom Text Objects](#custom-text-objects)
- [Productivity Tips](#productivity-tips)

---

## Basic Settings

### General Settings
- **Scroll offset**: `set scrolloff=5` - Keep 5 lines visible around cursor
- **Incremental search**: `set incsearch` - Search as you type
- **Case-insensitive search**: `set ignorecase` with `set smartcase`
- **Line numbers**: `set number` and `set relativenumber`
- **System clipboard**: `set clipboard=unnamedplus`
- **Undo levels**: `set undolevels=1000`

---

## Leader Key

**Leader Key**: `<Space>` (spacebar)

All shortcuts starting with `<leader>` use the spacebar as the prefix.

---

## Plugins

The following Vim plugins are enabled:

1. **vim-highlightedyank** - Highlights yanked text
2. **vim-commentary** - Easy commenting
3. **nerdtree** - File explorer
4. **vim-surround** - Surround text with quotes, brackets, etc.
5. **vim-multiple-cursors** - Multiple cursor support
6. **vim-easymotion** - Quick navigation
7. **vim-which-key** - Shows available key combinations
8. **vim-sneak** - Two-character search
9. **vim-exchange** - Exchange text objects
10. **ReplaceWithRegister** - Replace with register content
11. **vim-indent-object** - Text objects for indentation
12. **argtextobj.vim** - Text objects for function arguments
13. **vim-textobj-entire** - Text objects for entire buffer

---

## Navigation

### Basic Movement
| Keymap | Action | Example |
|--------|--------|---------|
| `j` | Move down by visual line | Navigate wrapped lines naturally |
| `k` | Move up by visual line | Navigate wrapped lines naturally |
| `Y` | Yank to end of line | Like `D` and `C` behavior |
| `<Home>` | Go to first non-blank character | Smart home key |

### Screen Navigation
| Keymap | Action | Example |
|--------|--------|---------|
| `n` | Next search result (centered) | Find next match and center screen |
| `N` | Previous search result (centered) | Find previous match and center screen |
| `*` | Search word under cursor (centered) | Quick search current word |
| `#` | Search word under cursor backward (centered) | Quick search current word backward |

### Method/Class Navigation
| Keymap | Action | Example |
|--------|--------|---------|
| `[[` | Go to previous method | Navigate between methods |
| `]]` | Go to next method | Navigate between methods |
| `]m` | Go to next method | Alternative method navigation |
| `[m` | Go to previous method | Alternative method navigation |

### Error Navigation
| Keymap | Action | Example |
|--------|--------|---------|
| `]d` | Go to next error | Jump to next compilation error |
| `[d` | Go to previous error | Jump to previous compilation error |
| `]w` | Go to next warning | Jump to next warning |
| `[w` | Go to previous warning | Jump to previous warning |
| `]e` | Go to next error (legacy) | Alternative error navigation |
| `[e` | Go to previous error (legacy) | Alternative error navigation |
| `]c` | Go to next change | Navigate VCS changes |
| `[c` | Go to previous change | Navigate VCS changes |

---

## Text Editing

### Basic Editing
| Keymap | Action | Example |
|--------|--------|---------|
| `<Esc>` | Clear search highlighting | Remove search highlights |
| `Q` | Replay last macro | Quick macro execution |
| `<CR>` | Insert line below | Add new line in normal mode |
| `<S-CR>` | Insert line above | Add new line above in normal mode |

### Text Manipulation
| Keymap | Action | Example |
|--------|--------|---------|
| `gJ` | Join lines without space | Join lines: "Hello\nWorld" → "HelloWorld" |
| `J` | Join lines with space | Join lines: "Hello\nWorld" → "Hello World" |
| `<leader>U` | Uppercase word | Change "hello" to "HELLO" |
| `<leader>u` | Lowercase word | Change "HELLO" to "hello" |
| `<leader>~` | Toggle case of word | Change "Hello" to "hELLO" |
| `+` | Increment number | Change 5 to 6 |
| `-` | Decrement number | Change 5 to 4 |

### Line Operations
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>y` | Duplicate line/selection | Copy current line below |
| `J` (visual) | Move selection down | Move selected lines down |
| `K` (visual) | Move selection up | Move selected lines up |

### Indentation
| Keymap | Action | Example |
|--------|--------|---------|
| `<` (visual) | Decrease indent (keep selection) | Unindent and stay selected |
| `>` (visual) | Increase indent (keep selection) | Indent and stay selected |

### Paragraph Formatting
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>fp` | Format paragraph | Reformat current paragraph |
| `<leader>fp` (visual) | Format selection | Reformat selected text |

### Quick Text Selection
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>vw` | Select word | Quick word selection |
| `<leader>vp` | Select paragraph | Quick paragraph selection |
| `<leader>vb` | Select inside brackets | Select content in () |
| `<leader>vB` | Select inside braces | Select content in {} |
| `<leader>a` | Select all text | Select entire document |

### Character Jumps
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>;` | Jump to next semicolon | Find ; character |
| `<leader>,` | Jump to next comma | Find , character |
| `<leader>.` | Jump to next period | Find . character |

### Advanced Clipboard
| Keymap | Action | Example |
|--------|--------|---------|
| `p` (visual) | Paste without losing register | Paste over selection, keep original |

---

## Window & Buffer Management

### Window Navigation
| Keymap | Action | Example |
|--------|--------|---------|
| `<C-h>` | Move to left window | Focus left split |
| `<C-j>` | Move to bottom window | Focus bottom split |
| `<C-k>` | Move to top window | Focus top split |
| `<C-l>` | Move to right window | Focus right split |
| `<leader>h` | Move to left window (alt) | Alternative left navigation |
| `<leader>j` | Move to bottom window (alt) | Alternative bottom navigation |
| `<leader>k` | Move to top window (alt) | Alternative top navigation |
| `<leader>l` | Move to right window (alt) | Alternative right navigation |

### Window Resizing
| Keymap | Action | Example |
|--------|--------|---------|
| `<C-Up>` | Increase window height | Make window taller |
| `<C-Down>` | Decrease window height | Make window shorter |
| `<C-Left>` | Decrease window width | Make window narrower |
| `<C-Right>` | Increase window width | Make window wider |

### Split Management
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>vs` | Vertical split | Split window vertically |
| `<leader>hs` | Horizontal split | Split window horizontally |
| `<leader>sv` | Split vertically (IDE action) | IntelliJ vertical split |
| `<leader>sh` | Split horizontally (IDE action) | IntelliJ horizontal split |
| `<leader>su` | Unsplit | Close split |
| `<leader>sm` | Move to opposite tab group | Move editor to other side |

### Tab Navigation
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>tn` | Next tab | Switch to next editor tab |
| `<leader>tp` | Previous tab | Switch to previous editor tab |
| `<leader>tc` | New tab | Create new editor tab |
| `<leader>x` | Close current tab | Close current editor |
| `<leader>X` | Close all tabs | Close all editors |
| `<leader>u` | Reopen closed tab | Undo tab close |

### Quick Save/Quit
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>w` | Save file | Quick save |
| `<leader>q` | Quit | Quick quit |
| `<leader>wq` | Save and quit | Save then quit |

---

## Search & Find

### File Navigation
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>ff` | Go to file | Quick file search |
| `<leader>fs` | Find in path | Search text in project |
| `<leader>fu` | Find usages | Find where symbol is used |
| `<leader>/` | Search everywhere | Global search |
| `<leader>sa` | Go to action | Search IDE actions |
| `<leader>se` | Search everywhere (alt) | Alternative global search |

### Recent Files
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>rf` | Recent files | Show recently opened files |
| `<leader>rl` | Recent locations | Show recent cursor locations |

### File Structure
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>o` | File structure popup | Show file outline |

### Code Navigation
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>su` | Show usages | Display all usages of symbol |
| `<leader>si` | Show implementations | Show interface implementations |
| `<leader>st` | Go to type declaration | Jump to type definition |
| `<leader>ss` | Go to symbol | Search for symbols |
| `<leader>sc` | Go to class | Search for classes |
| `<leader>g` | Go to declaration | Jump to definition |
| `<leader>t` | Go to test | Jump to corresponding test |
| `<leader>s` | Go to related | Switch header/source (C/C++) |

---

## Git Version Control

### Basic Git Operations
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>gb` | Git branches | Show/switch branches |
| `<leader>gc` | Commit changes | Commit dialog |
| `<leader>gp` | Push | Push to remote |
| `<leader>gu` | Update/Pull | Pull from remote |
| `<leader>ga` | Git add | Stage changes |
| `<leader>gf` | Git fetch | Fetch from remote |

### Git History & Comparison
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>gh` | File history | Show file git history |
| `<leader>gd` | Compare with same version | Diff current file |
| `<leader>gr` | Rollback changes | Undo local changes |
| `<leader>gs` | Show local changes | View unstaged changes |
| `<leader>gl` | Show git log | Display commit history |
| `<leader>gb` | Git blame/annotate | Show line-by-line blame |

---

## Code Actions

### Basic Code Actions
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>r` | Reformat code | Auto-format current file |
| `<leader>o` | Optimize imports | Remove unused imports |
| `<leader>i` | Generate | Open generate menu |
| `<leader>e` | Show error description | Display error details |
| `<leader>rn` | Rename element | Rename variable/class/method |

### Intentions & Quick Fixes
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>ai` | Show intentions | Display available intentions |
| `<leader>ae` | Show error description | Show error details |
| `<leader>aq` | Show quick fixes | Display quick fix options |

### Code Analysis
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>ci` | Inspect code | Run code inspection |
| `<leader>ch` | Highlight usages | Highlight symbol usages |
| `<leader>cp` | View offline inspection | Show inspection results |
| `<leader>h` | Highlight symbol | Highlight current symbol |

### Code Folding
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>zo` | Expand region | Unfold code |
| `<leader>zc` | Collapse region | Fold code |
| `<leader>za` | Toggle fold | Toggle code folding |

---

## Refactoring

### Extract Refactoring
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>ri` | Inline | Inline variable/method |
| `<leader>rv` | Extract variable | Extract expression to variable |
| `<leader>rm` | Extract method | Extract code to method |
| `<leader>rc` | Extract constant | Extract value to constant |
| `<leader>rp` | Extract parameter | Extract to method parameter |
| `<leader>rf` | Extract field | Extract to class field |

---

## Running & Debugging

### Build & Run
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>cc` | Compile | Compile current file |
| `<leader>cr` | Run | Run current configuration |
| `<leader>cd` | Debug | Debug current configuration |
| `<leader>cs` | Stop | Stop running process |

### Breakpoints
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>b` | Toggle breakpoint | Add/remove breakpoint |
| `<leader>cb` | Toggle breakpoint (alt) | Alternative breakpoint toggle |
| `<leader>cB` | Toggle temp breakpoint | Temporary breakpoint |
| `<leader>d` | Debug | Start debugging |

---

## Testing

### Test Execution
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>tr` | Run test class | Run all tests in class |
| `<leader>td` | Debug test class | Debug tests in class |
| `<leader>tf` | Rerun failed tests | Re-run only failed tests |
| `<leader>ta` | Run all tests | Execute entire test suite |

---

## Tool Windows

### Number Keys (Tool Windows)
| Keymap | Action | Tool Window |
|--------|--------|-------------|
| `<leader>1` | Project | Project explorer |
| `<leader>2` | Bookmarks | Bookmarks panel |
| `<leader>3` | Find | Find results |
| `<leader>4` | Run | Run tool window |
| `<leader>5` | Debug | Debug tool window |
| `<leader>6` | Problems | Problems/errors panel |
| `<leader>7` | Structure | File structure |
| `<leader>8` | Services | Services panel |
| `<leader>9` | Version Control | Git/VCS panel |
| `<leader>0` | Terminal | Integrated terminal |

### Special Tool Windows
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>db` | Database | Database tool window |
| `<leader>th` | Terminal | Activate terminal |
| `<leader>ts` | Open in terminal | Open current location in terminal |

### NERDTree (File Explorer)
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>n` | Toggle NERDTree | Show/hide file explorer |
| `<leader>f` | Focus NERDTree | Switch focus to file explorer |

---

## File Operations

### File Management
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>fn` | New file | Create new file |
| `<leader>fd` | New directory | Create new folder |
| `<leader>fc` | Copy element | Copy file/directory |
| `<leader>fm` | Move | Move/rename file |
| `<leader>fr` | Rename element | Rename file/directory |
| `<leader>fx` | Safe delete | Delete with safety check |

### Copy Paths
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>cp` | Copy file path | Copy absolute file path |
| `<leader>cn` | Copy reference | Copy qualified name |

### Scratch Files
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>ns` | New scratch file | Create temporary file |

---

## Bookmarks

### Bookmark Operations
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>mm` | Toggle bookmark | Add/remove bookmark |
| `<leader>ml` | List bookmarks | Show all bookmarks |
| `<leader>mn` | Next bookmark | Go to next bookmark |
| `<leader>mp` | Previous bookmark | Go to previous bookmark |

---

## Code Generation

### Method Generation
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>ic` | Implement methods | Implement interface methods |
| `<leader>io` | Override methods | Override parent methods |
| `<leader>ig` | Generate getter | Create getter method |
| `<leader>is` | Generate setter | Create setter method |
| `<leader>igs` | Generate getter/setter | Create both getter and setter |
| `<leader>ie` | Generate equals | Generate equals method |
| `<leader>ih` | Generate hashCode/equals | Generate both methods |
| `<leader>it` | Generate test method | Create test method |

### Templates
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>lt` | Live templates | Insert code template |
| `<C-.>` | Expand template | Trigger postfix completion |

---

## Documentation & Help

### Quick Documentation
| Keymap | Action | Example |
|--------|--------|---------|
| `K` | Quick documentation | Show docs for symbol under cursor |
| `<leader>hd` | Quick documentation (alt) | Alternative doc display |
| `<leader>hp` | Parameter info | Show method parameters |
| `<leader>ht` | Type info | Show type information |
| `<leader>he` | Error description | Show error details |

---

## Advanced Features

### Multiple Selections
| Keymap | Action | Example |
|--------|--------|---------|
| `<A-j>` | Select next occurrence | Add cursor to next match |
| `<A-k>` | Unselect previous | Remove previous cursor |
| `<A-S-j>` | Select all occurrences | Select all matches |
| `<C-n>` | Add cursor to next | Multiple cursor (plugin) |
| `<C-p>` | Remove current cursor | Multiple cursor (plugin) |
| `<C-x>` | Skip and go to next | Multiple cursor (plugin) |

### EasyMotion
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader><leader>w` | Jump to word | Quick word navigation |
| `<leader><leader>b` | Jump to word backward | Backward word navigation |
| `<leader><leader>f` | Jump to character | Character navigation |
| `<leader><leader>j` | Jump to line below | Line navigation down |
| `<leader><leader>k` | Jump to line above | Line navigation up |
| `<leader><leader>s` | Two-character search | Search with 2 chars |

### Sneak Navigation
| Keys | Action | Example |
|------|--------|---------|
| `s{char}{char}` | Sneak forward | Type 's' then 2 characters |
| `S{char}{char}` | Sneak backward | Type 'S' then 2 characters |

### Structural Search & Replace
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>sr` | Structural search | Advanced pattern search |
| `<leader>sR` | Structural replace | Advanced pattern replace |

### Distraction-Free Modes
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>df` | Distraction-free mode | Hide all UI panels |
| `<leader>dz` | Zen mode | Minimalist editing mode |
| `<leader>dp` | Presentation mode | Full-screen presentation |
| `<leader>zf` | Toggle full screen | Enter/exit full screen |
| `<leader>zm` | Hide all windows | Hide all tool windows |

### Development Tools
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>pp` | Performance profiler | Start profiling |
| `<leader>mc` | Maven reimport | Refresh Maven project |
| `<leader>mg` | Gradle refresh | Refresh Gradle project |
| `<leader>hr` | REST client | HTTP requests |
| `<leader>et` | External tools | Run external tools |

### Database Operations
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>dq` | Execute query | Run database query |
| `<leader>ds` | Open DDL console | Database schema operations |

### Quick Lists
| Keymap | Action | Example |
|--------|--------|---------|
| `<leader>qo` | Recently opened | Quick access to opened files |
| `<leader>qr` | Recent files | Quick access to recent files |
| `<leader>qc` | Change scheme | Quick scheme switching |

### Smart Completion
| Keymap | Action | Example |
|--------|--------|---------|
| `<C-Space>` | Code completion | Basic autocomplete |
| `<C-S-Space>` | Smart completion | Type-aware completion |

---

## Custom Text Objects

### Plugin Text Objects
| Text Object | Description | Example Usage |
|-------------|-------------|---------------|
| `ii` / `ai` | Indentation levels | `dii` - delete indented block |
| `ia` / `aa` | Function arguments | `cia` - change function argument |
| `ie` / `ae` | Entire buffer | `yae` - yank entire file |
| `ig` / `ag` | Entire buffer (custom) | `vig` - select entire file |

### Surround Plugin
| Command | Action | Example |
|---------|--------|---------|
| `cs"'` | Change " to ' | "hello" → 'hello' |
| `cs'<q>` | Change ' to <q> | 'hello' → \<q>hello\</q> |
| `ds"` | Delete " | "hello" → hello |
| `ysiw"` | Surround word with " | hello → "hello" |
| `yss)` | Surround line with () | hello → (hello) |

### Commentary Plugin
| Command | Action | Example |
|---------|--------|---------|
| `gcc` | Comment/uncomment line | Toggle line comment |
| `gc{motion}` | Comment motion | `gcap` - comment paragraph |
| `gc` (visual) | Comment selection | Comment selected text |

### Exchange Plugin
| Command | Action | Example |
|---------|--------|---------|
| `cx{motion}` | Mark for exchange | `cxiw` - mark word for exchange |
| `cx{motion}` | Exchange with marked | Exchange two text objects |
| `cxx` | Exchange current line | Mark/exchange entire line |

### ReplaceWithRegister
| Command | Action | Example |
|---------|--------|---------|
| `gr{motion}` | Replace with register | `griw` - replace word with register |
| `grr` | Replace entire line | Replace line with register content |

---

## Productivity Tips

### Macro Usage
1. **Record**: `qq` - Start recording macro in register 'q'
2. **Stop**: `q` - Stop recording
3. **Replay**: `@q` - Execute macro from register 'q'
4. **Repeat**: `@@` - Repeat last executed macro (mapped to `Q`)

### Visual Block Mode
1. **Enter**: `<C-v>` - Start visual block mode
2. **Multi-line insert**: `I` - Insert at beginning of each line
3. **Multi-line append**: `A` - Append at end of each line
4. **Multi-line change**: `c` - Change selected block

### Text Objects Examples
- `ciw` - Change inner word
- `ci"` - Change inside quotes
- `ci(` - Change inside parentheses
- `ci{` - Change inside braces
- `cit` - Change inside XML/HTML tags
- `cap` - Change around paragraph
- `cas` - Change around sentence

### Search Patterns
- `/pattern` - Search forward
- `?pattern` - Search backward
- `*` - Search word under cursor forward
- `#` - Search word under cursor backward
- `:noh` - Clear search highlighting (or press `<Esc>`)

### Quick File Navigation
1. Use `<leader>ff` to quickly open files
2. Use `<leader>rf` for recently opened files
3. Use `<leader>o` to navigate file structure
4. Use `<leader>/` for global search

### Efficient Editing Workflow
1. **Navigation**: Use EasyMotion (`<leader><leader>`) for quick jumps
2. **Selection**: Use text objects for precise selections
3. **Editing**: Use surround plugin for quote/bracket operations
4. **Multiple cursors**: Use `<A-j>` for multiple selections
5. **Refactoring**: Use extract operations (`<leader>r*`)

---

## Language-Specific Extensions

### Commented Templates (Uncomment to Use)
```vim
" Python
autocmd FileType python map <leader>pr :!python %<CR>

" JavaScript/Node
autocmd FileType javascript map <leader>jr :!node %<CR>

" Java
autocmd FileType java map <leader>jc <Action>(CompileFile)
```

---

## Custom Commands Reference

| Command | Action | Note |
|---------|--------|------|
| `:so %` | Reload vimrc | IdeaVim reloads automatically |
| `:noh` | Clear search highlight | Mapped to `<Esc>` |
| `:set paste` | Enter paste mode | clipboard=unnamedplus handles this |

---

*This reference covers all keymaps in your `.ideavimrc` configuration. Use `<leader>` (spacebar) followed by any key to see available options with the which-key plugin.*
