# 自定义内容相关API详解

_**author: Cool_Loong**_

**本系列文章始终以最新commit版本为基础编写。你可以在[Jitpack](https://www.jitpack.io/#PowerNukkitX/PowerNukkitX)寻找最新PNX版本maven依赖。**

## 1.自定义方块相关API
自定义方块相关的API统一在包`cn.nukkit.block.customblock`下  
实现自定义方块需要实现CustomBlock接口，首先让我们来看需要实现CustomBlock接口中的哪些方法。

### 必须实现/覆写
`double getNamespaceId()`  
实现这个方法设置自定义方块的命名空间ID

`CustomBlockDefinition getDefinition()`  
实现这个方法为客户端提供自定义方块描述，其中CustomBlockDefinition是一个Builder类，内部提供了许多描述方法  

`String getName()`  
覆写这个方法实现自定义方块的getName(),必须使用接口提供的default方法来覆写  
覆写使用返回值`return CustomBlock.super.getName();`  

`int getId()`  
覆写这个方法实现自定义方块的getId(),必须使用接口提供的default方法来覆写  
覆写使用返回值`return CustomBlock.super.getId();`

### 可选实现/覆写
`double getFrictionFactor()`  
实现这个方法描述自定义方块的摩擦因素，值范围在0-1之间，值越小摩擦力越大  

`double getResistance()`  
实现这个方法设置自定义方块的爆炸抗性，值越大防爆能力越强  

`double getLightFilter()`  
实现这个方法设置自定义方块的吸收光的等级，范围在0-15

`double getLightLevel()`  
实现这个方法设置自定义方块的发出光的等级，范围在0-15

`boolean reverseSending()`  
是否反转自定义方块属性解析的顺序

### 关于getDefinition()的写法
`getDefinition()`的作用是为客户端提供自定义方块的定义描述，它的内容和原版addon差不多,由于是客户端定义，这里我们需要参考原版的addon教程，这里推荐在以下两个网站查询  
[MC基岩版开发wiki](https://wiki.bedrock.dev/guide/introduction.html) 和 [微软文档](https://learn.microsoft.com/en-us/minecraft/creator/reference/)

**第一步：我们首先需要使用`CustomBlockDefinition.builder()`方法创建CustomBlockDefinition的builder实例。**

`CustomBlockDefinition.builder()`一共有四种重载方法，其中第一个参数都是自定义方块的实例，填写`this`即可

重载1 `builder(CustomBlock customBlock, String texture)`
参数texture是自定义方块的材质路径，需要根据资源包中`textures\terrain_texture.json`相应的材质定义来填写  
如果你不知道`terrain_texture.json`是什么，请查阅上方提供的两个网站。

重载2 `builder(CustomBlock customBlock, String texture, BlockCreativeCategory blockCreativeCategory)`  
texture同上，BlockCreativeCategory是自定义方块在客户端创造栏中的分类，它是一个枚举

重载3 `builder(CustomBlock customBlock, Materials materials)`  
Materials是自定义方块的材质实例，它可以描述自定义方块在各个不同面上的材质，以及渲染方法，相对应与[原版addon](https://learn.microsoft.com/en-us/minecraft/creator/reference/content/blockreference/examples/blockcomponents/minecraftblock_material_instances)提供的minecraft:material_instances

重载4 `builder(@NonNull CustomBlock customBlock, @NonNull Materials materials, BlockCreativeCategory blockCreativeCategory)`  
`Materials BlockCreativeCategory`同上

**第二步：按照自己的需求为builder添加属性**  
可以调用的有:

`breakTime(double second)`
控制自定义方块在客户端侧的挖掘时间，单位秒

`creativeGroup(String creativeGroup)`  
控制自定义方块在创造栏中的组  

`rotation(Vector3f rotation)`  
以度为单位设置块围绕立方体中心的旋转  

`geometry(String geometry)`  
控制自定义方块的几何模型，需要在材质包中预先定义，你可以使用BlockBench制作方块的几何模型  

`permutations(Permutation... permutations)`  
控制自定义方块的变化特征，可以根据指定molang表达式来实现变化，例如根据molang查询方块状态，实现不同方块状态下的变化。
`Permutation`的内容是一个`Component`组件和一个`molang表达式`，它代表在指定`molang表达式`下使用对应`Component ` 
`Component`是一个包含其他所有组件内容除了`permutations`的复合组件

`partVisibility(BoneCondition... boneConditions)`  
描述自定义方块在不同molang表达式状态下，依据molang表达式条件渲染对应的几何模型骨骼，自定义方块必须使用几何模型该项才有效果。
它由多个`BoneCondition`条件组成，每个`BoneCondition`又由三部分组成：
`conditionName`条件名 | `boneName`骨骼名 | `conditionExpr` molang表达式  

`collisionBox(Vector3f origin,Vector3f size)`  
设置此方块的客户端碰撞箱，不使用自定义几何模型的方块通常不需要使用该方法，因为是单位立方体

`selectionBox(Vector3f origin,Vector3f size)`  
设置此方块的客户端选择箱，不使用自定义几何模型的方块通常不需要使用该方法，因为是单位立方体

**第三步：build实例**
可以选择两种build方式，默认`build`和`customBuild`

`customBuild(Consumer<CompoundTag> nbt)`  
自定义构建参数接受一个消费者函数，你可以随意修改最终将要发生给客户端的方块定义NBT(如果修改错误可能会导致自定义方块注册失败)

### 关于自定义方块的挖掘时间控制
在新版API中，PNX实现了服务端权威方块破坏，这意味着服务端可以负责计算自定义方块的挖掘时间以及何时方块被挖掘掉。  
你不再需要覆写`calculateBreakTime`来控制自定义方块的挖掘时间，如果你覆写了请移除它，这可能会影响服务端侧计算方块挖掘时间。  
你可以使用以下两种方式控制自定义方块的挖掘时间:  

覆写`double getHardness()`  
代表方块硬度，该方法默认值为`10`，它将会被服务端用于计算方块挖掘的时间

使用`CustomBlockDefinition.Builder#breakTime(double)`  
控制自定义方块在客户端侧的挖掘时间，单位秒(默认值 `999`)

**你可能会疑惑为什么存在两个控制自定义方块挖掘时间的方法?**   
使用`getHardness`定义了自定义方块的硬度，它可以做到自定义方块在被不同等级，不同类型的工具挖掘时，挖掘所需要的时间不同。而使用`CustomBlockDefinition.Builder#breakTime(double)`则定义了自定义方块在客户端侧的挖掘时间，它是一个固定值。  
**自定义方块的挖掘时间，取决于服务端侧和客户端侧挖掘时间的最小值。**  
通常情况下，客户端侧挖掘时间被定义为需要999秒，这样自定义方块的挖掘时间就只取决于服务端侧的计算了。
选取硬度值可以参考PNX内部其他方块的硬度，木头的硬度是`2`, 铁块的硬度是`5`, 黑曜石的硬度是`35`

### 自定义方块实例
以下实例实现了一个自定义的半砖方块，其中每行代码都提供了解释。  
由于CustomBlock是接口，你在实现自定义方块之前可以继承核心内部的任意方块类，借用它们的实现，如果你不熟悉内部实现，可以直接选择继承Block类。
这里选择继承BlockTransparentMeta类，它代表这个方块是透明的。  
注意，以下为了节省行数省略了大量注解,换行和一些逻辑实现，想看完整源码和材质包可以去[AddonApi-ExamplePlugin](https://github.com/PowerNukkitX/AddonApi-ExamplePlugin)
```java
public class MySlab extends BlockTransparentMeta implements CustomBlock {
    //定义两个方块状态，第一个代表这个是上半砖，第二个是代表这是一个完整木板
    public final BooleanBlockProperty BRIDGE_TOP_SLOT_BIT = new BooleanBlockProperty("bridge:top_slot_bit", false);
    public final BooleanBlockProperty BRIDGE_IS_FULL_BIT = new BooleanBlockProperty("bridge:is_full_bit", false);
    //描述自定义方块的命名空间，这是必须要提供的
    public String getNamespaceId() {
        return "powernukkitx:blue_mahoe_slab";
    }
    //使用接口提供的定义
    public String getName() {
        return CustomBlock.super.getName();
    }
    //使用接口提供的定义
    public int getId() {
        return CustomBlock.super.getId();
    }
    //覆写getProperties实现核心内部方块状态
    public BlockProperties getProperties() {
        return new BlockProperties(
                BRIDGE_TOP_SLOT_BIT, BRIDGE_IS_FULL_BIT
        );
    }
    //描述客户端定义getProperties实现核心内部方块状态
    public CustomBlockDefinition getDefinition() {
        return CustomBlockDefinition
                .builder(this, "blue_mahoe_planks")//第一个是方块实例，第二个是方块材质名
                .geometry("geometry.custom_slab")//使用材质包中定义的几何模型
                .permutations(//设置不同方块状态下的变化
                        new Permutation(Component.builder()//下板砖状态下，该方块的碰撞箱和选择箱
                                .collisionBox(new CollisionBox(-8, 0, -8, 16, 8, 16))
                                .selectionBox(new SelectionBox(-8, 0, -8, 16, 8, 16))
                                .build(),
                                "query.block_property('bridge:top_slot_bit') == false && query.block_property('bridge:is_full_bit') == false"),
                        new Permutation(Component.builder()//上半砖状态下，该方块的碰撞箱和选择箱
                                .collisionBox(new CollisionBox(-8, 8, -8, 16, 16, 16))
                                .selectionBox(new SelectionBox(-8, 8, -8, 16, 16, 16))
                                .build(),
                                "query.block_property('bridge:top_slot_bit') == true && query.block_property('bridge:is_full_bit') == false"),
                        new Permutation(Component.builder()//完整木板方块状态下，该方块的碰撞箱和选择箱
                                .collisionBox(new CollisionBox(-8, 0, -8, 16, 16, 16))
                                .selectionBox(new SelectionBox(-8, 0, -8, 16, 16, 16))
                                .build(),
                                "query.block_property('bridge:is_full_bit') == true")
                )
                .partVisibility(
                        //下板砖状态或者完整方块状态，则渲染下半部分(下板砖)骨骼
                        new BoneCondition("lower", "lower", "!query.block_property('bridge:top_slot_bit') || query.block_property('bridge:is_full_bit')"),
                        //上半砖状态或者完整方块状态，则渲染上半部分(上板砖)骨骼
                        new BoneCondition("upper", "upper", "query.block_property('bridge:top_slot_bit') || query.block_property('bridge:is_full_bit')")
                )
                .build();
    }
    //方块硬度
    public double getHardness() {
        return 5;
    }
    //摩擦因素
    public double getFrictionFactor() {
        return 0.1;
    }
    //防爆抗性
    public double getResistance() {
        return 5;
    }
    //发光亮度
    public int getLightLevel() {
        return 15;
    }
    //滤光程度
    public int getLightFilter() {
        return 0;
    }
    //燃烧能力 设置0无法燃烧
    public int getBurnAbility() {
        return 0;
    }
    //燃烧概率 设置0无法燃烧
    public int getBurnChance() {
        return 0;
    }
    //物品堆叠数量，最大64个
    public int getItemMaxStackSize() {
        return 64;
    }
```

#### CustomBlockDefinition相关API参见[JavaDoc](https://javadoc.io/doc/cn.powernukkitx/powernukkitx/latest/cn/nukkit/block/customblock/CustomBlockDefinition.html)