# 2.自定义物品相关API  

_**author: Cool_Loong**_  

自定义物品相关的API统一在包`cn.nukkit.item.customitem`下  
实现自定义物品需要实现CustomItem接口，也可以通过选择继承内部已经实现好接口的一些基础自定义物品类来实现。

## 基础自定义物品
通过继承`ItemCustom`类可以实现一个普通的自定义物品，必须要覆写`getDefinition`方法,创建一个无参构造函数，调用父类构造函数传入:  
`String id`  
id是自定义物品的标识符，必须填写，形如`pnx:test`
`String name`  
name是自定义物品显示的名称，可以为空，当为空时，自定义物品会从资源包中的`texts`文件夹下的语言文件中读取多语言文本，形如`item.pnx:test=Test Item`
`String textureName`  
textureName是自定义物品的材质路径，必须填写，需要根据资源包中`textures\item_texture.json`相应的材质定义来填写

示例：
```java
public class Test extends ItemCustom {
    public Test() {
        super("pnx:test", "Test 1", "test");
    }
    public CustomItemDefinition getDefinition() {
        return CustomItemDefinition.simpleBuilder(this, ItemCreativeCategory.EQUIPMENT).build();
    }
}
```
## 基础自定义工具
通过继承`ItemCustomTool`类可以实现一个普通的自定义工具，实现方式和上面类似。注意`CustomItemDefinition`需要使用`toolBuilder`，因为有特殊的接口。  

示例：
```java
public class MySword extends ItemCustomTool {
    public MySword() {
        super("powernukkitx:test_sward", "test sward", "test_sward");
    }
    public CustomItemDefinition getDefinition() {
        return CustomItemDefinition
                .toolBuilder(this, ItemCreativeCategory.EQUIPMENT)
                .allowOffHand(true)//允许副手使用
                .handEquipped(true)//决定了物品的手持方式
                .foil(true)//物品带有附魔效果
                .build();
    }
    public int getMaxDurability() {//定义最大耐久
        return 1000;
    }
    public int getTier() {//定义工具等级
        return ItemSwordDiamond.TIER_DIAMOND;
    }
    public int getAttackDamage() {//定义攻击伤害
        return 30;
    }
    public int getEnchantAbility() {//定义附魔能力
        return 20;
    }
    public boolean isSword() {//种类剑
        return true;
    }
}
```
## 基础自定义盔甲
通过继承`ItemCustomArmor`类可以实现一个普通的自定义盔甲。注意`CustomItemDefinition`需要使用`armorBuilder`，因为有特殊的接口。  
同时，自定义盔甲需要在材质包中指定`Attachables`。  
示例：
```java
public class MyArmor extends ItemCustomArmor {
    public MyArmor() {
        super("powernukkitx:pnx_armor", "pnx armor", "pnx_armor");
    }
    public CustomItemDefinition getDefinition() {
        return CustomItemDefinition
                .armorBuilder(this, ItemCreativeCategory.EQUIPMENT)
                .allowOffHand(true)
                .handEquipped(true)
                .build();
    }
    public boolean isChestplate() {
        return true;
    }
    public int getTier() {
        return ItemArmor.TIER_DIAMOND;
    }
    public int getMaxDurability() {
        return 666;
    }
    public int getEnchantAbility() {
        return 10;
    }
    public int getArmorPoints() {//盔甲防御力
        return 100;
    }
}
```
## 基础自定义食物
通过继承`ItemCustomEdible`类可以实现一个普通的自定义工具。注意`CustomItemDefinition`需要使用`edibleBuilder`，因为有特殊的接口。
同时`ItemCustomEdible`还必须实现方法`public abstract Map.Entry<Plugin, Food> getFood();`来定义食物属性，以供服务端注册食物`Food`

示例：
```java
public class MyApple extends ItemCustomEdible {
    public MyApple() {
        super("powernukkitx:pnx_apple", "pnx apple", "apple");
    }
    public Map.Entry<Plugin, Food> getFood() {
        return Map.entry(MainPlugin.INSTANCE, new FoodMilk());
    }
    public CustomItemDefinition getDefinition() {
        return CustomItemDefinition.edibleBuilder(this, ItemCreativeCategory.ITEMS).build();
    }
}
```
## 继承自任意物品类实现自定义物品
通过继承自任意物品类实现`CustomItem`可以复用核心内部逻辑，实现某些特殊物品，例如自定义弓。  
需要注意的是，实现`CustomItem`接口实现自定义物品，必须拥有一个无参构造函数，且按照以下示例定义。同时CustomItemDefinition必须使用`customBuilder`。  

示例:
```java
public class MyCustomItem extends Item implements CustomItem {
    /**
     * 参数1：物品id必须为255即字符串物品ID
     * 参数2：默认meta值为0
     * 参数3：物品数量为1
     * 参数4：物品的名称，如果为null使用资源包中的多语言文本
     */
    public MyCustomItem() {
        super(ItemID.STRING_IDENTIFIED_ITEM, 0, 1, "test");
    }
    public String getTextureName() {//材质
        return "test";
    }
    public String getNamespaceId() {//物品标识符
        return "pnx:test";
    }
    public CustomItemDefinition getDefinition() {//物品定义
        return CustomItemDefinition.customBuilder(this,ItemCreativeCategory.EQUIPMENT).build();
    }
}
```

-------------

CustomItemDefinition相关API参见[JavaDoc](https://javadoc.io/doc/cn.powernukkitx/powernukkitx/latest/cn/nukkit/item/customitem/CustomItemDefinition.html)