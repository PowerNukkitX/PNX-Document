# Chapter 7 Work cycle

_**author: daoge_cmd**_

**The translation made by AzaleeX contributed to the PowerNukkitX documentation**

After understanding all the components, let's finally examine the AI work cycle

## 1.0 What is the work cycle

Before we start the content, let's clarify the concept of work cycle

The work cycle, similar to the game engraving ```gametick```, in which the AI completes a work cycle includes, but is not limited to, the following:

- Acquiring sensor data
- Calculating behavior priority, tick behavior, core behavior
- Running the motion controller
- Update the path
- ......

All work is done in parallel and we need to continue with the source code by describing:

## 1.1 asyncPrepare() Methods

The ```asyncPrepare()``` method runs in parallel between entities. Its completes the entirety of a work cycle

The details are as follows:

```java
public class EntityIntelligent{

    /**
     * Other methods are omitted here
     */
    
    @Override
    public void asyncPrepare(int currentTick) {
        // Calculate if active
        isActive = level.isHighLightChunk(getChunkX(), getChunkZ());
        if (!this.isImmobile()) { // immobile will disable entity AI
            var behaviorGroup = getBehaviorGroup();
            if (behaviorGroup == null) return;
            behaviorGroup.collectSensorData(this);
            behaviorGroup.evaluateCoreBehaviors(this);
            behaviorGroup.evaluateBehaviors(this);
            behaviorGroup.updateRoute(this);
            behaviorGroup.tickRunningCoreBehaviors(this);
            behaviorGroup.tickRunningBehaviors(this);
            behaviorGroup.applyController(this);
            if (EntityAI.checkDebugOption(EntityAI.DebugOption.BEHAVIOR)) behaviorGroup.debugTick(this);
        }
        super.asyncPrepare(currentTick);
    }
}
```

To organize, we can summarize what is done successively in a work cycle:

- 1 Collect sensor information (call the ```sense()``` method of the registered sensors)
- 2 Call the evaluator of all core behaviors
- 3 Call the evaluator for all behaviors
- 4 Update the paths
- 5 Run the actuator that activates the core behavior
- 6 Run the actuator that activates the behavior
- 7 Calling the motion controller
- [Debug] 8 debugTick

## 1.2 Off-topic: About debug mode

The framework has a "DEBUG mode" in which the creature name will show the current behavior and when you take the stick and right click on the entity a pop-up window will appear showing information about the entity

You can enable debug mode by setting ```debug.commands``` in ```nukkit.yml``` to ```true``` and using the command ```/debug entity <option> true``` in-game
