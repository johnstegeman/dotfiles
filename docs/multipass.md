# Multipass

[Multipass](https://multipass.run) is a program that makes it easy to run a Ubuntu virtual machine on MacOS (it also supports Windows if that's your thing). I have some functions and configuration files set up that suit how I generally want to use Ubuntu; my use cases are generally these:

* Run both single-instance and clustered Neo4j databases (generally for testing/demos, not production use)
* Run software that only runs on Linux

My "requirements" (such as they are) include:

* I want to have a user set up in the VM that has the same configuration as my MacOS user as much as possible
* I use SSH to connect to the VM instead of multipass's built-in shell (as that uses root)

## Functions/aliases

|Function/Alias|Usage|
|--------------|-----|
|mp|Alias for the `multipass` command'|
|mcreate|Function that creates a new named virtual machine, set up the user, and configure it like my MacOS configuration (see information on customizing this in the next section)|
|mssh|Function that uses ssh to connect to the named multipass vm|

## Customizing

There are two places that you may need to make changes so that `mcreate` works for you. The first is the function definition itself, which is in the chezmoi local store as [mcreate.tmpl](../dot_zsh_custom/config-file/functions/mcreate.tmpl) - located in `dot_zsh_custom/cnfig-file/functions/mcreate.tmpl` It is stored as a template so that we can make the function only applicable on MacOS and not in the Ubuntu VM itself.

This function defines the characteristics of the VM, including memory/CPU, mounts (where directories of the host OS are made available in the VM), and a cloud-init file that specifies local users and their public SSH keys, packages to install, and also uses `runcmd` to install chezmoi, apply (my) chezmoi configuration, and build neovim from source. 

You should review the mcreate function to ensure the memory/cpu configuration and mounts are configured to your liking (please note the `mssh` invocation is commented out, as it's purpose was to do the chezmoi configuration which is now done in the cloud init configuration)

You should also review the [cloud init configuration](../config/neo_init.yaml) - stored in the chezmoi local store as `config/neo_init.yaml` There are 3 things you will almost definitely want to change:

* The name of the local user to create (my configuration uses `jstegeman`)
* The public half of the SSH key to set up for that user
* The chezmoi repository URL that you want to be applied for that user (also ensure the `runcmd` lines are being run as the local user and not `jstegeman`)