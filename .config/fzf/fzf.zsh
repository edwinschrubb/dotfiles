# Auto-completion
# ---------------
[[ $- == *i* ]] && source "{{@@ env['HOME'] @@}}/.config/fzf/completions.zsh" 2> /dev/null

# Key bindings
# ------------
source "{{@@ env['HOME'] @@}}/.config/fzf/key-bindings.zsh"