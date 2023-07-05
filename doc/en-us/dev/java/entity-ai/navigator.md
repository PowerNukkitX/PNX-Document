# Chapter 5 Pathfinder - The brain of an entity

***author: daoge_cmd***

**The translation made by AzaleeX contributed to the PowerNukkitX documentation**


## 1.0 Calculation path

The pathfinder is responsible for calculating the path for the entity

For each entity, the pathfinder implementation must be provided

## 1.1.0 Getting Started: Using the right pathfinder for the entity

The framework provides two pathfinder implementations, namely:

- SimpleFlatAStarRouteFinder
- SimpleSpaceAStarRouteFinder

The former applies to land walking creatures and the latter to flying/submerged creatures

The specific difference is that the former is a 2D A\* implementation and the latter is a 3D A\* implementation

### 1.1.1 Waypoint Evaluator

After choosing a pathfinder implementation, we next need to provide a pathfinder point evaluator

The pathfinding point evaluator determines whether a coordinate point can be used as a valid path point (note: the path point is the position of the foot when the entity moves to this point)

By providing specific evaluators, we can customize the pathfinding logic. For example, we can make fish swim only in lava (laughs)

The seek point evaluator interface is as follows:

![image-20221215153546254](https://s2.loli.net/2022/12/15/5s3VWnGor7OK6pe.png)

Please note that **not both methods need to be overridden**, the method descriptions are specified as follows

```evalStandingBlock()```：

```
Returns whether this square can be used as a standing square underfoot, usually used for entities that return integer coordinate points (walking)
This square needs to be implemented only if this pathfinder using this evaluator returns only integer coordinate points.
```

```evalPos()```:

```
Returns whether the target coordinates are available as path points, usually used for entities that return non-integer coordinate points (flying and swimming)
This method needs to be implemented only if the pathfinder using this evaluator returns non-integer coordinate points.
```

Simply put:

If this evaluator is passed to the ```SimpleFlatAStarRouteFinder```, just override the ```evalStandingBlock()``` method and pass in the square that is vertically one square down from the path point

If this evaluator is passed to ```SimpleSpaceAStarRouteFinder```, just override the ```evalPos()``` method and pass in the coordinates directly to the path point

## 1.2 Operating the pathfinder

We do not need to operate the pathfinder directly to calculate the path. Similar to the controller, the pathfinder does its job by reading the memory

Of course, considering that operating the pathfinder should be a high-frequency operation, there are wrapped methods under the ```EntityIntelligent``` class for you to use directly:

```java
public Vector3 getMoveTarget() {
    return getMemoryStorage().get(CoreMemoryTypes.MOVE_TARGET);
}

public void setMoveTarget(Vector3 moveTarget) {
    getMemoryStorage().put(CoreMemoryTypes.MOVE_TARGET, moveTarget);
}
```

After setting the ```moveTarget```, the pathfinder will calculate the new path and output the result in the next few gt. If you have registered the motion controller ```WalkController```/```SpaceMoveController```, it will read in the data and move the entity through the calculated path to the ```moveTarget```.

If ```moveTarget``` is set to ```null```, this is equivalent to clearing the move target and the entity will stop moving (even if the path has been calculated)

### 1.2.1 Path update cycle

In the case that ```moveTarget``` is not empty, the pathfinder will recalculate the path every few gt (the period is related to whether the entity is a hot entity and the overall jamming level of the world).

The specific calculation formula is:

```java
var period = ROUTE_UPDATE_CYCLE + (entity.level.tickRateOptDelay << 1);
if(!entity.isActive()) period = period << 2;
```

### 1.2.2 Force immediate path update

Although not recommended, there are situations where we do need the route to be updated immediately

You can achieve this by calling ```IBehaviorGroup.setForceUpdateRoute(boolean)```.

Note, however, that overusing this method will lose the benefits of the pathfinding scheduler performance optimization and lead to performance degradation
