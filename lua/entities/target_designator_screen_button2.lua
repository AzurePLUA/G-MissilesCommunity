-- button_entity.lua
AddCSLuaFile()
-- Define the button entity
DEFINE_BASECLASS("base_gmodentity")

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Button Entity -"
ENT.Category = "G-missiles"
ENT.Author = "YourName"
ENT.Spawnable = false

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/maxofs2d/button_05.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        self:SetUseType(SIMPLE_USE)
    end

    function ENT:Use(activator, caller)
        local screenEntity = ents.FindByClass("target_designator_screen")[1] -- Ensure only one screen entity for simplicity
        self:EmitSound("GMissiles/arm/hominglockaquired1.wav")
        if IsValid(screenEntity) then
            if self:GetModel() == "models/props_c17/clock01.mdl" then
                screenEntity:CycleEntities(1) -- Cycle forward
            elseif self:GetModel() == "models/maxofs2d/button_05.mdl" then
                screenEntity:CycleEntities(-1) -- Cycle backward
            end
        end
    end
end
