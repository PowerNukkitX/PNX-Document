# Common Development Issues  

## 1. invokeMember (getDamager) on cn.nukkit.event.entity.EntityDamageEvent failed due to: Unknown identifier: getDamager  

This is caused by mistakenly treating the `EntityDamageEvent` event as an `EntityDamageByEntityEvent` and executing the `getDamager` method, usually
It is caused by listening to `cn.nukkit.event.entity.EntityDamageByEntityEvent`, but some plugins will mix up the events.

Solution: Use `instanceof` to determine the event type in the event callback function.

```javascript
import { PowerNukkitX, EventPriority } from ":powernukkitx";
import { EntityDamageByEntityEvent } from "cn.nukkit.event.entity.EntityDamageByEntityEvent";

PowerNukkitX.listenEvent("cn.nukkit.event.entity.EntityDamageByEntityEvent", EventPriority.NORMAL, e => {
    if (e instanceof EntityDamageByEntityEvent) {
        // ......
    }
})
```

## 2. Server.getLevel returns null

This is usually caused by two problems:
- Calling the `main` function before it starts executing
- The `load` field in `plugin.yml` is filled with `STARTUP` instead of the correct `POSTWORLD`

## 3. Some considerations when importing modules from other JS plugins
Each PNX-JS plugin runs in a separate `Context`, which means that if you import a module of another plugin using `import`, it will completely reload the module of the plugin being imported once.  
For example, the following example is based on the [LLSE-Lib](https://github.com/PowerNukkitX/LLSE-Lib) library.

Observe the following code. According to the NK plugin loading rules, the APlugin plugin will be loaded before the BPlugin plugin
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
where the APlugin.js `console.log("this is A plugin");` will be executed twice, in the load APlugin will output once, and then load BPlugin, because the B plugin imported the `APlugin` plugin A variable, this will be in the B plugin `Context` completely loaded once A plugin which is output once again.

The `onlyOnceExecute` from the [LLSE-Lib](https://github.com/PowerNukkitX/LLSE-Lib) library is designed to solve this problem.
The first parameter of `onlyOnceExecute` passes a callback function and the second parameter passes a UUID as a unique identifier, and this callback function will only be executed once, no matter how many plugins import the plugin.

But since each JS plugin of PNXJS is a separate `Context`, the B plugin imports the A variable of the `APlugin` plugin, which is not initialized, while the `Context` of the B plugin loads the A plugin completely once, but since `onlyOnceExecute` will only be executed once globally, the A variable in the B plugin's `Context` will not be initialized


