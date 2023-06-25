# Mod API

_**author: Cool_Loong**_

**This series of articles is always written based on the latest commit version. You can find the latest PNX version
maven dependencies at [Jitpack](https://www.jitpack.io/#PowerNukkitX/PowerNukkitX).**

## 1. Custom Block API

Custom block related API are define under package `cn.nukkit.block.customblock`.  
A custom block you need to implement the CustomBlock interface, first let's see which methods in the CustomBlock
interface you need to implement.

### Must be implement/override

`double getNamespaceId()`  
Implement this method to set the namespace ID of the custom block,such as `minecraft:test`

`CustomBlockDefinition getDefinition()`  
Implement this method to provide a custom block description for the client, where CustomBlockDefinition is a Builder
class that provides a number of internal description methods

`String getName()`  
Override this method to implement getName() for a custom block, which must be overridden using the default method
provided by the interface  
The override uses the return value `return CustomBlock.super.getName();`

`int getId()`  
Override this method to implement getId() of the custom block, you must use the default method provided by the interface
to override it  
Override uses the return value `return CustomBlock.super.getId();`

### Optional implement/override

`double getFrictionFactor()`  
Implement this method to describe the friction factor of the custom block, the value ranges from 0 to 1, the smaller the
value the higher the friction

`double getResistance()`  
implement this method to set the explosion resistance of the custom block, the larger the value the stronger the
explosion resistance

`double getLightFilter()`  
Implement this method to set the light absorption level of the custom block, in the range of 0-15

`double getLightLevel()`  
Implement this method to set the level of light emitted by the custom square, in the range of 0-15

`boolean reverseSending()`  
Whether to reverse the order of parsing the properties of the custom box

### About getDefinition()

The role of `getDefinition()` is to provide the client with a description of the definition of the custom block, its
content is similar to addon, because it is a client-side definition, here we need to refer to addon tutorial, here we
suggest the following two sites to learn  
[MC bedrock development wiki](https://wiki.bedrock.dev/guide/introduction.html)
and [Microsoft documentation](https://learn.microsoft.com/en-us/minecraft/creator/reference/)

**Step 1: We first need to create the builder instance of CustomBlockDefinition using
the `CustomBlockDefinition.builder()` method.**

`CustomBlockDefinition.builder()` has a total of four overload methods, where the first parameter is an instance of the
custom block, just fill in `this`

Overload 1: `builder(CustomBlock customBlock, String texture)`
The texture parameter is the texture path of the custom block, which needs to be filled according to the corresponding
texture definition in the `textures\terrain_texture.json` resource package  
If you don't know what `terrain_texture.json` is, please check the two websites provided above.

Overload 2: `builder(CustomBlock customBlock, String texture, BlockCreativeCategory blockCreativeCategory)`  
BlockCreativeCategory is the category of the custom block in the client creation field, it is an enum

Overload 3: `builder(CustomBlock customBlock, Materials materials)`  
Materials is the material instance of the custom block, it can describe the material of the custom block on different
sides, and the rendering method, which corresponds
to [addon](https://learn.microsoft.com/en-us/minecraft/creator/reference/content/blockreference/examples/blockcomponents/minecraftblock_material_instances)
provides minecraft:material_instances

Overload
4: `builder(@NonNull CustomBlock customBlock, @NonNull Materials materials, BlockCreativeCategory blockCreativeCategory)`  
`Materials BlockCreativeCategory` same above

**Step 2: Add properties to the builder according to your needs**  
The following can be called:

`breakTime(double second)`
Control the time in seconds for the custom block to be mined on the client-side

`creativeGroup(String creativeGroup)`  
Control the group of custom block in the creation bar

`rotation(Vector3f rotation)`  
Set the rotation of the block around the center of the block in degree

`transformation(Transformation transformation)`  
Set the block rotation and scale and translation

` geometry(Geometry geometry)`  
Control the geometry of a custom block, which needs to be pre-defined in the material package, you can use BlockBench to
make the geometry of the block  
Geometry allows you to define whether each bone is displayed

`permutations(Permutation... permutations)`  
Control the change characteristics of custom squares, you can specify molang expressions to achieve changes, for
example, query the state of the square according to molang to achieve changes in different square states.
The content of `Permutation` is a `Component` component and a `molang expression` that represents the use of the
corresponding `Component ` under the specified `molang expression`
`Component` is a composite component that contains the contents of all other components except `permutations`

`collisionBox(Vector3f origin,Vector3f size)`  
Set the client-side collision box for this block. Blocks that do not use a custom geometry model usually do not need to
use this method, since they are unit blocks

`selectionBox(Vector3f origin,Vector3f size)`  
Set the client selection box for this block, you don't usually need to use this method for block that doesn't use custom
geometry model, because it's a unit block

`clientFriction(float friction)`  
Set the client friction factor of this block, which represents the player's movement speed on the block.The larger the value, the faster the movement

**Step 3: build instance**
You can choose between two types of build, the default `build` and `customBuild`

`customBuild(Consumer<CompoundTag> nbt)`  
The custom build parameter accepts a consumer function, and you are free to modify the definition of the block that will
eventually happen to the client NBT (if modified incorrectly it may cause the custom block registration to fail)

### About digging time control for custom blocks

In the new version of the API, PNX implements server-side authoritative block destruction, which means that the server
side can be responsible for calculating the digging time of a custom block and when the block is dug up.  
You no longer need to override `calculateBreakTime` to control the digging time of custom blocks, if you do please
remove it, this may affect the server side calculation of the block digging time.  
You can use the following two ways to control the break time of a custom block:

Overriding `double getHardness()`  
which represents the block hardness, the default value of this method is `10` and it will be used by the server side to
calculate the block mining time

Use `CustomBlockDefinition.Builder#breakTime(double)`  
controls the time in seconds for the custom block to be mined on the client side (default value `999`)

**You may wonder why there are two methods to control the digging time of a custom block?**   
Using `getHardness` defines the hardness of the custom block, which allows the custom block to take different amounts of
time to dig when it is dug by different levels and types of tools. And
using `CustomBlockDefinition.Builder#breakTime(double)` defines the digging time of the custom block on the client side,
which is a fixed value.  
**The break time of the custom block depends on the minimum value of the break time on the server side and the client
side.**  
Typically, the client-side digging time is defined to take 999 seconds, so that the digging time of the custom block
depends only on the server-side calculation.
The hardness values can be chosen by referring to the hardness of other blocks inside PNX, which are `2` for wood, `5`
for iron, and `35` for obsidian

### About the friction of custom block
`clientFriction(float friction)` in `CustomBlockDefinition#builder` represents the client friction, which is used to control the speed at which the player walks on the custom block.The larger the value, the faster the movement.  
Override the `double getFrictionFactor()` in the `Block` class to represent the friction on the server side, which is used to control the speed that player drops item,entity walk and boat movement on the block.

### Custom block example

The following example implements a custom slab, where explanations are provided for each line of code.  
Since CustomBlock is the interface, you can `extends` any of the internal block classes of the core before implementing
a custom block, use their funtion.Or if you are not familiar with the internal implementation, you can choose
to `extends` the Block class.
Here you choose to `extends` the `BlockTransparentMeta` class, which means that the block is transparent.  
Note that a lot of comments, line breaks and some logical implementations are omitted below to save lines, if you want
to see the full source code and material package, you can go
to [AddonApi-ExamplePlugin](https://github.com/PowerNukkitX/AddonApi-ExamplePlugin)

```java
public class MySlab extends BlockTransparentMeta implements CustomBlock {
    //Define two block states, the first one means this is the top half, the second one means this is a complete plank
    public final BooleanBlockProperty BRIDGE_TOP_SLOT_BIT = new BooleanBlockProperty("bridge:top_slot_bit", false);
    public final BooleanBlockProperty BRIDGE_IS_FULL_BIT = new BooleanBlockProperty("bridge:is_full_bit", false);

    //define Namespace
    public String getNamespaceId() {
        return "powernukkitx:blue_mahoe_slab";
    }

    //override with CustomBlock interface method
    public String getName() {
        return CustomBlock.super.getName();
    }

    //override with CustomBlock interface method
    public int getId() {
        return CustomBlock.super.getId();
    }

    //define block states in server-side 
    public BlockProperties getProperties() {
        return new BlockProperties(
                BRIDGE_TOP_SLOT_BIT, BRIDGE_IS_FULL_BIT
        );
    }

    //Description client-side definition
    public CustomBlockDefinition getDefinition() {
        return CustomBlockDefinition
                .builder(this, "blue_mahoe_planks")//The first is a block instance, the second is a block material name
                .clientFriction(0.1f)//The friction of the client is 0.1, and the player walks on it like an ice
                .geometry("geometry.custom_slab")//Use the geometry model defined in the resourcepack
                .permutations(//Set the changes in different block states
                        new Permutation(Component.builder()//The collision box and selection box for this block in the lower state
                                .collisionBox(new CollisionBox(-8, 0, -8, 16, 8, 16))
                                .selectionBox(new SelectionBox(-8, 0, -8, 16, 8, 16))
                                .geometry(new Geometry("geometry.custom_slab")
                                        .boneVisibility("lower", true)
                                        .boneVisibility("upper", false))
                                .build(),
                                "query.block_property('bridge:top_slot_bit') == false && query.block_property('bridge:is_full_bit') == false"),
                        new Permutation(Component.builder()//The collision box and selection box of this block in the upper state
                                .collisionBox(new CollisionBox(-8, 8, -8, 16, 16, 16))
                                .selectionBox(new SelectionBox(-8, 8, -8, 16, 16, 16))
                                .geometry(new Geometry("geometry.custom_slab")
                                        .boneVisibility("lower", false)
                                        .boneVisibility("upper", true))
                                .build(),
                                "query.block_property('bridge:top_slot_bit') == true && query.block_property('bridge:is_full_bit') == false"),
                        new Permutation(Component.builder()//The collision box and selection box of the block in the state of the complete plank
                                .collisionBox(new CollisionBox(-8, 0, -8, 16, 16, 16))
                                .selectionBox(new SelectionBox(-8, 0, -8, 16, 16, 16))
                                .geometry(new Geometry("geometry.custom_slab")
                                        .boneVisibility("lower", true)
                                        .boneVisibility("upper", true))
                                .build(),
                                "query.block_property('bridge:is_full_bit') == true")
                )
                .build();
    }

    public double getHardness() {
        return 5;
    }

    //The friction of the ice on the server side is 0.9
    public double getFrictionFactor() {
        return 0.9;
    }

    public double getResistance() {
        return 5;
    }

    public int getLightLevel() {
        return 15;
    }

    public int getLightFilter() {
        return 0;
    }

    public int getBurnAbility() {
        return 0;
    }

    public int getBurnChance() {
        return 0;
    }

    public int getItemMaxStackSize() {
        return 64;
    }
```

#### CustomBlockDefinition API [JavaDoc](https://javadoc.io/doc/cn.powernukkitx/powernukkitx/latest/cn/nukkit/block/customblock/CustomBlockDefinition.html)