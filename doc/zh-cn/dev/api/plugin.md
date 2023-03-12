# 插件API

此处提供PNX插件站相关API。

## 获取插件列表

url:

- /plugin/list?from={from}&size={size}
- /plugin/list/{sorter:recommend|lastUpdate|star}?from={from}&size={size}
- /plugin/list/{sorter:recommend|lastUpdate|star}/{order:asc|desc}?from={from}&size={size}

参数:

- sorter: 排序方式，可选值为`recommend`、`lastUpdate`、`star`，默认为`recommend`
- order: 排序顺序，可选值为`asc`、`desc`，默认为`desc`
- from: 起始位置，默认为`0`
- size: 获取数量，默认为`15`

返回示例:

```json5
{
  "size": 2,
  "totalSize": 81,
  "plugins": [
    {
      "id": "Physical-Science-Academy/NoCheatPlus",
      // 仓库ID
      "owner": "Physical-Science-Academy",
      // 仓库所有者
      "name": "NoCheatPlus",
      // 仓库名
      "description": "Anti-Cheat plugin for Minecraft (Nukkit/PM1E/PowerNukkitX)",
      "mainLanguage": "Kotlin",
      // 编写此插件的主要语言
      "lastUpdateAt": 1677765763000,
      // 此仓库最后一次更新的时间
      "topics": "anticheat nukkit minecraft plugin bedrock ncp mcbe",
      // 仓库标签
      "star": 87,
      "iconDownloadID": 89,
      // 图标文件下载ID，可通过DownloadAPI下载图标
      "pluginName": "NoCheatPlus",
      // 插件名
      "mainClass": "net.catrainbow.nocheatplus.NoCheatPlus",
      // 插件主类(JVM插件)/入口点(JS插件)
      "dependencies": [
        // 依赖项，此字段可能不存在
        "KotlinLib"
      ],
      "softDependencies": [
        // 可选依赖项，此字段可能不存在
        "DBLib"
      ],
      "banned": false,
      "qualityScore": 8986,
      // 插件评分，由更新、star、文档等因素综合决定，可能为负数
      "editorRecommendScore": 0,
      "lastFullIndexTime": 1677938264977
      // PNX插件站最后一次全量索引此插件信息的时间
    },
    {
      "id": "KCodeYT/VanillaGenerator",
      "owner": "KCodeYT",
      "name": "VanillaGenerator",
      "description": "A minecraft: bedrock edition world generator, which setups a bedrock dedicated server to clone chunks on the PowerNukkitX server.",
      "mainLanguage": "Java",
      "lastUpdateAt": 1677372828000,
      "star": 33,
      "iconDownloadID": 98,
      "pluginName": "VanillaGeneratorPlugin",
      "mainClass": "de.kcodeyt.vanilla.VanillaGeneratorPlugin",
      "banned": false,
      "qualityScore": 3351,
      "editorRecommendScore": 0,
      "lastFullIndexTime": 1677938290581
    }
  ]
}
```

## 获取指定插件信息

url:

- /plugin/get/{id}

参数:

- id: 仓库ID，如`PowerNukkitX/ChiliShop`

返回示例:

```json5
{
  "id": "PowerNukkitX/ChiliShop",
  "owner": "PowerNukkitX",
  "name": "ChiliShop",
  "description": "A plugin for PowerNukkitX, Based on the PepperShop",
  "mainLanguage": "Java",
  "lastUpdateAt": 1663006782000,
  "star": 0,
  "iconDownloadID": 90,
  "pluginName": "ChiliShop",
  "mainClass": "cn.innc11.chilishop.ChiliShop",
  "dependencies": [
    "EconomyAPI"
  ],
  "softDependencies": [
    "Residence",
    "Land"
  ],
  "banned": false,
  "qualityScore": -1135,
  "editorRecommendScore": 0,
  "lastFullIndexTime": 1677984732132
}
```

## 通过关键词搜索插件

请注意，此API仍处于alpha阶段，搜索结果可能不尽如人意。  
后续将会对此API的性能和功能进行优化。

url:

- /plugin/search?keywords={keywords}&size={size}
- /plugin/search/{order:asc|desc}?keywords={keywords}&size={size}

参数:

- keywords: 关键词，多个关键词之间用空格分隔
- size: 获取数量，默认为`15`
- order: 排序顺序，可选值为`asc`、`desc`，默认为`desc`

返回示例:  
`/plugin/search?keywords=world`  
```json5
{
  "size": 3,
  "totalSize": 81,
  "plugins": [
    {
      "id": "KCodeYT/VanillaGenerator",
      "owner": "KCodeYT",
      "name": "VanillaGenerator",
      "description": "A minecraft: bedrock edition world generator, which setups a bedrock dedicated server to clone chunks on the PowerNukkitX server.",
      "mainLanguage": "Java",
      "lastUpdateAt": 1677372828000,
      "star": 33,
      "iconDownloadID": 98,
      "pluginName": "VanillaGeneratorPlugin",
      "mainClass": "de.kcodeyt.vanilla.VanillaGeneratorPlugin",
      "banned": false,
      "qualityScore": 3351,
      "editorRecommendScore": 0,
      "lastFullIndexTime": 1677938290581
    },
    {
      "id": "PowerNukkitX/FastAsyncWorldEdit-PNX",
      "owner": "PowerNukkitX",
      "name": "FastAsyncWorldEdit-PNX",
      "description": "Blazingly fast world manipulation for artists, builders and everyone else: https://www.spigotmc.org/resources/13932/",
      "mainLanguage": "Java",
      "lastUpdateAt": 1677981372000,
      "star": 2,
      "iconDownloadID": 90,
      "pluginName": "FastAsyncWorldEdit",
      "mainClass": "com.sk89q.worldedit.bukkit.WorldEditPlugin",
      "softDependencies": [
        "Vault"
      ],
      "banned": false,
      "qualityScore": 300,
      "editorRecommendScore": 0,
      "lastFullIndexTime": 1677984146128
    },
    {
      "id": "WanneSimon/ns-world",
      "owner": "WanneSimon",
      "name": "ns-world",
      "description": "Multi world plugin",
      "mainLanguage": "Java",
      "lastUpdateAt": 1661873542000,
      "star": 0,
      "iconDownloadID": 107,
      "pluginName": "ns-world",
      "mainClass": "cc.wanforme.nukkit.nsworld.NSWorld",
      "banned": false,
      "qualityScore": -1328,
      "editorRecommendScore": 0,
      "lastFullIndexTime": 1677938433783
    }
  ]
}
```

## 绘制依赖关系图  

以mermaid格式绘制插件依赖关系图。

**该API为延迟返回API。**

url:
- /plugin/dependency-graph/{name}

参数:
- name: 插件名称，如`LLSELib`

返回示例:  
```json5
{
  "success": true,
  "reason": null,
  "mermaid": "graph TD\n    LLSELib(LLSELib)\n    EconomyEvent-.->LLSELib\n    LlamaEconomy-.->LLSELib\n    EconomyAPI-.->LLSELib\n"
}
```