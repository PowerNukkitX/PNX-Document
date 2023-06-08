# Common Questions 

## java.lang.reflect.InaccessibleObjectException  
### Simple solution
Prepend `-jar` before `--add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.io=ALL-UNNAMED` in your start command.  
For example：
```
Java17\bin\java --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.io=ALL-UNNAMED -jar powernukkitx-1.6.0.0-PNX-SNAPSHOT-shaded.jar
```
### Full solution
Check the following parts of the error stacktrace：
```
module A does not "opens B" to unnamed module @C
```
Add `-add-opens A/B=ALL-UNNAMED` (the content in A/B is the name of the module in question, see the following example) before the start command `-jar`, and do this for each different error report  

Example.

If the error is reported as: module `java.base` does not "opens `java.lang`" to unnamed module @?????? then the parameter configuration would be
```
--add-opens java.base/java.lang=ALL-UNNAMED
```

## java.lang.UnsupportedClassVersionError
Install Java17. [Download](https://mirrors.tuna.tsinghua.edu.cn/Adoptium/17/jre/x64/windows/OpenJDK17U-jre_x64_windows_hotspot_17.0.3_7.zip)
## java.net.BindException: Address already in use: bind
### Solution
#### Windows solution
Win+R opens the Run window, type cmd in the window to open the command window that comes with Windows
```
netstat -ano|findstr 19132
```
Enter the above command to check if the port is occupied, the number 19132 represents the port
Example:
```
C:\Users\Administrator>netstat -ano|findstr 19132
  UDP    0.0.0.0:19132          *:*                                    12228
```
Find the corresponding UDP number for port 12228 and enter the following command in the Windows command window to unlock port 19132
```
taskkill /f /t /im 12228
```
#### Linux solution  
Enter the following command in the command box
```
netstat -tln | grep 19132
```
Check the corresponding system PID number to end the process using the following command
```
kill -9 PID
```

## java.lang.NoClassDefFoundError: org/objectweb/asm/Type  
If you are using pnx-cli,please use the following command to update dependent libraries.
```
pnx libs update
```
If you are using shaded core,please download the latest core in [github action](https://github.com/PowerNukkitX/PowerNukkitX/actions).

## java.lang.RuntimeException

If the error log contains the following content:    
```
java.io.IOException: Unable to acquire lock on '......players/LOCK'
```

It means that you have opened at least two identical PNX programs on the same path at the same time. 
Please close the one you started earlier.  
If you don't even know how to close a program, please restart your server
to solve the problem and learn how to use your operating system correctly.

## All players are offline at the same time  

This may be caused by the following reasons:  

- Some players join with cheat clients and broadcast broken data packets
- There is a plug-in blocking on the main thread for a long time
- Debugger, third-party launcher, antivirus software block PNX operation
- You click the console (the title of the console window starts with "selected"), which leads to entering the debugging mode, and the operation of the server is suspended
- Your server performance is poor, and other high occupancy programs are opened at the same time. The system suspends the operation of PNX to ensure the operation of other foreground programs
- Your server or service provider has been attacked by network, such as DDOS

Please check the above reasons first. If you really can't solve it, you can turn to QQ group or Discord server for help.

## DOS error/errno=1455

> The page file is too small to complete the operation 
> DOS error/errno=1455

This happens when the JVM asks the operating system for memory, and the operating system cannot give more memory.  
When PNX starts, the available memory configured by default will be slightly less than the maximum available physical memory space at that time. 
If it is exceeded, GC will be performed and JVM internal error will be thrown instead of applying for more memory from the operating system.
This happens only when the maximum available physical memory space data that PNX calculates does not match the actual memory size.
If the machine memory is too small, or some core displays with too much reserved space (usually with laptops) are used, the proportion of hardware reserved memory is too large to cause this problem.
This problem can also be caused by over-opened virtual machines.

You can try to solve this problem in the following ways:  

- Configure PNX to use less memory
- Increase virtual memory size of the operating system (which may severely degrade performance)
- Expand the size of the physical memory

## How to disable the automatic restart 

Waiting 10 seconds for automatic restart after shutdown is the default feature of PNX-CLI.
You can turn this off by adding 'start' after the startup command.

For example:  

```shell
# Native PNX-CLI on Windows
.\pnx start
# Native PNX-CLI on Linux
./pnx start
# Jar version of PNX-CLI
java -jar PNX-CLI.jar start
```