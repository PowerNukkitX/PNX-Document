# Chapter 2: Memory - The Hippocampus of the Entity

_**author: daoge_cmd**_

**The translation made by AzaleeX contributed to the PowerNukkitX documentation**

## 1.0 Memory type and memory

For a creature, there is not only behavioral logic, but also some real-time data during its life cycle. For example, for a sheep, if it finds a player with wheat in its hand nearby and tries to move over, its "mind" should store the "memory" of the corresponding player. For example, for zombies, if they want to attack the nearest player, they first need to write the memory of the corresponding player to their "mind". This way the pathfinder, attack actuator, controller and other components can work properly according to the data and achieve the target behavior

We call each of the above "data" a memory type```MemoryType```. One of the sheep corresponding to the memory is```NEAREST_FEEDING_PLAYER``` (recently fed to players), the zombie counterpart is```ATTACK_TARGET```(Hate target)

"The "mind" is the memory memory```MemoryStorage```，The concept is well understood, each instantiated entity has a separate memory, and all memories of the entity are stored in the memory

### 1.0.1 Create a new memory type

The available constructors for MemoryType are as follows: 

![](../../../../image/entity-ai/22c4fc46.png)

To create a new memory, we need to provide a namespace identifier```Identifier```and memory defaults (default values are returned when attempting to retrieve the value of a non-existent memory from memory, either as constants or by providing```Supplier<Data>```(dynamically generated)

The namespace identifier is the "identity card" for each memory type, and the namespace used internally by the PNX core is```minecraft:```，If you want to add a new memory type to the plug-in, please use a different type than```minecraft:```namespace to avoid duplication

All memory types used by the core are stored in the interface```cn.nukkit.entity.ai.memory.CoreMemoryTypes```

## 1.1.0 Universality

For attributes that have the same meaning (e.g. hate target) used by different entities, we should try to make them use the same memory type. This way, if we want the zombies to attack the bitter enemies, we can set their "hate targets" to each other.

### 1.1.1 Connecting different components

In fact, memory not only provides information for behavior, it also acts as a bridge between components. Several motion controllers by default, for example, do this by reading```MOVE_DIRECTION_START```、```MOVE_DIRECTION_END```and other memory moving entities, the pathfinder moves by reading```MOVE_TARGET```Calculate the path.

Through memory storage, different simple components are seamlessly linked together, enabling complex behavior of entities

## 1.2.0 Saved as an attribute or saved as a memory ?

For entity data (life value, attack damage, hate target, rage status, etc.), you can choose to store it directly on the entity class as an attribute and abstract it with the interface```getter/setter```. You can also choose to keep it in the entity memory as MEMORY. Shouldn't all data be saved into memory then ?

After reading the above, you may think that it should all be stored in memory, however, this is not necessarily good.

For **entity base properties**, such as blood, life, attack damage, etc., we specify that they should be saved as properties of the entity class and abstracted using the interface

For **entity runtime properties**, such as warden's rage value, entity pathfinding target, hate target, etc., we specify that they should be saved into memory

If you still can't tell the difference correctly, we have a simple way to determine if the property should be saved after the entity lifecycle has ended (simply put, close() dropped). If it should be saved, you should save it as a property of the entity class instead of memory



