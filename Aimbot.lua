-- Fonction Aimbot améliorée
local function AimbotFunction()
    while Configuration.Aimbot do
        task.wait()  -- Éviter la surcharge CPU

        local closestPlayer = nil
        local shortestDistance = math.huge
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local mouse = player:GetMouse()
        local camera = workspace.CurrentCamera

        for _, plr in ipairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local targetPart = plr.Character.HumanoidRootPart
                local distance = (character.HumanoidRootPart.Position - targetPart.Position).Magnitude
                
                if distance < shortestDistance and distance <= Configuration.AimbotFOV then
                    local screenPos = camera:WorldToScreenPoint(targetPart.Position)
                    if screenPos.Z > 0 then
                        shortestDistance = distance
                        closestPlayer = plr
                    end
                end
            end
        end

        if closestPlayer then
            local targetPart = closestPlayer.Character.HumanoidRootPart
            local targetPosition = targetPart.Position
            local direction = (targetPosition - character.HumanoidRootPart.Position).unit
            
            camera.CFrame = CFrame.new(camera.CFrame.Position, camera.CFrame.Position + direction)
            mouse.Hit = Ray.new(camera.CFrame.Position, direction * 1000)
        end
    end
end
