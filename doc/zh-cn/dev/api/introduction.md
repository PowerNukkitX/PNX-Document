# API简介  

PowerNukkitX项目为了各位能够更方便地自动化追踪PNX项目进展，并开展自动化更新等操作，为各位提供了这些Http API。  
若无特殊说明，HTTP方法默认为GET。  

此处列出的API目前仍处于不稳定状态，可能会随时更改。  

## APi地址  

[https://powernukkitx.com/api](https://powernukkitx.com/api)

## 概念  

### 延迟返回API  

此类API会在请求后立即返回一个只带有一个UUID的响应，此UUID用来标记此请求，实际的处理会在后台进行。
您需要轮询服务器此API是否完成，如果此API已完成，您将可以得到返回结果。  

详情请参阅[延迟返回API](delayed.html)
