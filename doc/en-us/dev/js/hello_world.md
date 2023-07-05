# HelloWorld  

In this chapter, I will take you to create your first js plugin. 

## Plugin Format  

A JS plugin is the contents of a folder starting with `@` in the `plugins` folder.  
Each JS plugin needs to contain the `plugin.yml` configuration file and at least one `js` file, and can contain any number of arbitrary files and folders.  
Specific formatting instructions can be found in the [plugin format](../插件格式.html) section. **It is highly recommended that you read the plugin format chapter carefully**

## Create plugin.yml

> Again, the `@dir` folder refers to the plugin folder you created

Create the `plugin.yml` configuration file in the `@dir` folder and fill in the basic information of the plugin in it.

```yaml
name: HelloWorld
main: index.js
version: "1.0.0"
api: ["1.0.13"]
load: POSTWORLD
author: Please replace the characters in this line with your name
description: The first HelloWorld plugin
```

## Create js file  

We just specified our js entry file called `index.js` in the `main` field in `plugin.yml`, now we create a js file called `index.js` in the `@dir` folder.

```js
console.log("Hello World")

export function main() {
	console.warn("Hello World")
}

export function close() {
	console.error("Hello World");
}
```

The above code will output `Hello World` in the console as `INFO`, `WARN` and `ERROR` when the server starts, when the server starts initializing the plugin, and when the server is closed respectively.

> PNX JS adheres to the ESM (EcmaScript Module) specification, so you need to write in compliance with the ESM specification  
> Functions that need to be called externally should include the `export` keyword  
> You can find more information about ESM at [here](https://zhuanlan.zhihu.com/p/400573436)

## Some explanations  

The entire JS code will be loaded when the server is first started, so be sure to keep in mind that **most game-related content such as listening for events, generating items, manipulating the map, controlling creatures, etc. cannot be done at the very beginning! **

The `export main` function will be called after the PNX server has been initialized, and you can perform game-related operations when this function is called and thereafter.  
The `export close` function will be called when the PNX server is shut down or when your plugin is uninstalled, when you should do some cleanup work.

