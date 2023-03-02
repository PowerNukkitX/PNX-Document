# 下载API

下载API是PNX提供的用于下载文件的API，要下载的文件通过`downloadID`指定，您可以通过其他API，
如GitAPI等获取。

## 下载文件

根据给出的`downloadID`下载对应的文件。被下载的文件会由服务器缓存，如果文件已经被缓存，将直接高速返回缓存文件。
如果没有被缓存，将通过HTTP代理模式将文件转发给客户端并同时缓存。

url:

- /download/{downloadID}

参数:

- downloadID: 文件ID

返回示例:

```text
HTTP/2 200 OK
Content-Type: text/plain
被下载的文件
```

## 文件ID是否存在

判断给出的`downloadID`是否存在。

url:

- /download/has/{downloadID}

参数:

- downloadID: 文件ID

返回示例:

```json
{
  "hasId": false
}
```

## 文件是否已被缓存

判断给出的`downloadID`对应的文件是否已被缓存。

url:

- /download/isCached/{downloadID}

参数:

- downloadID: 文件ID

返回示例:

```json
{
  "isCached": false
}
```

## 获取文件源地址

如果文件是从第三方获取的（如GitHub），可以通过此API获取文件的源地址。

url:

- /download/rawURL/{downloadID}

参数:

- downloadID: 文件ID

返回示例:

```json
{
  "url": "https://github.com/PowerNukkitX/PowerNukkitX/releases/download/1.19.62-r1/libs.tar.gz.sha256"
}
```

## 解压文件并获取文件列表  

解压给出的`downloadID`对应的文件，并返回解压后压缩包的文件列表，包括文件信息、校验码及`downloadID`。  

**该API为延迟返回API。**

url:

- /download/decompress/{downloadID}

参数:

- downloadID: 文件ID

返回示例:

```json5
{
  "target/libs/jopt-simple-5.0.4.jar": {
    "fileName": "target/libs/jopt-simple-5.0.4.jar",
    "size": 78146,
    "lastUpdateTime": 1677741336151,
    "md5": "eb0d9dffe9b0eddead68fe678be76c49",
    "downloadID": 30
  },
  "target/libs/sentry-log4j2-4.3.0.jar": {
    "fileName": "target/libs/sentry-log4j2-4.3.0.jar",
    "size": 5495,
    "lastUpdateTime": 1677741335663,
    "md5": "acf7cffad997735786a284ffc5164957",
    "downloadID": 69
  },
  "target/libs/guava-30.1.1-jre.jar": {
    "fileName": "target/libs/guava-30.1.1-jre.jar",
    "size": 2874025,
    "lastUpdateTime": 1677741335751,
    "md5": "05374f163d0a4141db672fff9df95b12",
    "downloadID": 48
  },
  // ......
  "target/libs/jline-reader-3.21.0.jar": {
    "fileName": "target/libs/jline-reader-3.21.0.jar",
    "size": 171621,
    "lastUpdateTime": 1677741336159,
    "md5": "3fd7c434561cbdd6e3d76b9d83d30393",
    "downloadID": 54
  },
  "target/libs/netty-transport-native-kqueue-4.1.77.Final-osx-x86_64.jar": {
    "fileName": "target/libs/netty-transport-native-kqueue-4.1.77.Final-osx-x86_64.jar",
    "size": 25757,
    "lastUpdateTime": 1677741336159,
    "md5": "797067286fbd7d11f874df34d73bdb98",
    "downloadID": 63
  },
  "target/libs/js-scriptengine-22.2.0.jar": {
    "fileName": "target/libs/js-scriptengine-22.2.0.jar",
    "size": 66505,
    "lastUpdateTime": 1677741336023,
    "md5": "e71ffc37c2ea416642721c3fed76efb6",
    "downloadID": 79
  }
}
```
