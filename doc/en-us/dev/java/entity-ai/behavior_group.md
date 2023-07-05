# Chapter 6 Behavior Groups - Collections of Components

_**author: daoge_cmd**_

**The translation made by AzaleeX contributed to the PowerNukkitX documentation**  

## 1.0 Containers for all components

In fact, the behavior group ```BehaviorGroup``` is not just a container for behaviors, but actually contains all the logical components of a class of creatures, and the behaviors presented in this chapter are only some of its components. A complete behavior group contains:

- Behavior, Core Behavior
- Memory Storage
- Sensor
- Pathfinder
- Controller

### 1.0.1 A complete AI

The behavior group contains all components, i.e. the behavior group forms a complete AI

The creature is initialized with one call to ```requireBehaviorGroup()``` method, which returns an instance of the behavior group that will accompany the creature for its entire lifetime

By overriding the ```requireBehaviorGroup()``` method of the ```EntityIntelligent``` class and returning its own behavior group instance, the creature can obtain its own AI

### 1.0.2 Singularity

For each creature, there is only one instance of the behavior group in its life cycle

## 1.1 Create a new behavior group

Let's turn our attention to ```BehaviorGroup``` on the constructor of:

```java
@Builder
public BehaviorGroup(int startRouteUpdateTick, Set<IBehavior> coreBehaviors, Set<IBehavior> behaviors, Set<ISensor> sensors, Set<IController> controllers, SimpleRouteFinder routeFinder) {
    //This parameter is used to stagger the time of each entity path update to avoid submitting too many path update tasks in 1gt
    this.currentRouteUpdateTick = startRouteUpdateTick;
    this.coreBehaviors = coreBehaviors;
    this.behaviors = behaviors;
    this.sensors = sensors;
    this.controllers = controllers;
    this.routeFinder = routeFinder;
    this.initPeriodTimer();
}
```

Constructors with```@Builder```annotation, we recommend that you use Builder to initialize the object

