# Tide prompt configuration
# Mirrors the starship layout with Ayu Dark colors
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
# Note: no official Ayu fish integration ships conf.d reactive handlers,
# so there's no override to neutralise here.

# --- Ayu Dark palette ---
set -l ay_text   BFBDB6
set -l ay_red    F07178
set -l ay_yellow E6B450
set -l ay_green  AAD94C
set -l ay_cyan   39BAE6
set -l ay_orange FF8F40

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
set -gx tide_os_color    $ay_text
set -gx tide_os_bg_color normal

# --- PWD item ---
# Starship: [$path]($style)  style=fg:orange  truncation_length=5  truncate_to_repo=false
# No icon prefix — starship shows the bare path only
set -gx tide_pwd_color_anchors        $ay_orange
set -gx tide_pwd_color_dirs           $ay_orange
set -gx tide_pwd_color_truncated_dirs $ay_orange
set -U  tide_pwd_truncation_length    5
set -U  tide_pwd_icon                 ''   # no folder icon (matches starship bare path)
set -U  tide_pwd_icon_home            ''   # no home icon
set -U  tide_pwd_icon_unwritable      ''
set -gx tide_pwd_bg_color             normal

# --- Python item ---
# Starship: [ $symbol$pyenv_prefix($version)(\($virtualenv\))]($style)  style=green  symbol=
set -U  tide_python_icon     (printf '\ue235')  # U+E235 nerd font Python icon
set -gx tide_python_color    $ay_green
set -gx tide_python_bg_color normal

# --- Status item ---
# Starship: not explicitly configured (uses defaults — hidden on success, ✘ on failure)
set -U  tide_status_icon               ''
set -U  tide_status_icon_failure       '✘'
set -gx tide_status_color              $ay_text
set -gx tide_status_color_failure      $ay_red
set -gx tide_status_bg_color           normal
set -gx tide_status_bg_color_failure   normal

# --- Key bindings ---
# Explicitly set to default so tide's character item check works correctly.
# Without this, fish_key_bindings is empty and tide falls through to vi-mode
# logic, showing ❮ (vi normal mode icon) instead of ❯.
set -U fish_key_bindings fish_default_key_bindings

# --- Character item ---
# Starship: success_symbol='[❯](cyan)'  error_symbol='[❯](red)'
set -U  tide_character_icon          '❯'
set -gx tide_character_color         $ay_cyan
set -gx tide_character_color_failure $ay_red
set -gx tide_character_bg_color      normal

# --- Git item (used by _tide_item_vcs when not in a jj repo) ---
# Custom git segment mirrors jj density: branch/upstream=cyan, add=green,
# modified/untracked=accent-gold, deleted/conflicted=red.
set -U  tide_git_icon              (printf '\ue0a0')  # U+E0A0 nerd font branch icon
set -gx tide_git_color_branch      $ay_cyan
set -gx tide_git_color_staged      $ay_green
set -gx tide_git_color_dirty       $ay_yellow
set -gx tide_git_color_untracked   $ay_yellow
set -gx tide_git_color_conflicted  $ay_red
set -gx tide_git_color_upstream    $ay_cyan
set -gx tide_git_bg_color          normal
