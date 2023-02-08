# 4. custom enchantment

_**author: Cool_Loong***_

## Implementing Custom Enchantment
To implement a custom enchantment, you first need to `extends` from Enchantment and choose to use this constructor  
`protected Enchantment(@NotNull Identifier identifier, String name, Rarity rarity, @NotNull EnchantmentType type)`
where Identifier is the identifier of the enchantment, such as `pnx:test`, reserved for the `minecraft` namespace and not allowed to be used with other plugins   
String is the display name of the enchantment  
Rarity is the rarity of the enchantment  
EnchantmentType is the type of the enchantment, different types allow different items to be enchanted  

Note that custom enchantments do not have numeric IDs, and the only way to get custom enchantments is through strings.  
Use `Item#hasCustomEnchantment(String id)` to determine if the item has the specified custom enchantment  
Get the item's specified custom enchantment by using `Item#getCustomEnchantment(String id)`.  
Get the custom enchantment level specified by the item by using `Item#getCustomEnchantmentLevel(String id)`.

## Implementing custom enchantment logic
The core only provides the registration of custom enchantment, the logic of custom enchantment needs to be implemented by the plugin author.  
You can implement the logic of a specific process by overriding some of the methods in enchanting  
For example:  
`doPostAttack` is triggered when entity is wearing enchanted armor and is attacked by entity attacker  
`doAttack` is triggered when the entity attacker attacks the entity with an enchanted weapon  
You can also implement your own enchantment logic by listening for events
See javadoc for more details

## Registering custom enchantment
Use `Enchantment#(Enchantment enchantment, boolean registerItem)` to register a custom enchantment
`registerItem` means whether you also need to register custom enchantment book items