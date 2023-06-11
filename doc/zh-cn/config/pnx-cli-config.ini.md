# pnx-cli-config.ini  

这是PNX-CLI的配置文件，如果您没有使用PNX-CLI启动，此配置文件是无效的。  

## 注意事项  

**此文件可能不存在**，如果此文件不存在，不会影响PNX-CLI运行。您仍然可以在PNX-CLI同级目录下手动创建以进行配置。  

## 配置项  

### debug  

true/false，是否开启PNX-CLI调试模式，默认值为false。  

### language  

您使用的语言，可选值为：  

- en-us 英语
- zh-cn 简体中文

### force-arguments

如果您设置了此项，PNX-CLI将忽略命令行中的参数，使用此项中的参数。

示例：`start -g`（其他参数随意）

### preferredJVM  

优先使用的JVM，默认值为`GraalVM`，可以修改为其他JVM发行版名称。  

### jvmPath  

自定义JVM路径，如果PNX-CLI没有自动搜索到您的JVM路径，您可以手动java可执行文件的路径。  
多个路径以平台分隔符间隔，Windows上为`;`，Linux上为`:`。  

默认搜索路径为当前工作目录下的java文件夹以及环境变量中的PATH。  

### vmMemory  

PNX服务端所用的最大内存，语法同JVM的-Xmx参数，默认值为当前可用的最大内存。  

示例：`1024m`

### add-opens  

JVM启动参数，语法同JVM的--add-opens参数，将未打开的模块暴露给PNX，多个模块名用空格分隔。  

示例：`java.base/sun.nio.ch java.base/java.util`  

### x-options  

JVM启动参数，语法同JVM的-X参数，多个参数用空格分隔。  

示例：`prof ms64m`  

## xx-options  

JVM启动参数，语法同JVM的-XX参数，多个参数用空格分隔。  

示例：`+UnlockExperimentalVMOptions +UseCGroupMemoryLimitForHeap`  

## http-proxy  

HTTP代理，配置PNX-CLI用来连接API服务器的网络代理，语法为`<host>:<port>`。  

示例：`localhost:1000`
