# Event Listening

Events are one of the main ways plugins perform their work in PNX, and this section will take you through the process of learning to use PNX-JS for event listening by taking you through the creation of a simple blockword plugin.

## What is an event  

Whenever a specific action takes place in the server, an event object is generated. This object serves as a description of the behavior or action that occurred, such as a player logging in, a player leaving, or a player sending a message. Each type of behavior or action corresponds to an event object, which carries essential information related to that behavior or action. For instance, the event object may include details such as the player responsible for the event, the content of the message sent, and so on. Additionally, the player object encompasses various attributes, including the player's location, life value, item bar, and more.

Plugins can register **listeners** with PNX to react to events as they occur. Each event object contains a description of the event, and usually the event listener is called before the event occurs.
At this point the listener can prevent the event from actually happening by cancelling it, if no event listener cancels the event, then it will actually happen within the game.
The execution of listeners is single-threaded, all listeners are given its priority to PNX when they are registered, and PNX will sort the listeners by priority and then execute the listeners in order.
It is likely that this event will have been cancelled between the time your plugin's listener is executed, but this usually does not affect the execution of your listener, which will still be executed, and you can get it to work with the
`event.isCancelled()` to determine if the event has been cancelled (more on this later).
**Special note is that the higher the priority, the further back in the execution order you go. That is, the lower the priority, the higher the execution priority! **   
~~*Why not the higher the priority, the higher the priority, you ask? I think so too, but that's how NKX is strangely designed, and we had to make this anti-human compromise to be compatible with the NK ecosystem *~~.

The listener participates in the event process as shown in the following flow:

![PNX事件流程图](../../../image/js_tutorial/PNX事件流程图.svg)  

PNX provides a very large number of events that you can use in the [Event List](../res/event_list.html) in the table. Each event in the table is labeled with the name of the category of the event.
You can use this class name in the plug-in to listen to this event, and click on the class name to go to the corresponding JavaDoc for more details.

## Register an event listener

In PNX-JS, registering event listeners is done through the`:powernukkitx`in the built-in module`PowerNukkitX`to perform, a simple template is provided below:

```javascript
import { PowerNukkitX, EventPriority } from ":powernukkitx"; //PowerNukkitX and EventPriority are both in the :powernukkitx built-in module

// Registering event listeners can only be done in the main function or after the main function has been executed
export function main() {
    PowerNukkitX.listenEvent("cn.nukkit.event.Event", //The string here writes the class name of the event, which is available in the event cross-reference table
        EventPriority.NORMAL, // The priority of the listener, there are LOWEST LOW NORMAL HIGH HIGHEST MONITOR six levels, LOW first, MONITOR last
        event => { // The event parameter of this arrow function is the event object, the type of which is the class of the event you wrote above
        // Event Handling Code
    })
}
```

`:powernukkitx`module provides a series of the most basic functions required by the server plug-in, such as registering event listeners, registering functions and so on, the details of which can be seen in
[powernukkitx built-in module JSDoc](../inner-module/powernukkitx.html) 。  

## Implement the function to prohibit swearing

Here, we register a [cn.nukkit.event.player.PlayerChatEvent](https://javadoc.io/doc/cn.powernukkitx/powernukkitx/latest/cn/nukkit/event/player/PlayerChatEvent.html)
*(PlayerChatEvent)* to listen for events where the player sends a message in the chat box and detect if the player has sent an expletive, and if so, cancel the event so that the player cannot
send the message with the expletive.

```javascript
export function main() {
    PowerNukkitX.listenEvent("cn.nukkit.event.player.PlayerChatEvent", EventPriority.NORMAL, event => {
        
    })
}
```

First, we should determine whether the event has been cancelled or not. If the event has been cancelled by other plugins, we don't need to make another determination.

```javascript
export function main() {
    PowerNukkitX.listenEvent("cn.nukkit.event.player.PlayerChatEvent", EventPriority.NORMAL, event => {
        if (event.isCancelled()) {
            return;
        }
    })
}
```

As we can see by checking the JavaDoc of the player chat event *(clickable link in the event cross-reference table)* , it inherits from the `cn.nukkit.event.Event` class, so
It also has the `isCancelled` function *(check if this event is cancelled) * and the `setCancelled` function *(cancel this event) *.

> The JavaDoc has the following sections:  
> Methods inherited from class cn.nukkit.event.  
> getEventName, isCancelled, setCancelled, setCancelled

Next, we get the message sent by the player in the event, determine if it contains the expletive `fuck`, and cancel the event if it does.

```javascript
export function main() {
    PowerNukkitX.listenEvent("cn.nukkit.event.player.PlayerChatEvent", EventPriority.NORMAL, event => {
        if (event.isCancelled()) {
            return;
        }
        if (event.getMessage().includes("fuck")) { // 检测消息中是否有fuck
            event.setCancelled();
        }
    })
}
```

Checking the JavaDoc of the player chat event, we can see that it has a method called `getMessage`, which is broken down into `get` and `Message` according to the look-alike method we mentioned before.
`Message`, i.e. `get` and `message`, linked together is `getMessage`, the JavaDoc above says it returns `String`, which is a string, so we can probably determine that
This function can get the message sent by the player from the event. Such a process will not be repeated later, I hope you have mastered.

Not only do we want to keep the player from sending out, but we also want to let the player know that he is not networked out but because he has been banned from sending profanity, and we want to give the player some hints that

```javascript
export function main() {
    PowerNukkitX.listenEvent("cn.nukkit.event.player.PlayerChatEvent", EventPriority.NORMAL, event => {
        if (event.isCancelled()) {
            return;
        }
        if (event.getMessage().includes("fuck")) {
            event.setCancelled();
            event.getPlayer().sendMessage("No swearing");
        }
    })
}
```

Checking the JavaDoc for the player chat event shows that the `getPlayer` method returns the player for this event, next, we can click on the method return value in the JavaDoc.
That is a link to the JavaDoc document of the type of the returned value, in [cn.nukkit.Player](https://javadoc.io/doc/cn.powernukkitx/powernukkitx/latest/cn/nukkit/Player.html)
In the JavaDoc of the player class, we find the `sendMessage` function, which is used to send messages to the player.
will usually only work on this object, which means that if we use the `sendMessage` function on this player object, only this one player will receive the message.

At this point, our plug-in is initially complete. Next we need to write plugin.yml, etc., and install the plug-in into the server for testing.

## Install the plugin and test it  

Writing plugin.yml is simple, you can follow [Plug-in format chapter](../插件格式.html).
After writing, copy your js code and yml file to a folder named with `@` plus the name of your plugin under the `plugins` folder and restart the server to test it in the service.

If you type `fuck xxx` into your chat box and you get a `no swearing` message, then your plugin worked!

## Get all codes  

All the full code and complete plugins for this section are available on the Github repository [ObscenityDefender](https://github.com/PowerNukkitX/ObscenityDefender)
