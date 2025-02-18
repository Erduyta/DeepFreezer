require "prefabutil"
require "vector3"
require "util"

local assets=
{
	Asset("ANIM", "anim/deep_freezer.zip"),
}

local function clearitemslayers(inst)
    inst.AnimState:Hide("meh_pidor")
    inst.AnimState:Hide("supp_2")
    inst.AnimState:Hide("supp_3")
    inst.AnimState:Hide("supp_4")
end

local function printTable(tbl, indent)
    indent = indent or 0
    local indentString = string.rep("  ", indent)

    if type(tbl) ~= "table" then
        print(indentString .. tostring(tbl))
        return
    end

    print(indentString .. "{")
    for key, value in pairs(tbl) do
        local keyString = tostring(key)
        if type(value) == "table" then
            print(indentString .. "  [" .. keyString .. "] = ")
            printTable(value, indent + 1)
        else
            print(indentString .. "  [" .. keyString .. "] = " .. tostring(value))
        end
    end
    print(indentString .. "}")
end


local function updateitemslayers(inst)
    clearitemslayers(inst)
    local full_part = GetTableSize(inst.components.container.slots)/inst.components.container.numslots
    print(full_part)
    if full_part >= 0.25 then
        print("hide1")
        printTable(inst.AnimState)
        inst.AnimState:Show("meh_pidor")
    end
    if full_part >= 0.5 then
        print("hide2")
        inst.AnimState:Show("supp_2")
    end
    if full_part >= 0.75 then
        print("hide3")
        inst.AnimState:Show("supp_3")
    end
    if full_part >= 1 then
        print("hide4")
        inst.AnimState:Show("supp_4")
    end
end

local function onopen(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("open")
	    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
    end
end 

local function onclose(inst)
    if not inst:HasTag("burnt") then
        inst.AnimState:PlayAnimation("close")
	    inst.AnimState:PushAnimation("closed", false)
	    inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
        updateitemslayers(inst)
    end
end 

local function onhammered(inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
	inst.components.lootdropper:DropLoot()
	if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	inst:Remove()
end

local function onhit(inst, worker)
    if not inst:HasTag("burnt") then
	    inst.AnimState:PlayAnimation("hit")
        inst.components.container:DropEverything()
        updateitemslayers(inst)
        inst.AnimState:PushAnimation("closed", false)
        inst.components.container:Close()
    end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed", false)
    updateitemslayers(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/icebox_craft")
end

local function onsave(inst, data)
    if inst:HasTag("burnt") or (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
        data.burnt = true
    end
end

local function onload(inst, data)
    if data ~= nil and data.burnt then
        inst.components.burnable.onburnt(inst)
    else
        updateitemslayers(inst)
    end
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()
    inst:SetDeploySmartRadius(0.75)
    -- MakeObstaclePhysics(inst, 0.2)

	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "deep_freezer.tex" )


    

    inst.AnimState:SetBank("deep_freezer")
    inst.AnimState:SetBuild("deep_freezer")
    inst.AnimState:PlayAnimation("closed", true)

    inst:AddTag("structure")

    inst.entity:SetPristine()	
    
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("deep_freezer")
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    
    inst:AddComponent("lootdropper")

    inst.OnSave = onsave
    inst.OnLoad = onload

    inst:AddTag("fridge")
    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(0)
    MakeMediumBurnable(inst, nil, nil, true)
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
    inst:ListenForEvent("onbuilt", onbuilt)
    return inst
end

return Prefab( "common/deep_freezer", fn, assets),
    --MakePlacer("common/deep_freezer_placer", "icebox", "ice_box", "closed")
	MakePlacer("common/deep_freezer_placer", "deep_freezer", "deep_freezer", "closed")

