# Java

## Version management with mise

Java is managed by [mise](https://mise.jdx.dev/). The configured version is `temurin-25`
(Eclipse Temurin JDK 25), from `mise/mise.utilities.toml`.

```sh
mise install java           # install the configured version
mise use java@temurin-25    # set the active version
java --version              # verify
```

The mise config is at `~/.config/mise/config.toml`; the module files under
`mise/mise.*.toml` carry the tool pins.

## jbang

[jbang](https://www.jbang.dev/) runs Java source files directly as scripts, with no build
tool or project setup:

```sh
jbang script.java           # run a Java file as a script
jbang init hello.java       # create a new jbang script
jbang --java 21 script.java # run with a specific Java version
```

jbang is **not currently installed** — its mise entry is commented out in
`mise/mise.utilities.toml`. Uncomment it (or `brew install jbang`) if you want it; it can
also manage its own JDKs independently of mise.

## Neo4j downloads

The `download` Fish function fetches Neo4j distribution tarballs by version:

```fish
download 5.25.0    # downloads neo4j-enterprise-5.25.0-unix.tar.gz
```

See [fish.md](fish.md) for the full function list.
