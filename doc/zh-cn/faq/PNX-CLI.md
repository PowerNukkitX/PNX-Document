# PNX-CLI  

PNX-CLI 是PNX的命令行工具。可以帮助您快速安装并启动PNX。
windows使用.\pnx.exe运行  
linux使用./pnx运行
以下简写为pnx

## 命令用法  

```text
Usage: pnx [-hV] [--config-path=<config-path>] [-l=<lang>] [COMMAND]
      --config-path=<config-path>
                  指定配置文件路径（默认为pnx-cli-config.ini）
  -h, --help      Show this help message and exit.
  -l, --lang, --language=<lang>
                  选择执行此次命令所用的语言代码。
  -V, --version   Print version information and exit.
Commands:
  about             PowerNukkitX CLI的信息。
  sys-install       在系统路径中安装或卸载PNX。
  sponsor           查看赞助PNX的大佬们。
  jvm               查看已经安装了的JVM，下载新JVM或卸载已经安装的JVM。
  server            配置，安装或升级PNX服务端核心。
  libs              检查，更新或修复依赖库。
  start             生成启动命令并启动PNX服务器。
  components, comp  检查、安装或卸载附加组件。
```
```text
Usage: pnx about [-hV]
PowerNukkitX CLI的信息。
  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.
```
```text
Usage: pnx sys-install [-hVu]
在系统路径中安装或卸载PNX。
  -h, --help        Show this help message and exit.
  -V, --version     Print version information and exit.
  -u, --uninstall   从系统路径中移除PNX-CLI。
```
```text
Usage: pnx sponsor [-hV]
查看赞助PNX的大佬们。
  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.
```
```text
Usage: pnx jvm [-hV] (check | remote | -i=<install> | uninstall)
查看已经安装了的JVM，下载新JVM或卸载已经安装的JVM。
  -h, --help              Show this help message and exit.
  -V, --version           Print version information and exit.
      check               查看已经安装了的JVM。
  -i, install=<OracleJDK|GraalVM|AdoptOpenJDK>
                          根据输入的型号名称安装新的JVM。
      remote              列出PNX远程仓库中的所有可用JVM。
      uninstall           根据输入的序号卸载已经安装了的JVM。
```
```text
Usage: pnx server [-hVu] [--dev] [--latest]
配置，安装或升级PNX服务端核心。
  -h, --help                Show this help message and exit.
  -V, --version             Print version information and exit.
      --dev                 安装预览开发版本的PNX核心。
      --latest              强制选择最新版本的PNX服务端核心。
  -u, -i, update, install   安装或升级PNX服务端核心。
```
```text
Usage: pnx libs [-hV] (-u | check)
检查，更新或修复依赖库。
  -h, --help            Show this help message and exit.
  -V, --version         Print version information and exit.
      check             检查依赖库是否为最新。
  -u, -f, fix, update   更新或修复依赖库。
```
```text
Usage: pnx components [-hV] (-i=<update> | -c)
检查、安装或卸载附加组件。
  -h, --help      Show this help message and exit.
  -V, --version   Print version information and exit.
  -c, check       检查可用的附加组件。
  -i, -u, update, install=<update>
                  根据输入名称安装或修复附加组件。
```

## 如何使用
1. 从这里下载最新版本PNX CLI (https://github.com/PowerNukkitX/PNX-CLI/releases)  
2. 推荐下载对应平台的可执行文件，例如windows下载PNX-CLI-Windows-x86.zip  
如果没有你对应的平台，你可以使用jar包来使用，使用java -jar xxx命令启动  
3. 解压，以下命令要在解压出来的对应文件的路径使用
### Linux 输入下述指令尝试
```
chmod +x ./pnx
./pnx jvm install=OracleJDK #安装jdk17，如果你已经有了就忽略这条
./pnx
```
### Windows PowerShell 输入下述指令尝试

```
.\pnx.exe jvm install=OracleJDK #安装jdk17，如果你已经有了就忽略这条
.\pnx.exe
```

### Windows CMD 输入下述指令尝试

```
pnx.exe jvm install=OracleJDK #安装jdk17，如果你已经有了就忽略这条
pnx.exe
```
