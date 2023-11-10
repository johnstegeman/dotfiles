##### Python stuff

if [ -x "$(command -v pyenv)" ]; then
	
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"

	eval "$(pyenv init -)"

	VIRTUAL_ENV_DISABLE_PROMPT=1

	~/.pyenv/versions/3.12.0/bin/virtualenvwrapper.sh
	export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
	export WORKON_HOME=$HOME/.virtualenvs
	mkdir -p $WORKON_HOME
	pyenv virtualenvwrapper_lazy
	#export PIP_REQUIRE_VIRTUALENV=true

	alias plo="pip list --outdated"

fi
