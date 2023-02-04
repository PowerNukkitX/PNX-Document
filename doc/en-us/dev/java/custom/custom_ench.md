## 4.自定义附魔
_**author: Cool_Loong**_  
### 实现自定义附魔
实现自定义附魔首先需要继承Enchantment，并且选择使用该构造函数  
`protected Enchantment(@NotNull Identifier identifier, String name, Rarity rarity, @NotNull EnchantmentType type)`
其中Identifier是该附魔的标识符，形如`pnx:test`,保留`minecraft`命名空间不允许使用，不能与其他插件相同   
String为该附魔的显示名  
Rarity为该附魔的珍稀程度  
EnchantmentType为该附魔的类型，不同类型允许附魔的物品不同  
注意，自定义附魔没有数字ID，获取自定义附魔只能通过字符串来获取。  
通过使用`Item#hasCustomEnchantment(String id)`来判断该物品是否具有指定的自定义附魔  
通过使用`Item#getCustomEnchantment(String id)`来获取该物品指定的自定义附魔  
通过使用`Item#getCustomEnchantmentLevel(String id)`来获取该物品指定的自定义附魔等级  

### 实现自定义附魔逻辑
核心只提供自定义附魔的注册，关于自定义附魔的逻辑需要插件作者自己实现。  
你可以通过覆写附魔中的部分方法实现特定过程中的逻辑  
例如:  
`doPostAttack`当实体entity穿着附魔盔甲，被实体attacker攻击时触发  
`doAttack`当实体attacker使用具有附魔的武器攻击实体entity时触发  
你还可以通过监听事件实现自己想要的附魔逻辑
更多详情见javadoc

### 注册自定义附魔
使用`Enchantment#register`注册自定义附魔