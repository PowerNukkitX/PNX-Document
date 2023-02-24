# GitHub相关API

## 获取仓库star数量

url:

- /git/star
- /git/star/{repo}

参数:

- repo: 仓库名，如`PowerNukkit`或`PNX-CLI`，默认为`PowerNukkit`

返回示例:

```json
{
  "stargazersCount": 201
}
```

## 获取仓库issue数量

url:

- /git/issue
- /git/issue/{repo}
- /git/issue/{status:all|open|closed}
- /git/issue/{repo}/{status:all|open|closed}

参数:

- repo: 仓库名，如`PowerNukkit`或`PNX-CLI`，默认为`PowerNukkit`
- status: 问题状态，可选值为`all`、`open`、`closed`，默认为`all`

返回示例:

```json
{
  "issueCount": 1058
}
```

## 获取仓库最新构建信息

url:

- /git/latest-build
- /git/latest-build/{repo}

参数:

- repo: 仓库名，如`PowerNukkit`或`PNX-CLI`，默认为`PowerNukkit`

返回示例:

```json5
{
  "libs": {
    "name": "PowerNukkitX-Libs",
    "createAt": 1677241742000,
    // 创建时间，时间戳，单位为毫秒
    "expiresAt": 1685017716000,
    // 过期时间，时间戳，单位为毫秒
    "sizeInBytes": 97061200,
    // 大小，单位为字节
    "downloadId": 5
    // 下载id，可在download API中通过该id下载文件
  },
  "full": {
    "name": "PowerNukkitX-Full",
    "createAt": 1677241742000,
    "expiresAt": 1685017690000,
    "sizeInBytes": 77807923,
    "downloadId": 6
  },
  "core": {
    "name": "PowerNukkitX-Core",
    "createAt": 1677241742000,
    "expiresAt": 1685017687000,
    "sizeInBytes": 6567795,
    "downloadId": 7
  },
  "hashes": {
    "name": "Hashes(md5 & sha256)",
    "createAt": 1677241742000,
    "expiresAt": 1685017737000,
    "sizeInBytes": 402,
    "downloadId": 8
  }
}
```

## 获取仓库最新发行版信息

url:

- /latest-release
- /latest-release/{repo}

参数:

- repo: 仓库名，如`PowerNukkit`或`PNX-CLI`，默认为`PowerNukkit`

返回示例:

```json5
{
  "name": "1.19.62-r1", // 发布标题
  "tagName": "1.19.62-r1", // 版本号
  "body": "Changelog......", // 更新日志内容
  "publishedAt": 1677129866000, // 发布时间，时间戳，单位为毫秒
  "artifacts": [
    {
      "name": "libs.tar.gz", // 文件名
      "createAt": 1677139676000, // 创建时间，时间戳，单位为毫秒
      "expiresAt": 9223372036854775807, // 过期时间，时间戳，单位为毫秒
      "sizeInBytes": 59634219, // 大小，单位为字节
      "downloadId": 9 // 下载id，可在download API中通过该id下载文件
    },
    {
      "name": "libs.tar.gz.md5",
      "createAt": 1677139682000,
      "expiresAt": 9223372036854775807,
      "sizeInBytes": 46,
      "downloadId": 10
    },
    {
      "name": "libs.tar.gz.sha256",
      "createAt": 1677139681000,
      "expiresAt": 9223372036854775807,
      "sizeInBytes": 78,
      "downloadId": 11
    },
    {
      "name": "powernukkitx.jar",
      "createAt": 1677139675000,
      "expiresAt": 9223372036854775807,
      "sizeInBytes": 6567852,
      "downloadId": 12
    },
    {
      "name": "powernukkitx.jar.md5",
      "createAt": 1677139681000,
      "expiresAt": 9223372036854775807,
      "sizeInBytes": 51,
      "downloadId": 13
    },
    {
      "name": "powernukkitx.jar.sha256",
      "createAt": 1677139680000,
      "expiresAt": 9223372036854775807,
      "sizeInBytes": 83,
      "downloadId": 14
    }
  ]
}
```

## 获取仓库所有发新版信息  

url:
- /all-releases
- /all-releases/{repo}

