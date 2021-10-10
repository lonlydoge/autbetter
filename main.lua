local sc,er = pcall(function()
    local spawns = game:GetService("Workspace").ItemSpawns
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local game = game
    local workspace = workspace
    local Ignored = {"DIO Boss","JotaroKujo","Him","Johnny Joestar","StandartItems"}
    
    local function CFrameNew(x,y,z)
        return CFrame.new(x,y,z)
    end
    
    local function checkList(Part)
        for _,part in pairs(Ignored) do
            if Part.Name == part then
                return false
            end
        end
        return true
    end
    
    local function findProx(part)
        for _,descendant in pairs(part:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                return descendant
            end
        end
    end
    
    local function checkProx(part)
        local returned = false
        for _,descendant in pairs(part:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                returned = true
            end
        end
        return returned
    end
    
    local function checkFolder(folder)
        for _,Location in pairs(folder:GetChildren()) do
            if #Location:GetChildren() ~= 0 then
                local OldPos = LocalPlayer.Character.HumanoidRootPart.CFrame 
                repeat game:GetService("RunService").Heartbeat:wait() until checkProx(Location)
                repeat game:GetService("RunService").Heartbeat:wait()
                LocalPlayer.Character.HumanoidRootPart.CFrame = Location.CFrame * CFrameNew(0,-4.5,0)
                if checkProx(Location) then
                fireproximityprompt(findProx(Location))
                end
                until not checkProx(Location)
                LocalPlayer.Character.HumanoidRootPart.CFrame = OldPos
            end
        end
    end
    
    local function getItem(folder)
        if checkList(folder) then
            checkFolder(folder)
        end
    end
    
    for _,folder in pairs(spawns:GetChildren()) do
        getItem(folder)
        for _,smol in pairs(folder:GetChildren()) do
            smol.ChildAdded:Connect(function(loc)
                getItem(loc.Parent.Parent)
            end)
        end
        folder.ChildAdded:Connect(function(loc)
            loc.ChildAdded:Connect(function(hi)
                getItem(hi.Parent.Parent)
            end)
        end)
    end
end)
warn(sc,er)
