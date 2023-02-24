# 超平坦世界  

PNX内置可以高度自定义的超平坦世界生成器，您可以通过修改配置文件来生成您想要的世界。  

## 配置  

在nukkit.yml的worlds配置中，可以为每个世界单独设置生成器，例如这里为名为world的世界设置了超平坦生成器：  

```yaml
worlds:
 world:
  seed: 114514
  generator: FLAT:2;7,59x1,3x3,2;1;decoration
```

## 生成器参数  

生成器参数由分号分隔的多个部分组成，每个部分由冒号分隔，例如：  

```yaml
generator: FLAT:2;7,59x1,3x3,2;1;decoration
```

以decoration结尾的生成器参数将会在地图上生成矿物。  

