# Basic knowledge

This chapter will take you through some of the most basic knowledge of developing PNX plug-ins.

## ES、JS、ECMA、ECMAScript、JavaScript？  

Many newcomers have heard of these names above but are not sure, so here are some clarifications on them.  

### JS、JavaScript  

You may have guessed that JS is short for JavaScript, JavaScript has little to do with Java, simply because the people who developed JS back then and the people who developed Java
There was ~~ business mutual blow ~~ cooperation, when Java was on fire, the fledgling JS only "borrowed" the name of Java.

### ES、ECMA、ECMAScript  

Let's start with ECMAScript, which, like JS, is another name for JavaScript and the official name for JavaScript.  
JavaScript was later controlled by ECMA (European Computer Manufacturers Association) and this scripting language was naturally called ECMAScript.

Now, when we usually talk about ES, we mean two things:
1. ES is short for ECMAScript, or JavaScript
2. because ECMA releases a new standard each time it revises the JS language, named after ES + version number, it can also refer to a particular version of JS

## JS syntax

The JS syntax used in PNX-JS is that of ES13, the new 2022 revision of JS.  
One thing worth noting is that JavaScript is forward compatible, which means that all code from older versions can be used in newer versions.

Of course, our development still primarily uses ES6 (the 2015 revised JS syntax), and you only need to understand ES6 to start developing JS plugins.

If you don't know JS syntax yet, we recommend checking out the simple [ECMAScript tutorial](https://www.w3cschool.cn/ecmascript/) here,
You don't need to read or memorize it all, just read the basic chapters, follow the PNX-JS tutorials and learn by doing, and go back to the ES tutorials if you don't know what you're doing.

## ESM Module 

The PNX plug-in uses the ESM (ECMA Script Module) module system to organize the code, which ensures good coupling and high reusability of the code. For details on ESM
You can learn it [here](https://zhuanlan.zhihu.com/p/400573436) and here is a brief explanation in the context of PNX-JS in practice:

Each PNX-JS plugin is composed of several modules, and each JS plugin is a separate module. By default all functions and variables in each module are not visible in
are not visible in other modules (they cannot be used outside this js file), so if we want to use it, we need to mark it as exported first, and for each module we need to
To export functions or variables in each module, we just need to add the `export` keyword to the declaration, e.g., this *lib.js*: `export` keyword:

```js
function myFunc1() {
    // 这个函数
}

export function myFunc2() {
    // 这个函数被导出了，可以在外部使用
}

// 这个变量没有被导出，只能在这个文件内部使用
var a;

// 这个变量被导出了，可以在外部使用
var b;
```

where the entry module of a JS plugin will be specified in `plugin.yml`, and the PNX server assumes that this module must export a `main` function and a `close` function.
The PNX server will call them at specific times, as described in [previous chapter](. /HelloWorld.html).

To use content exported by other modules, it's not enough to simply mark it as exported, you also need to add an import declaration to the module you want to use it in, e.g. we have an *index.js* file
which is in the same directory as `lib.js` mentioned above:

```js
// Import myFunc2 functions and b variables from lib.js
import { myFunc2, b } from "lib.js";

//Now we can use the imported functions and variables
myFunc2();
console.log(b);
```

Of course, PNX also provides some built-in modules, which usually start with `:` and you can import them directly, e.g:

```js
import { PowerNukkitX } from ":powernukkitx";
```

PNX also provides the ability to import Java classes directly. A Java class is a module, e.g:  

```js
import { Player } from "cn.nukkit.Player";
```

Importing Java classes will be the most used import in future development. Any Java class in Java can be imported, including those that come with Java, those in PNX and those in other Jar package plugins.

In the above example, we imported the `Player` class, each Java class has a direct class name and a full class name, the direct class name is the name of the class itself, such as
The direct class name is the name of the class itself, like the `Player` we mentioned above, and the full class name is the package name of the class plus the direct class name, for `Player`, its package name is `cn.nukkit`, so the full
The class name is `cn.nukkit.Player`, the package name is similar to a folder, except that it is a folder-like way of classifying files inside a Jar package.

When importing Java packages, the imported module name can be directly written with the full class name.

You can view the contents of the relevant Java classes in JavaDoc. If there are more things you don't understand, you can check out the [Module Details chapter](. /modules.html).

## Understand the name 

PNX's APIs are named as much as possible by sight, so that when you see a function or variable you immediately know roughly what it does.

For example, if the name of a function is `getAndKillEntity`, we can split the name of this function into get, and, kill, and entity in capital letters.
Four words, translated word by word as get, and, kill, entity, linked together is to get an entity and kill it, so that the function's role can be deciphered.

Another example is that there is an event named `PlayerJoinEvent`, which can be decomposed into player, join, event, and translated word by word as player enter event.
is the player into the service event, then you can know that this event will be triggered when the player enters the server.

> We will talk about the details of the event in a later chapter, so we don't need to understand it thoroughly here.

## Basic concepts in MC 

### Game Engraving 

In MC, including PNX, the game is run in game quarters, and the PNX completes the entire game once in each game quarter. Game quarters are also called GTs or ticks.

tps (Tick per second) refers to how many game moments per second, normally, the server performs 20 game moments per second for the game, i.e. the value of tps is normally 20, which also means that the duration of each tick is 0.05 seconds, i.e. 50 milliseconds.
However, in the case of insufficient server performance, the server will take more than 50 milliseconds to execute a tick. However, the next game tick needs to wait until the execution of the previous game tick is finished, so the tps will drop, all the content in the game will be slowed down, and the player will feel lag.

### Entity

The full class name for entities is `cn.nukkit.entity.Entity`.

Entity refers to an independent unit in the game that is free to move, in the usual sense including vehicles (mine carts, boats, etc.), creatures, players, drops, projectiles (arrows, eggs, snowballs, etc.)
and experience orbs.

Each entity has its own entity network ID (numeric ID), string ID, entity name, blood, location (coordinates) and NBT, and some entities also have item bars and AI, etc.

Each entity performs a complete computational process every tick, including calculating movement, coordinates, AI and some other behaviors.

### Item 

The full class name of the item is `cn.nukkit.item.Item`.

Item means an item in the form of an item pile, usually an item in that state in the item bar (backpack, chest, etc.), and an item thrown out and dropped to the ground is a drop entity rather than
We are talking about items here.

Each item has its own numeric ID, string ID, quantity and special value, some items have NBT. numeric ID is no longer recommended, please try to use string ID. 

### Block

The full class name for a block is `cn.nukkit.block.Block`.

A block refers to a component of a world that exists in the world and can be destroyed, placed, or used.  
Blocks in the item bar are items, and blocks in the form of drops are entities.

### Inventory

The full class name of an item bar is `cn.nukkit.inventory.Inventory`.

An item bar is a virtual container that can hold items, either associated with a real container cube, such as a chest item bar, a furnace item bar, etc., or with
It can also be associated with an entity that can hold items, such as a player item bar (backpack space).

### World

A world is a map or archive as it is usually called. PNX comes with multiple worlds, and there can be up to 2.1 billion worlds on a server.

The full class name of a world is `cn.nukkit.level.Level`.

The concept of world is different from the concept of dimension, which is a kind of world. Each world has a dimensional property, and multiple worlds may have exactly the same dimensional property.
Similarly, each dimensional property can correspond to multiple worlds. In short, a PNX server can have multiple main worlds, lower worlds or endlands.
