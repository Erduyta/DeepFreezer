PrefabFiles =
{
    "deep_freezer",
}

Assets =
{
    Asset( "IMAGE", "minimap/deep_freezer.tex" ),
    Asset( "ATLAS", "minimap/deep_freezer.xml" ),
    Asset("ATLAS", "images/inventoryimages/ui_chest_3x4.xml"),
    Asset("ATLAS", "images/inventoryimages/deep_freezer.xml"),
}

AddMinimapAtlas("minimap/deep_freezer.xml")

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.DEEP_FREEZER = "Deep Freezer"
STRINGS.RECIPE_DESC.DEEP_FREEZER = 'Make your food go "brrrr..."'
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DEEP_FREEZER = "Fresh food, but cold!"

local Spot = GetModConfigData("Spot")
local eightxten = (GetModConfigData("eightxten") == "8x10")
GLOBAL.yep = (GetModConfigData("workit") == "yep")
GLOBAL.chillit = (GetModConfigData("chillit") == "yep")

-- Добавление рецепта с AddRecipe2
--AddRecipe("deep_freezer", {Ingredient("goldnugget", 2), Ingredient("gears", 1), Ingredient("cutstone", 1)}, RECIPETABS.FARM, TECH.SCIENCE_TWO, "deep_freezer_placer", 1.5)
AddRecipe2("deep_freezer",
    {
        Ingredient("cutstone", 2),
        Ingredient("bundlewrap", 4),
        Ingredient("bluegem", 1),
    },
    TECH.NONE,  -- Нет специальной технологии
    {
        atlas = "images/inventoryimages/deep_freezer.xml",  -- Атлас для изображения предмета
        image = "deep_freezer.tex",  -- Изображение предмета
        placer = "common/deep_freezer_placer"
    },
    { "CONTAINERS" }  -- Вкладка, на которой будет отображаться рецепт
)
local containers = require "containers"
containers.params["deep_freezer"] = containers.params.shadowchester

