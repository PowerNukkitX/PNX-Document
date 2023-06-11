# pnx-cli-config.ini  

This is the config file of PNX-CLI. 
If you do not use PNX-CLI to start, this file is useless.  

## Attention  

**This file may not exist.**  
If this file does not exist, PNX-CLI can still work well.
You can still manually create it under the PNX-CLI peer directory for configuration.  

## Configuration  

### debug  

true/false, whether PNX-CLI debugging mode enables. The default value is false.  

### language  

The language you use. The optional values are:  

- en-us English
- zh-cn Simplified Chinese

### force-arguments

If you set this item, PNX-CLI will ignore the arguments from the command line and use the arguments in this item.

E.g. `start -g` (any other arguments is ok)

### preferredJVM  

The name of the JVM you preferred, default to `GraalVM`.    

### jvmPath  

Customize the JVM path.   
If PNX-CLI does not automatically search your JVM path, you can manually add the path of the java executable file.  
Multiple paths are separated by platform separators, `;` on Windows and `:` on Linux. 

The default search path is the java folder under the current working directory and PATH in the environment variable.  

### vmMemory  

The maximum memory used by the PNX server. The syntax is the same as the -Xmx parameter of the JVM.   
The default value is the maximum memory currently available.  

E.g. `1024m`

### add-opens  

JVM startup parameters, with the same syntax as the --add-opens parameter of the JVM, expose the unopened modules to PNX, and separate multiple module names with spaces.  

E.g. `java.base/sun.nio.ch java.base/java.util`  

### x-options  

The syntax of JVM startup parameters is the same as the -X parameter of JVM. Multiple parameters are separated by spaces.  

E.g. `prof ms64m`  

## xx-options  

The syntax of JVM startup parameters is the same as the -XX parameter of JVM. Multiple parameters are separated by spaces.  

E.g. `+UnlockExperimentalVMOptions +UseCGroupMemoryLimitForHeap`  

## http-proxy

HTTP Proxy, configures the network agent used by PNX-CLI to connect to the API server.  
The syntax is `<host>:<port>`。

E.g. `localhost:1000`
