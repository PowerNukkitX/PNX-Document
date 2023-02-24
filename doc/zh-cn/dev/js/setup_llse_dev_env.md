# 基于LLSE-Lib开发PNXJS插件

`LLSE` 是基于`LiteLoader`脚本引擎的一个插件框架。  
`LiteLoader` 是基岩版官方服务端 `Bedrock Dedicated Server`的一个插件加载器。  
关于更多`LLSE`的消息，你可以前往[此处查询](https://docs.litebds.com/zh-Hans/#/LLSEPluginDevelopment/README)

[LLSE-Lib](https://github.com/PowerNukkitX/LLSE-Lib) 是基于PNX API制作的一个对于`LLSE`
插件框架的实现，使用它你可以在PNX上得到`LLSE`简单、易用的开发体验，同时经过部分修改，你可以轻松运行BDS上`LLSE`的插件。
同时，你编写的插件经过简易修改也可以轻松在BDS `LiteLoader`插件加载器上运行。

## 环境搭建

#### 1.创建一个新文件夹  
#### 2.克隆JavaScript插件模板
首先，在克隆之前确保你已经安装了`git`，如果你不知道`git`是什么，请搜索查询。  
在该文件夹下打开git bash运行
```shell
git clone --recursive https://github.com/PowerNukkitX/JavaScript-Template
```
#### 3.前往[LLSE-Lib](https://github.com/PowerNukkitX/LLSE-Lib/releases/latest)下载最新完整库(@LLSELib-full.zip)当做补全文件
#### 4.将@LLSELib-full.zip解压到当前目录，此时你的目录结构应该为：
```text
D:
├─@LLSELib
└─JavaScript-Template
```
#### 5.配置插件信息
重命名JavaScript-Template文件夹为`@`加上你插件的名称，例如`@test`。
以`@test`为示例，修改plugin.yml为
```yaml
# 请把xxx替换为你的插件的名字
# Please replace xxx in the next line with the name of your plugin.
name: test
# 这里填写插件的入口文件，在此模板中默认为index.js，如无特殊情况，您无需更改
# Fill in the entry file of the plugin here, and the default in this template is index.js, if there are no special circumstances, you don't need to change.
main: index.js
version: "1.0.0"
api: ["1.0.14"]
# 插件加载顺序，只能填写 STARTUP 或 POSTWORLD
# STARTUP: 此时服务器刚启动，地图尚未加载，通常用于依赖库
# POSTWORLD: 此时服务器所有地图都加载完毕，通常填写POSTWORLD即可
# The loading sequence of plug-ins is here. Only startup or PostWorld can be filled in.
# STARTUP: at this time, the server has just started, and the worlds has not been loaded. It is usually used for libraries.
# POSTWORLD: at this time, all the worlds in the server are loaded. Usually, you can fill in POSTWORLD here.
load: POSTWORLD
# 请把test替换为你的名字
# Please replace xxx in the next line with your name.
author: test
# 请把test替换为你的插件的简短描述
# Please replace xxx in the next line with the description of your plugin.
description: test
depend: [ "LLSELib" ]
features:
  - WsClient
```
其中的配置项按照自己需求修改，LLSE的插件注册API等同于这里的plugin.yml  
更多配置项查看[this](https://github.com/PowerNukkitX/ExamplePlugin-Maven/blob/master/src/main/resources/plugin.yml)
#### 6.进入index.js,在开头导入以下模块，然后就可以使用LLSELib愉快的编写插件了
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


