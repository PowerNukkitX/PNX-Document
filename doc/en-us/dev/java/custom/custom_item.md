# 2. API for custom items

_**author: Verox**_  
API related to custom items is unified in the package `cn.nukkit.item.customitem`
To implement a custom item, you need to implement the CustomItem interface, or you can implement it by extending some basic custom item class that has already implemented the interface internally (Like `ItemCustomTool` or `ItemCustom`).

## Basic custom item
You can implement a normal custom item by extending the `ItemCustom` class. You must override the `getDefinition` method and create a parameterless constructor, call the parent class constructor and pass in:
`String id`
`id` is the identifier of the custom item, which must be filled in, such as `pnx:test`
`String name`
`name` is the name displayed by the custom item, which can be left `null`. When it is `null`, the custom item will read the multilingual text from the language file in the `texts` folder of the resource pack, such as `item.pnx:test=Test Item`
`String textureName`
`textureName` is the texture path of the custom item, which must be filled in. You need to fill in according to the corresponding texture definition of `textures\item_texture.json` in the resource pack

Example:
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
## Basic custom tool
You can implement a custom tool by extending the `ItemCustomTool` class. The implementation method is similar to the above. Note that `CustomItemDefinition` needs to use `toolBuilder` instead of `simpleBuilder` because it has a special interface.

Example:
```java
public class MySword extends ItemCustomTool {
    public MySword() {
        super("powernukkitx:test_sward", "test sward", "test_sward");
    }
    public CustomItemDefinition getDefinition() {
        return CustomItemDefinition
                .toolBuilder(this, ItemCreativeCategory.EQUIPMENT)
                .allowOffHand(true) // Set to true to make the item be able to be held in the off hand
                .handEquipped(true) // Set to true to make the item be able to be held in the hand
                .foil(true) // Set to true to make the item shiny
                .build();
    }
    public int getMaxDurability() {
        return 1000;
    }
    public int getTier() {
        return ItemSwordDiamond.TIER_DIAMOND;
    }
    public int getAttackDamage() {
        return 30;
    }
    public int getEnchantAbility() {
        return 20;
    }
    public boolean isSword() {
        return true;
    }
}
```
## Basic custom armor
You can implement a custom armor by extending the `ItemCustomArmor` class. The implementation method is similar to the above. Note that `CustomItemDefinition` needs to use `armorBuilder` instead of `simpleBuilder` because it has a special interface.
At the same time, the custom armor needs to specify `Attachables` in the texture pack.
Example:
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
## Basic custom edible item
You can implement a custom edible item by extending the `ItemCustomEdible` class. The implementation method is similar to the above. Note that `CustomItemDefinition` needs to use `edibleBuilder` instead of `simpleBuilder` because it has a special interface.
At the same time, `ItemCustomEdible` must implement the method `public abstract Map.Entry<Plugin, Food> getFood();` to define the food attributes for the server to register food `Food`
Always make sure that the provided plugin is the plugin that registers the food. Otherwise, exception may occur during runtime.

Example:
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
## Custom item with custom behavior
You can implement a custom item with custom behavior by extending the `Item` class. The implementation method is similar to the above. Note that `CustomItemDefinition` needs to use `customBuilder` instead of `simpleBuilder` because it has a special interface.
At the same time, the custom item needs to implement the `CustomItem` interface.

Example:
```java
public class MyCustomItem extends Item implements CustomItem {
    /**
     * Argument 1: Item ID is 255, that is, the string item ID
     * Argument 2: Item meta is 0 by default
     * Argument 3: Item count is 1 by default
     * Argument 4: Item name
     */
    public MyCustomItem() {
        super(ItemID.STRING_IDENTIFIED_ITEM, 0, 1, "test");
    }
    public String getTextureName() {
        return "test";
    }
    public String getNamespaceId() {
        return "pnx:test";
    }
    public CustomItemDefinition getDefinition() {
        return CustomItemDefinition.customBuilder(this,ItemCreativeCategory.EQUIPMENT).build();
    }
}
```

---------

CustomItemDefinition related API see [JavaDoc](https://javadoc.io/doc/cn.powernukkitx/powernukkitx/latest/cn/nukkit/item/customitem/CustomItemDefinition.html)