# Flat World  

PNX has a built-in flat world generator that can be highly customized. 
You can generate the world you want by modifying the configuration file.  

## Configure  

In the world configuration of nukkit.yml, you can set a generator for each world separately. 
For example, here we set a FLAT generator for the world named world:  

```yaml
worlds:
 world:
  seed: 114514
  generator: FLAT:2;7,59x1,3x3,2;1;decoration
```

## Generator Parameters  

Generator parameters consist of multiple parts separated by semicolons, each part separated by a colon, for example:  

```yaml
generator: FLAT:2;7,59x1,3x3,2;1;decoration
```

Generator parameters ending with the word "decoration" will generate minerals on the map.  

