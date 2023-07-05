# Develop PNXJS plugin based on LLSE-Lib

`LLSE` is a plugin framework based on the `LiteLoader` scripting engine.  
`LiteLoader` is a plugin loader for `Bedrock Dedicated Server`, the official server of Bedrock Edition.  
For more news about `LLSE`, you can go to [check here](https://docs.litebds.com/zh-Hans/#/LLSEPluginDevelopment/README)

The [LLSE-Lib](https://github.com/PowerNukkitX/LLSE-Lib) is an implementation of the `LLSE` plugin framework based on the PNX API.
Plugin framework implementation, using it you can get `LLSE` simple and easy to use development experience on PNX, and after some modifications, you can easily run `LLSE` plugins on BDS.
Also, the plug-ins you write can be easily run on the BDS `LiteLoader` plug-in loader after easy modifications.

## Environment construction

#### 1.Create a new folder
#### 2.Clone JavaScript plugin template
First, make sure you have `git` installed before cloning, if you don't know what `git` is, search for it and look it up.  
Open git bash in that folder and run
```shell
git clone --recursive https://github.com/PowerNukkitX/JavaScript-Template
```
#### 3.Go to [LLSE-Lib](https://github.com/PowerNukkitX/LLSE-Lib/releases/latest) to download the latest complete library (@LLSELib-full.zip) as a complementary file
#### 4.将@LLSELib-full.zip解压到当前目录, at which point your directory structure should read
```text
D:
├─@LLSELib
└─JavaScript-Template
```
#### 5.Configure plugin information
Rename the JavaScript-Template folder to `@` plus the name of your plugin, e.g. `@test`.
Using `@test` as an example, modify plugin.yml to
```yaml
# Please replace xxx in the next line with the name of your plugin.
name: test
# Fill in the entry file of the plugin here, and the default in this template is index.js, if there are no special circumstances, you don't need to change.
main: index.js
version: "1.0.0"
api: ["1.0.14"]
# The loading sequence of plug-ins is here. Only startup or PostWorld can be filled in.
# STARTUP: at this time, the server has just started, and the worlds has not been loaded. It is usually used for libraries.
# POSTWORLD: at this time, all the worlds in the server are loaded. Usually, you can fill in POSTWORLD here.
load: POSTWORLD
# Please replace xxx in the next line with your name.
author: test
# Please replace xxx in the next line with the description of your plugin.
description: test
depend: [ "LLSELib" ]
features:
  - WsClient
```
The configuration items are modified according to your needs, LLSE's plug-in registration API is equivalent to the plugin.yml here  
For more configuration items see [this](https://github.com/PowerNukkitX/ExamplePlugin-Maven/blob/master/src/main/resources/plugin.yml)
#### 6.Go to index.js, import the following module at the beginning, and then you can use LLSELib to write plugins happily
```javascript
import {
    ll,
    mc,
    Format,
    PermType,
    ParamType,
    system,
    data,
    i18n,
    logger,
    File,
    JsonConfigFile,
    BinaryStream,
    colorLog,
    log,
    NbtEnd,
    NbtShort,
    NbtInt,
    NbtFloat,
    NbtDouble,
    NbtCompound,
    NbtList,
    NbtLong,
    NbtByte,
    NbtByteArray,
    NbtString,
    NBT
} from '@LLSELib/index.js';
```


