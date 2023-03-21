# PNX-CLI

PNX-CLI is a command line tool for PNX. It can help you to install and start PNX quickly.
windows using . \pnx.exe to run.
linux use . /pnx to run.
Hereafter abbreviated to pnx.

## Usage

```text
Usage: pnx [-hV] [--config-path=<config-path>] [-l=<lang>] [COMMAND]
      --config-path=<config-path>
                  Select which config file will be used. (Default
                    pnx-cli-config.ini)
  -h, --help      Show this help message and exit.
  -l, --lang, --language=<lang>
                  Select the language to use temporarily to execute this
                    command.
  -V, --version   Print version information and exit.
Commands:
  about             About PowerNukkitX CLI.
  sys-install       Install or uninstall PNX-CLI into the system path.
  sponsor           See the great people who sponsor the PNX program.
  jvm               Check the installed JVMs, install new JVMs or uninstall
                      JVMs.
  server            Configure(install, update) pnx server.
  libs              Check, update or fix the libraries.
  start             Generator start command and start pnx server.
  components, comp  Check, install or uninstall extra components.
```
```text
Usage: pnx about [-hV]
About PowerNukkitX CLI.
  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.
```
```text
Usage: pnx sys-install [-hVu]
Install or uninstall PNX-CLI into the system path.
  -h, --help        Show this help message and exit.
  -V, --version     Print version information and exit.
  -u, --uninstall   Remove PNX-CLI from the system path.
```
```text
Usage: pnx sponsor [-hV]
See the great people who sponsor the PNX program.
  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.
```
```text
Usage: pnx jvm [-hV] (check | remote | -i=<install> | uninstall)
Check the installed JVMs, install new JVMs or uninstall JVMs.
  -h, --help              Show this help message and exit.
  -V, --version           Print version information and exit.
      check               Check the installed JVMs.
  -i, install=<install>   Install a new JVM by its vendor name.
      remote              List all available JVMs in the remote PNX central
                            repository.
      uninstall           Uninstall an existed JVM by its vendor name.
```
```text
Usage: pnx server [-hVu] [--dev] [--latest]
Configure(install, update) pnx server.
  -h, --help                Show this help message and exit.
  -V, --version             Print version information and exit.
      --dev                 Install the preview development version of PNX.
      --latest              Force-choose the latest version of pnx server core.
  -u, -i, update, install   Install or update pnx server core.
```
```text
Usage: pnx libs [-hV] (-u | check)
Check, update or fix the libraries.
  -h, --help            Show this help message and exit.
  -V, --version         Print version information and exit.
      check             Check libraries.
  -u, -f, fix, update   Install or fix the libraries.
```
```text
Usage: pnx start [-hVgr] [--stdin=<stdin>]
Generator start command and start pnx server.
  -h, --help            Show this help message and exit.
  -V, --version         Print version information and exit.
  -g, --generate-only   Generate start command only, do not start pnx server.
  -r, --[no-]restart    Auto-restart pnx server if it crashes.
      --stdin=<stdin>   Input into PNX through a specific file.
```
```text
Usage: pnx components [-hV] (-i=<update> | -c)
Check, install or uninstall extra components.
  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.
  -c, check       Check available components.
  -i, -u, update, install=<update>
                  Install or fix an extra component by its name.
```

### Linux Enter the following command to try
```
chmod +x . /pnx
./pnx jvm install=OracleJDK # Install jdk17, ignore this if you already have it
./pnx
```

### Windows PowerShell Enter the following command to try
```
.\pnx.exe jvm install=OracleJDK # install jdk17, ignore this if you already have it
.\pnx.exe
```

### Windows CMD Enter the following command to try
```
pnx.exe jvm install=OracleJDK # install jdk17, ignore this if you already have it
pnx.exe
```