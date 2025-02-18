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

local _G = GLOBAL

local data_ = {
    widget =
    {
        slotpos = {},
        animbank = "ui_chester_shadow_3x4",
        animbuild = "ui_chester_shadow_3x4",
        pos = _G.Vector3(0, 220, 0),
        side_align_tip = 160,
    },
    type = "chest",
}
-- y and x make the slots. 0 counts as a row.
for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
        table.insert(data_.widget.slotpos, _G.Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
    end
end

local containers = _G.require "containers"
containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, data_.widget.slotpos ~= nil and #data_.widget.slotpos or 0)
local old_widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data)
        local pref = prefab or container.inst.prefab
        if pref == "deep_freezer" then
                local t = data_
                if t ~= nil then
                        for k, v in pairs(t) do
                                container[k] = v
                        end
                        container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
                end
        else
            return old_widgetsetup(container, prefab)
    end
end