参数:
- repo: 仓库名，如`PowerNukkit`或`PNX-CLI`，默认为`PowerNukkit`

返回示例:
```json5
[
  {
    "name": "1.19.62-r1", // 发布标题
    "tagName": "1.19.62-r1", // 版本号
    "body": "......", // 更新日志内容
    "publishedAt": 1677129866000, // 发布时间，时间戳，单位为毫秒
    "artifacts": [
      {
        "name": "libs.tar.gz", // 文件名
        "createAt": 1677139676000, // 创建时间，时间戳，单位为毫秒
        "expiresAt": 9223372036854775807, // 过期时间，时间戳，单位为毫秒
        "sizeInBytes": 59634219, // 大小，单位为字节
        "downloadId": 89 // 下载id，可在download API中通过该id下载文件
      },
      {
        "name": "libs.tar.gz.md5",
        "createAt": 1677139682000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 46,
        "downloadId": 90
      },
      {
        "name": "libs.tar.gz.sha256",
        "createAt": 1677139681000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 78,
        "downloadId": 91
      },
      {
        "name": "powernukkitx.jar",
        "createAt": 1677139675000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 6567852,
        "downloadId": 92
      },
      {
        "name": "powernukkitx.jar.md5",
        "createAt": 1677139681000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 51,
        "downloadId": 93
      },
      {
        "name": "powernukkitx.jar.sha256",
        "createAt": 1677139680000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 83,
        "downloadId": 94
      }
    ]
  },
  {
    "name": "1.19.60-r1",
    "tagName": "1.19.60-r1",
    "body": "......",
    "publishedAt": 1675930654000,
    "artifacts": [
      {
        "name": "libs.tar.gz",
        "createAt": 1675930656000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 59636769,
        "downloadId": 5
      },
      {
        "name": "libs.tar.gz.md5",
        "createAt": 1675930660000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 46,
        "downloadId": 6
      },
      {
        "name": "libs.tar.gz.sha256",
        "createAt": 1675930659000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 78,
        "downloadId": 7
      },
      {
        "name": "powernukkitx.jar",
        "createAt": 1675930655000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 6551733,
        "downloadId": 8
      },
      {
        "name": "powernukkitx.jar.md5",
        "createAt": 1675930659000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 51,
        "downloadId": 9
      },
      {
        "name": "powernukkitx.jar.sha256",
        "createAt": 1675930658000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 83,
        "downloadId": 10
      }
    ]
  },
  {
    "name": "1.19.50-r3",
    "tagName": "1.19.50-r3",
    "body": "......",
    "publishedAt": 1671869068000,
    "artifacts": [
      {
        "name": "libs.tar.gz",
        "createAt": 1671880478000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 59457142,
        "downloadId": 11
      },
      {
        "name": "libs.tar.gz.md5",
        "createAt": 1671880482000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 46,
        "downloadId": 12
      },
      {
        "name": "libs.tar.gz.sha256",
        "createAt": 1671880481000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 78,
        "downloadId": 13
      },
      {
        "name": "powernukkitx.jar",
        "createAt": 1671880476000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 6126522,
        "downloadId": 14
      },
      {
        "name": "powernukkitx.jar.md5",
        "createAt": 1671880481000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 51,
        "downloadId": 15
      },
      {
        "name": "powernukkitx.jar.sha256",
        "createAt": 1671880480000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 83,
        "downloadId": 16
      }
    ]
  },
  {
    "name": "1.19.50-r2",
    "tagName": "1.19.50-r2",
    "body": "......",
    "publishedAt": 1670240206000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "1.19.50-r1",
    "tagName": "1.19.50-r1",
    "body": "......",
    "publishedAt": 1669858989000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "1.19.40-r3",
    "tagName": "1.19.40-r3",
    "body": "......",
    "publishedAt": 1668232836000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "1.19.40-r2",
    "tagName": "1.19.40-r2",
    "body": "......",
    "publishedAt": 1667036210000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "1.19.40-r1",
    "tagName": "1.19.40-r1",
    "body": "......",
    "publishedAt": 1666783722000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "1.19.31-r1",
    "tagName": "1.19.31-r1",
    "body": "......",
    "publishedAt": 1666263368000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "1.19.30-r2",
    "tagName": "1.19.30-r2",
    "body": "......",
    "publishedAt": 1665066846000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "1.19.30-r1",
    "tagName": "1.19.30-r1",
    "body": "......",
    "publishedAt": 1663755797000,
    "artifacts": [
      {
        "name": "libs.tar.gz",
        "createAt": 1664700974000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 80867326,
        "downloadId": 59
      },
      {
        "name": "libs.tar.gz.md5",
        "createAt": 1664700978000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 46,
        "downloadId": 60
      },
      {
        "name": "libs.tar.gz.sha256",
        "createAt": 1664700977000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 78,
        "downloadId": 61
      },
      {
        "name": "powernukkitx.jar",
        "createAt": 1664700974000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 5903845,
        "downloadId": 62
      },
      {
        "name": "powernukkitx.jar.md5",
        "createAt": 1664700977000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 51,
        "downloadId": 63
      },
      {
        "name": "powernukkitx.jar.sha256",
        "createAt": 1664700977000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 83,
        "downloadId": 64
      }
    ]
  },
  {
    "name": "1.19.21-r4",
    "tagName": "1.19.21-r4",
    "body": "......",
    "publishedAt": 1662723748000,
    "artifacts": [
      {
        "name": "libs.tar.gz",
        "createAt": 1663123955000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 80869515,
        "downloadId": 65
      },
      {
        "name": "libs.tar.gz.md5",
        "createAt": 1663123959000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 46,
        "downloadId": 66
      },
      {
        "name": "libs.tar.gz.sha256",
        "createAt": 1663123958000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 78,
        "downloadId": 67
      },
      {
        "name": "powernukkitx.jar",
        "createAt": 1663123955000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 5748546,
        "downloadId": 68
      },
      {
        "name": "powernukkitx.jar.md5",
        "createAt": 1663123959000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 51,
        "downloadId": 69
      },
      {
        "name": "powernukkitx.jar.sha256",
        "createAt": 1663123958000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 83,
        "downloadId": 70
      }
    ]
  },
  {
    "name": "1.19.21-r3",
    "tagName": "1.19.21-r3",
    "body": "......",
    "publishedAt": 1662029358000,
    "artifacts": [
      {
        "name": "libs.tar.gz",
        "createAt": 1662029768000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 80869457,
        "downloadId": 71
      },
      {
        "name": "powernukkitx.jar",
        "createAt": 1662029767000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 5705659,
        "downloadId": 72
      }
    ]
  },
  {
    "name": "[545]1.19.21-r2",
    "tagName": "1.19.21-r2",
    "body": "......",
    "publishedAt": 1661356021000,
    "artifacts": [
      {
        "name": "libs.tar.gz",
        "createAt": 1661356389000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 80869947,
        "downloadId": 73
      },
      {
        "name": "powernukkitx.jar",
        "createAt": 1661356388000,
        "expiresAt": 9223372036854775807,
        "sizeInBytes": 5671541,
        "downloadId": 74
      }
    ]
  },
  {
    "name": "[545]1.19.21-r1",
    "tagName": "1.19.21-r1",
    "body": "......",
    "publishedAt": 1661305751000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "[544]1.19.20-r5",
    "tagName": "1.19.20-r5",
    "body": "......",
    "publishedAt": 1660827696000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "[544]1.19.20-r4",
    "tagName": "1.19.20-r4",
    "body": "......",
    "publishedAt": 1660443151000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "[544]1.19.20-r3",
    "tagName": "1.19.20-r3",
    "body": "......",
    "publishedAt": 1660395512000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "[544]1.19.20-r2",
    "tagName": "1.19.20-r2",
    "body": "",
    "publishedAt": 1660359317000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "[544]1.19.20-r1",
    "tagName": "1.19.20-r1",
    "body": "......",
    "publishedAt": 1660120182000,
    "artifacts": [
      // ......
    ]
  },
  {
    "name": "[534]1.19.10-r1",
    "tagName": "1.19.10-r1",
    "body": "......",
    "publishedAt": 1659876654000,
    "artifacts": [
      // ......
    ]
  }
]
```