PrefabFiles =
{
    "deep_freezer",
}

Assets =
{
    Asset( "IMAGE", "minimap/deep_freezer.tex" ),
    Asset( "ATLAS", "minimap/deep_freezer.xml" ),
    Asset("ATLAS", "images/inventoryimages/deep_freezer.xml"),
}

AddMinimapAtlas("minimap/deep_freezer.xml")

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
TECH = GLOBAL.TECH

GLOBAL.STRINGS.NAMES.DEEP_FREEZER = "Deep Freezer"
STRINGS.RECIPE_DESC.DEEP_FREEZER = 'Make your food go "brrrr..."'
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.DEEP_FREEZER = "Fresh food, but cold!"

local recipe_difficulty = GetModConfigData("RECIPE")

if recipe_difficulty == 0 then
    AddRecipe2("deep_freezer",
        {
            Ingredient("cutstone", 2),
            Ingredient("bundlewrap", 4),
            Ingredient("bluegem", 1),
        },
        TECH.NONE,
        {
            atlas = "images/inventoryimages/deep_freezer.xml",
            image = "deep_freezer.tex",
            placer = "common/deep_freezer_placer"
        },
        { "CONTAINERS" }
    )
end
if recipe_difficulty == 1 then
    AddRecipe2("deep_freezer",
        {
            Ingredient("cutstone", 2),
            Ingredient("bundlewrap", 6),
            Ingredient("gears", 2),
        },
        TECH.NONE,
        {
            atlas = "images/inventoryimages/deep_freezer.xml",
            image = "deep_freezer.tex",
            placer = "common/deep_freezer_placer"
        },
        { "CONTAINERS" }
    )
end
if recipe_difficulty == 2 then
    AddRecipe2("deep_freezer",
        {
            Ingredient("cutstone", 2),
            Ingredient("bundlewrap", 6),
            Ingredient("gears", 4),
        },
        TECH.NONE,
        {
            atlas = "images/inventoryimages/deep_freezer.xml",
            image = "deep_freezer.tex",
            placer = "common/deep_freezer_placer"
        },
        { "CONTAINERS" }
    )
end
if recipe_difficulty == 3 then
    AddRecipe2("deep_freezer",
        {
            Ingredient("cutstone", 2),
            Ingredient("bundlewrap", 6),
            Ingredient("gears", 8),
        },
        TECH.NONE,
        {
            atlas = "images/inventoryimages/deep_freezer.xml",
            image = "deep_freezer.tex",
            placer = "common/deep_freezer_placer"
        },
        { "CONTAINERS" }
    )
end
if recipe_difficulty == 4 then
    AddRecipe2("deep_freezer",
        {
            Ingredient("wagpunk_bits", 4),
            Ingredient("moonstorm_static_item", 1),
            Ingredient("gears", 2),
        },
        TECH.NONE,
        {
            atlas = "images/inventoryimages/deep_freezer.xml",
            image = "deep_freezer.tex",
            placer = "common/deep_freezer_placer"
        },
        { "CONTAINERS" }
    )
end


local containers = require "containers"
containers.params["deep_freezer"] = containers.params.shadowchester

