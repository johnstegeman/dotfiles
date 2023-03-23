####### Utility functions
source_if_exists() { [ -f "$1" ] && source "$1" }

source_directory() {
if [ -d "$1" ]; then
  for file in "$1"/*.zsh; do
     source "$file"
  done
fi
}
######## End of utility functions