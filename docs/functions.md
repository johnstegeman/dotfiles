# Custom Functions and Aliases

|Alias/Function Name|What it does|
|-------------------|------------|
|zup|Update zinit and all plugins|
|bup|Update homebrew & upgrade all installed items. Run cleanup and health check at the end|
|bups|Update homebrew & upgrade all installed items. No cleanup/health check|
|plo|List all outdated python libraries (using uv pip)|
|kubesh|Run a shell on the specified kubernetes pod (provide namespace as 1st arg, pod as second arg)|
|_1st_found|For a the list of commands, return the first one that's found|
|d|Prints the zsh directory stack|
|download|When provided a version number (e.g. 5.25.0), download the Neo4j tarball for that version|
|mcreate (MacOS only)|Create a named Ubuntu VM (using multipass) with an opinionated set of software and apply steggy's dotfiles|
|mkvenv|Create a python virtual environment and set up an .envrc for direnv to auto-activate it. Optional parameter to specify the version of Python to use|
|mssh (MacOS only)|ssh into the named multipass VM|
|safe_alias|Creates an alias for a given command, but only if the given command exists. 1st arg=alias name, 2nd arg=command, 3rd arg optional arguments to command|
|safe_alias_2|Creates an alias for a given command (if it exists). If it doesn't repeat the same process for a second command. 1st arg=alias name. 2nd/3rd=command & arguments. 4th/5th=alternative command&arguments|
|safe_suffix_alias|Creates a suffix alias (alias -s) for the given command (if it exists). 1st arg=alias name, 2nd/3rd=command & arguments|
|source_directory|Sources each file (as long as the name ends in .zsh) in the given directory|
|source_if_exists|Source the given file if it exists|
|take|Creates the specified directory and changes to that directory|