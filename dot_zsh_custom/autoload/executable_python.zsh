##### Python stuff

if [ -x "$(command -v pyenv)" ]; then
	
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"

	eval "$(pyenv init -)"

	VIRTUAL_ENV_DISABLE_PROMPT=1
   eval "$(pyenv virtualenv-init -)"
#	~/.pyenv/versions/3.12.2/bin/virtualenvwrapper.sh


	alias plo="pip list --outdated"

fi
