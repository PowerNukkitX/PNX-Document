# Chapter 3 Sensors - The Senses of the Entity

_**author: daoge_cmd**_

**The translation made by AzaleeX contributed to the PowerNukkitX documentation**


## 1.0 Obtaining information from the outside world

"When you approach a sheep, it looks at you."

Thinking about the above behavior flow, the sheep must first discover the presence of players nearby, and then activate the "look at the nearest player" behavior. In other words, the entity must have the ability to obtain information from the outside world

### 1.0.1 Use of sensors

Before touching the sensor, you might write the logic for detecting nearby players in the evaluator of the behavior to implement the above functionality. However, in fact we don't do that, we separate this logic to a component called ``Sensor``

The sensor interface is described as follows.

![](../../../../image/entity-ai/69236b0c.png)

```sense``` method contains the main logic of the sensor, e.g. the above logic for getting the nearest player should be written inside this method. The information obtained should be written to the entity's memory (although there are no code level restrictions)

```getPeriod``` method determines how many gt the sensor is called once and defaults to 1 (called every gt). Considering performance, it may be appropriate to stretch the call period of some sensors