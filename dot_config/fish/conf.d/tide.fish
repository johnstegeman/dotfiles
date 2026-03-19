# Tide prompt configuration
# Mirrors the starship layout with Rose Pine colors
#
# Layout:
#   Line 1 left:  [ os ]  [ pwd ]  [ python ]  [ status ]
#   Line 1 right: [ vcs ]  (jj in jj repos, git otherwise)
#   Line 2:       ❯
#
# Starship modules without a Tide equivalent:
#   - direnv: omitted (no built-in tide item)
#   - fill: not needed — Tide uses left/right prompt split instead
#
# Note: rose-pine-tide.fish (from rose-pine/fish) defines --on-variable handlers
# that fire when config.fish runs 'fish_config theme choose "Rosé Pine"', and
# they overwrite all color vars with their powerline-style palette (dark fg on
# colored bg). We neutralise them by redefining the same-named functions here
# (t > r alphabetically, so our definitions win). Structural vars (items,
# separators, icons) use set -U for persistence; color vars use set -gx so they
# take effect immediately and are not shadowed by any leftover globals.

# --- Rose Pine palette ---
set -l rp_text  e0def4
set -l rp_love  eb6f92
set -l rp_gold  f6c177
set -l rp_pine  31748f
set -l rp_foam  9ccfd8
set -l rp_iris  c4a7e7

# --- Prompt structure ---
# Layout mirrors starship: left has os/pwd/python/status, right has vcs (jj or git)
set -U tide_left_prompt_items  os pwd python status newline character
set -U tide_right_prompt_items vcs

set -U tide_prompt_transient_enabled  true
set -U tide_prompt_add_newline_before true

# --- Separators: plain spaces, no powerline arrows ---
# All items use bg_color=normal so diff-color separator is also just a space
set -U tide_left_prompt_separator_diff_color  ' '
set -U tide_left_prompt_separator_same_color  ' '
set -U tide_right_prompt_separator_diff_color ' '
set -U tide_right_prompt_separator_same_color ' '

# --- OS item ---
# Starship: [$symbol ]($style)  style=fg:text  macOS symbol=  Linux symbol=
# Use printf to encode nerd font code points; literal chars were lost on save.
if test (uname) = Darwin
    set -U tide_os_icon (printf '\uf179')   # U+F179 nerd font Apple icon
else
    set -U tide_os_icon (printf '\uf17c')   # U+F17C nerd font Linux/Tux icon
end
set -gx tide_os_color    $rp_text
set -gx tide_os_bg_color normal

# --- PWD item ---
# Starship: [$path]($style)  style=fg:iris  truncation_length=5  truncate_to_repo=false
# No icon prefix — starship shows the bare path only
set -gx tide_pwd_color_anchors        $rp_iris
set -gx tide_pwd_color_dirs           $rp_iris
set -gx tide_pwd_color_truncated_dirs $rp_iris
set -U  tide_pwd_truncation_length    5
set -U  tide_pwd_icon                 ''   # no folder icon (matches starship bare path)
set -U  tide_pwd_icon_home            ''   # no home icon
set -U  tide_pwd_icon_unwritable      ''
set -gx tide_pwd_bg_color             normal

# --- Python item ---
# Starship: [ $symbol$pyenv_prefix($version)(\($virtualenv\))]($style)  style=pine  symbol=
set -U  tide_python_icon     (printf '\ue235')  # U+E235 nerd font Python icon
set -gx tide_python_color    $rp_pine
set -gx tide_python_bg_color normal

# --- Status item ---
# Starship: not explicitly configured (uses defaults — hidden on success, ✘ on failure)
set -U  tide_status_icon               ''
set -U  tide_status_icon_failure       '✘'
set -gx tide_status_color              $rp_text
set -gx tide_status_color_failure      $rp_love
set -gx tide_status_bg_color           normal
set -gx tide_status_bg_color_failure   normal

# --- Key bindings ---
# Explicitly set to default so tide's character item check works correctly.
# Without this, fish_key_bindings is empty and tide falls through to vi-mode
# logic, showing ❮ (vi normal mode icon) instead of ❯.
set -U fish_key_bindings fish_default_key_bindings

# --- Character item ---
# Starship: success_symbol='[❯](foam)'  error_symbol='[❯](love)'
set -U  tide_character_icon          '❯'
set -gx tide_character_color         $rp_foam
set -gx tide_character_color_failure $rp_love
set -gx tide_character_bg_color      normal

# --- Git item (used by _tide_item_vcs when not in a jj repo) ---
# Starship: git_branch fg:foam  git_status untracked=gold modified=iris staged=pine deleted=love
set -U  tide_git_icon              (printf '\ue0a0')  # U+E0A0 nerd font branch icon
set -gx tide_git_color_branch      $rp_foam
set -gx tide_git_color_staged      $rp_pine
set -gx tide_git_color_dirty       $rp_iris
set -gx tide_git_color_untracked   $rp_gold
set -gx tide_git_color_conflicted  $rp_love
set -gx tide_git_color_upstream    $rp_foam
set -gx tide_git_bg_color          normal

# --- Disable rose-pine-tide.fish reactive overrides ---
# These --on-variable handlers in rose-pine-tide.fish fire when config.fish
# runs 'fish_config theme choose "Rosé Pine"', clobbering the colors above.
# Redefining them here (no-ops) prevents that; our set -gx values persist.
function _rose_pine_tide_base   --on-variable fish_color_base;   end
function _rose_pine_tide_iris   --on-variable fish_color_iris;   end
function _rose_pine_tide_foam   --on-variable fish_color_foam;   end
function _rose_pine_tide_love   --on-variable fish_color_love;   end
function _rose_pine_tide_gold   --on-variable fish_color_gold;   end
function _rose_pine_tide_pine   --on-variable fish_color_pine;   end
function _rose_pine_tide_rose   --on-variable fish_color_rose;   end
function _rose_pine_tide_subtle --on-variable fish_color_subtle; end
