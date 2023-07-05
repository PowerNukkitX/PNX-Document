# Configuring the development environment  

In this chapter, I will take you through the configuration of the PNX JS development environment.

## Installation of PNX server 

To start developing the PNX server, you need to first install the PNX server as a test service, which you can do in[Quick Start](../../../Get_Started.html)
chapter to see how to install it, so I won't go over it here.  

## Ensure access to test suits  

If you are developing a plugin, you will definitely need to test the plugin and you need to make sure you can access your test server using the mc client. 

### Remote Test Server  

Add your remote server IP address and port to your mc client, and then access your test server.

### Local test server  

We recommend you to use a local test server to be able to better utilize the related tools for development debugging.  
Open the command line and start the PNX server with PNX-CLI, then enter the IP `127.0.0.1` and the corresponding port in your mc client to access your test server.

Special reminder:  
If you are using Windows, you may need to remove the UWP local loopback restriction by [click here to view](https://www.mcbbs.net/thread-719888-1-1.html) .

## Development in VsCode  

PNX provides you with good support for javascript/typescript plugin development in VsCode.

### One-click configuration using templates  

You can use the GitHub repository template to quickly generate a new configured plugin project using:

- [JavaScript Plugin Template](https://github.com/PowerNukkitX/JavaScript-Template)
- TypeScript plugin template (*coming soon*)

You can create your own plugin repository by following the guidelines in the template repository, and then click the third button in Vscode, arranged vertically from top to bottom on the far left, to enter the source code management page.
Click the `Clone Repository` button, log in to your GitHub account, and pull the new plugin project you just generated locally to start development.

**Please note that you should follow the comment prompts in `plugin.yml` to make the appropriate changes!**

### Manual configuration from scratch

#### Create plug-in folder  

Find the `./plugins` folder and create your plugins folder in this folder, the folder name needs to start with `@`.
Next, we will use `@dir` to refer to the plugin folder you created in this step.

#### Adding a type definition file

The type definition file enables vscode to give you intelligent hints and error correction during plugin development, so it is highly recommended that you use the type definition file.

1. Create a `.header` folder under the `@dir` folder
2. [Click here](https://assets.powernukkitx.cn/stable/pnx.d.ts) to download the PNX built-in module type definition to the folder you just created
3. Use [PNX Bytecode Analysis Tool](https://www.powernukkitx.com/tools/jarInsight.html) to export and download the type definition of the core you are using to the folder you just created

> How to use the PNX Bytecode Analysis Tool?
> 1. [Open web page](https://www.powernukkitx.com/tools/jarInsight.html)
> 2. Click the `Select File` button and select the PNX Core Jar package. **Note that you should use a 4-5MB core jar package with no built-in dependency libraries, otherwise it will result in generating too large definition files that will crash Vscode. **
> 3. Click the `Save d.ts definition file` button to download the definition file and move it to the correct folder

4. Next, create a `jsconfig.json` file in the `@dir` folder and enter the following and save it:

```json
{
    "compilerOptions": {
        "allowJs": true,
        "module": "ES2022",
        "alwaysStrict": true,
        "lib": [
            "ES2015",
            "ES2016",
            "ES2017",
            "ES2018",
            "ES2019",
            "ES2020",
            "ES2021",
            "ES2022"
        ]
    },
    "include": [
        ".header/**/*.d.ts",
        "./**/*.js",
        "./**/*.ts"
    ]
}
```

> If a red wavy line appears below the words `ES2022`, `ES2021`, etc. and an error is reported, please try to update the Typescript version
> I am using `4.7.4` version, please update to the newer version by yourself, [update method](https://code.visualstudio.com/docs/typescript/typescript-compiling#_using-newer-typescript- versions)
 
## Congratulations on completion 🎉

At this point, you've finished building your development environment and are ready to start developing your first plugin!

