-- screen_entity.lua

-- Define the screen entity
AddCSLuaFile()
DEFINE_BASECLASS("base_gmodentity")

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Target Designator Screen"
ENT.Author = "YourName"
ENT.Category = "G-missiles Targeting"
ENT.Spawnable = true

if SERVER then
    -- Store the server start time
    local serverStartTime = CurTime()

    function ENT:Initialize()
        self:SetModel("models/hunter/plates/plate2x2.mdl")
        self:SetMaterial("models/debug/debugwhite")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)

        self:SetUseType(SIMPLE_USE)

        self.EntitiesList = {}
        self.CurrentIndex = 1

        self:FindEntitiesInSphere()
        self.TypingText = "ACQUIRING TARGETS...."
        self.TypingProgress = 0
        self.TypingSpeed = 50                    -- Characters per second

        self.ButtonOffset1 = Vector(10, -20, 0)  -- Offset for button 1
        self.ButtonOffset2 = Vector(-10, -20, 0) -- Offset for button 2



        self:CreateButtons()
    end

    function ENT:CreateButtons()
        local button1 = ents.Create("target_designator_screen_button1")
        if IsValid(button1) then
            button1:SetPos(self:GetPos() + self.ButtonOffset1)
            button1:SetParent(self)
            button1:Spawn()
        end
        local button2 = ents.Create("target_designator_screen_button2")
        if IsValid(button2) then
            button2:SetPos(self:GetPos() + self.ButtonOffset2)
            button2:SetParent(self)
            button2:Spawn()
        end
    end

    function ENT:UpdateTypingText()
        self.TypingProgress = self.TypingProgress + self.TypingSpeed * FrameTime()
        if self.TypingProgress > #self.TypingText then
            self.TypingProgress = 0
        end
        self:SetNWString("TypingText", string.sub(self.TypingText, 1, math.floor(self.TypingProgress)))
    end

    function ENT:Think()
        self:FindEntitiesInSphere()
        --print(self:GetNWEntity("NW_Target"))
        self:UpdateTypingText()
        self:NextThink(CurTime() + .1) -- Adjust the update rate as needed
        return true
    end

    function ENT:FindEntitiesInSphere()
        local pos = self:GetPos()
        local radius = 5000 -- Adjust the radius as needed
        local entities = ents.FindInSphere(pos, radius)

        local allowedClasses = {
            ["player"] = true,
            ["npc_*"] = true,
            ["prop_*"] = true,
            ["vehicle_*"] = true,
            ["nextbot_*"] = true,
        }

        self.EntitiesList = {}
        for _, ent in ipairs(entities) do
            local class = ent:GetClass()
            for pattern, _ in pairs(allowedClasses) do
                if self:IsAllowedEntity(ent) and string.find(class, pattern) then
                    table.insert(self.EntitiesList, ent)
                    break
                end
            end
        end
    end

    function ENT:IsAllowedEntity(ent)
        if ent:IsPlayer() then
            return true
        end
        if ent:IsNPC() then
            return true
        end
        if ent:IsVehicle() then
            return true
        end
        if ent:GetClass():match("^prop_") and ent:CreatedByMap() == false then
            return true
        end
        if ent:GetClass():match("^nextbot_") then
            return true
        end

        if ent.CreationTime and ent.CreationTime > serverStartTime then
            return true
        end

        return false
    end

    function ENT:CycleEntities(direction)
        if #self.EntitiesList == 0 then return end

        -- Reset color of the previous entity
        local previousEntity = self.EntitiesList[self.CurrentIndex]
        if IsValid(previousEntity) then
            previousEntity:SetColor(Color(255, 255, 255)) -- Reset to white or original color
        end

        self.CurrentIndex = self.CurrentIndex + direction

        if self.CurrentIndex > #self.EntitiesList then
            self.CurrentIndex = 1
        elseif self.CurrentIndex < 1 then
            self.CurrentIndex = #self.EntitiesList
        end

        local currentEntity = self.EntitiesList[self.CurrentIndex]
        if IsValid(currentEntity) then
            if currentEntity:IsPlayer() then
                self:SetNWString("DisplayText", currentEntity:Nick())
            else
                self:SetNWString("DisplayText", currentEntity:GetClass())
            end

            self:SetNWEntity("NW_Target", currentEntity)
            self:SetNWBool("TargetMarked", true)
            currentEntity:SetColor(Color(255, 0, 0))
        else
            self:SetNWString("DisplayText", "No Entities Found")
            self:SetNWBool("TargetMarked", false)
        end
    end

    function ENT:Use(activator, caller)
        -- Placeholder for button interaction; logic handled in button entity
    end
else -- (CLIENT SIDE)
    function ENT:Draw()
        self:DrawModel()

        local pos = self:GetPos() + self:GetUp() * 1.8
        local ang = self:GetAngles()
        local Box = draw.RoundedBox;


        ang:RotateAroundAxis(ang:Forward(), 0)
        ang:RotateAroundAxis(ang:Right(), 0)

        cam.Start3D2D(pos, ang, 0.2)
        Box(10, -230, -230, 460, 460, Color(0, 0, 0));
        --Box(0, 60, -25, 123, 20, Color(0, 0, 0));
        draw.SimpleText(self:GetNWString("TypingText", "ACQUIRING TARGETS"), "DermaLarge", 0, -190,
            Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText("CURRENT TARGET -", "DermaLarge", 0, -90, Color(255, 255, 255), TEXT_ALIGN_CENTER,
            TEXT_ALIGN_CENTER)
        draw.SimpleText(self:GetNWString("DisplayText", "No Entities Found"), "TargetId", 0, 0, Color(255, 0, 0),
            TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end


function ENT:SpawnFunction(ply, tr) -- Used so the ENT doesnt fucking spawn in the ground
    if (not tr.Hit) then return end
    self.GBOWNER = ply
    local ent = ents.Create(self.ClassName)
    ent:SetPhysicsAttacker(ply)
    ent:SetPos(tr.HitPos + tr.HitNormal * 4) -- Changing the right most number makes the entity spawn further up or down...
    ent:Spawn()
    ent:SetAngles(Angle(-90, -90, -90))
    ent:Activate()

    return ent
end
