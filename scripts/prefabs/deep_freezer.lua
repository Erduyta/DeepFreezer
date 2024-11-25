require "prefabutil"
require "vector3"
require "util"

local assets=
{
	Asset("ANIM", "anim/deep_freezer.zip"),
}

local function clearitemslayers(inst)
    inst.AnimState:Show("door")
end

local function updateitemslayers(inst)
    clearitemslayers(inst)
    local full_part = GetTableSize(inst.components.container.slots)/inst.components.container.numslots
    if full_part > 0.5 then
        inst.AnimState:Hide("door")
    end
end

local function onopen(inst)
    inst.AnimState:PlayAnimation("open")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
end 

local function onclose(inst) 
	inst.AnimState:PlayAnimation("closed")
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
    updateitemslayers(inst)
end 

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	inst.components.container:DropEverything()
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_metal")
	inst:Remove()
end

local function onhit(inst, worker)
	inst.AnimState:PlayAnimation("closed")
	inst.components.container:DropEverything()
	inst.components.container:Close()
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed")	
end

local function fn(Sim)
	local inst = CreateEntity()
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

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
    local data = {
        widget =
        {
            slotpos = {},
            animbank = "ui_chester_shadow_3x4",
            animbuild = "ui_chester_shadow_3x4",
            pos = Vector3(0, 220, 0),
            side_align_tip = 160,
        },
        type = "chest",
    }
    for y = 2.5, -0.5, -1 do
        for x = 0, 2 do
            table.insert(data.widget.slotpos, Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
        end
    end
    inst.components.container.widget = data.widget
    inst.components.container:WidgetSetup("deep_freezer", data)
    inst.components.container.widget = data.widget
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    
    inst:AddComponent("lootdropper")

    inst:AddTag("fridge")
    inst:AddComponent("preserver")
    inst.components.preserver:SetPerishRateMultiplier(0)

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(3)
    inst.components.workable:SetOnFinishCallback(onhammered)
    inst.components.workable:SetOnWorkCallback(onhit)
    return inst
end

return Prefab( "common/deep_freezer", fn, assets),
    --MakePlacer("common/deep_freezer_placer", "icebox", "ice_box", "closed")
	MakePlacer("common/deep_freezer_placer", "deep_freezer", "deep_freezer", "closed")

