# 常见开发问题  

## 1. invokeMember (getDamager) on cn.nukkit.event.entity.EntityDamageEvent failed due to: Unknown identifier: getDamager  

这是由于错误地把`EntityDamageEvent`事件当作`EntityDamageByEntityEvent`并执行了`getDamager`方法造成的，通常
是由于监听了`cn.nukkit.event.entity.EntityDamageByEntityEvent`，但是部分插件会混发事件造成的。  

解决方法：使用`instanceof`在事件回调函数中判断事件种类。  

```javascript
import { PowerNukkitX, EventPriority } from ":powernukkitx";
import { EntityDamageByEntityEvent } from "cn.nukkit.event.entity.EntityDamageByEntityEvent";

PowerNukkitX.listenEvent("cn.nukkit.event.entity.EntityDamageByEntityEvent", EventPriority.NORMAL, e => {
    if (e instanceof EntityDamageByEntityEvent) {
        // ......
    }
})
```

## 2. Server.getLevel返回null  

通常是由于以下两个问题造成的：  
- 在`main`函数开始执行之前调用
- `plugin.yml`中`load`字段填写了`STARTUP`而非正确的`POSTWORLD`

## 3. 导入其他JS插件的模块时的一些注意事项
PNXJS的每个JS插件都是一个独立的`Context`，这意味着，如果你使用`import`导入其他插件的模块时，会完全重新载入一次被导入的插件的模块。  
例如以下基于[LLSE-Lib](https://github.com/PowerNukkitX/LLSE-Lib)库编写的示例:  

观察以下代码，按照NK插件加载规则，APlugin插件会在BPlugin插件之前加载  
APlugin.js
```javascript
export var A;
console.log("this is A plugin");
onlyOnceExecute(()=>{
    A=123;
},"FCA1A72C-B62C-F6E6-1D49-4B1B5B0BC40C");
```

BPlugin.js
```javascript
import {A} from "APlugin.js";
console.log(A);
```
其中APlugin.js中的`console.log("this is A plugin");`会被执行两次，在加载APlugin时会输出一次，再加载BPlugin时，由于B插件导入了`APlugin`插件的A变量，这会在B插件的`Context`完全载入一次A插件，即又输出一次。

而其中的`onlyOnceExecute`来自[LLSE-Lib](https://github.com/PowerNukkitX/LLSE-Lib)库，就是为了解决该问题出现的。
`onlyOnceExecute`第一个参数传入一个回调函数，第二个参数传入一个UUID作为唯一标识符，这个回调函数只会执行一次，不管多少个插件导入该插件。

但是由于PNXJS的每个JS插件都是一个独立的`Context`，所以B插件导入了`APlugin`插件的A变量，A变量是没有初始化的，同时B插件的`Context`完全载入一次A插件，但是由于`onlyOnceExecute`全局只会执行一次，所以A变量在B插件的`Context`不会被初始化



