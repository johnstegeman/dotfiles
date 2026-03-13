# Java

## Version management with mise

Java is managed by [mise](https://mise.jdx.dev/). The configured version is `temurin-24` (Eclipse Temurin JDK 24).

```sh
mise install java           # install the configured version
mise use java@temurin-24    # set the active version
java --version              # verify
```

The mise config is at `~/.config/mise/config.toml`.

## jbang

[jbang](https://www.jbang.dev/) allows running Java source files directly as scripts, without needing a build tool or project setup.

```sh
jbang script.java           # run a Java file as a script
jbang init hello.java       # create a new jbang script
jbang --java 21 script.java # run with a specific Java version
```

jbang can also manage its own JDK installations independently of mise.

## Download helper

The `download` Fish function downloads Neo4j distribution tarballs by version number:

```fish
download 5.25.0    # downloads the Neo4j 5.25.0 tarball
```
