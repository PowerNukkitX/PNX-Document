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

通过关键词搜索插件，此接口会返回与关键词相关的插件列表，搜索考虑的因素包括插件名，作者名，插件topic，介绍，编程语言，主类，依赖库，星标等。

**注意事项：**  

- 关键词应该不超过256字节
- **搜索返回的ID字段跟其他API中使用的ID字段不同，将`/`替换为了`-`，请使用owner和name字段获取仓库信息**
- 暂不支持搜索ReadMe中的内容，即ReadMe中的内容不被搜索引擎索引
- 此API具有模糊搜索功能，允许不完整的词汇和错别字词，可能无法精确匹配
- 模糊搜索不包括作者名，作者名必须前缀匹配或精确匹配
- 搜索的结果可能包含关键词中某些词的同义词，如`nukkit`可能会匹配到`nukkitx`，`nukkitx`可能会匹配到`nukkit`
- 此API无法提供跨语言搜索
- 参数中的`order`字段仅仅会对插件推荐程度，星标数量和最后更新日期等因素进行排序，匹配精确度永远是第一决定因素，并按照降序排列
- 被强制下架的插件也有可能被搜索到，请手动根据`banned`字段判断是否被强制下架

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
  "size": 4,
  "totalSize": 91,
  "plugins": [
    {
      "owner": "WanneSimon",
      "star": 0,
      "mainClass": "cc.wanforme.nukkit.nsworld.NSWorld",
      "description": "Multi world plugin",
      "mainLanguage": "Java",
      "lastFullIndexTime": 1678640203697,
      "pluginName": "ns-world",
      "iconDownloadID": 107,
      "editorRecommendScore": 0,
      "qualityScore": -1385,
      "name": "ns-world",
      "lastUpdateAt": 1661873542000,
      "id": "WanneSimon-ns-world",
      "banned": false
    },
    {
      "owner": "PowerNukkitX",
      "star": 2,
      "mainClass": "com.sk89q.worldedit.bukkit.WorldEditPlugin",
      "description": "Blazingly fast world manipulation for artists, builders and everyone else: https://www.spigotmc.org/resources/13932/",
      "softDependencies": [
        "Vault"
      ],
      "mainLanguage": "Java",
      "lastFullIndexTime": 1678691584814,
      "pluginName": "FastAsyncWorldEdit",
      "iconDownloadID": 90,
      "editorRecommendScore": 0,
      "qualityScore": 243,
      "name": "FastAsyncWorldEdit-PNX",
      "lastUpdateAt": 1677981372000,
      "id": "PowerNukkitX-FastAsyncWorldEdit-PNX",
      "banned": false
    },
    {
      "owner": "KCodeYT",
      "star": 33,
      "mainClass": "de.kcodeyt.vanilla.VanillaGeneratorPlugin",
      "description": "A minecraft: bedrock edition world generator, which setups a bedrock dedicated server to clone chunks on the PowerNukkitX server.",
      "mainLanguage": "Java",
      "lastFullIndexTime": 1678640210976,
      "pluginName": "VanillaGeneratorPlugin",
      "iconDownloadID": 98,
      "editorRecommendScore": 0,
      "qualityScore": 3293,
      "name": "VanillaGenerator",
      "lastUpdateAt": 1677372828000,
      "id": "KCodeYT-VanillaGenerator",
      "banned": false
    },
    {
      "owner": "MEFRREEX",
      "star": 0,
      "mainClass": "theoni.anticaps.Main",
      "topics": "pnx-plugin",
      "description": "Makes words from uppercase to lowercase",
      "mainLanguage": "Java",
      "lastFullIndexTime": 1678632998170,
      "pluginName": "AntiCaps",
      "iconDownloadID": 105,
      "editorRecommendScore": 0,
      "qualityScore": 279,
      "name": "AntiCaps",
      "lastUpdateAt": 1678451185000,
      "id": "MEFRREEX-AntiCaps",
      "banned": false
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