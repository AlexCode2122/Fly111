if game.Players.LocalPlayer.leaderstats.Glove.Value == "Warp" and 
   game.Players.LocalPlayer.Character:FindFirstChild("entered") then

    local players = game.Players:GetPlayers() -- Get a list of all players
    local RandomPlayer = nil

    -- Select a random player who is not the local player, is entered, and is not ragdolled
    repeat
        RandomPlayer = players[math.random(1, #players)]
    until RandomPlayer ~= game.Players.LocalPlayer and 
          RandomPlayer.Character and 
          RandomPlayer.Character:FindFirstChild("entered") and 
          RandomPlayer.Character:FindFirstChild("Ragdolled") and 
          RandomPlayer.Character.Ragdolled.Value == false

    -- Move the local player's character to the selected player's HumanoidRootPart position
    local localCharacter = game.Players.LocalPlayer.Character
    local humanoidRootPart = localCharacter:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart and RandomPlayer.Character:FindFirstChild("HumanoidRootPart") then
        humanoidRootPart.CFrame = RandomPlayer.Character.HumanoidRootPart.CFrame
        wait(0.3)

        -- Fire the WarpHt event with the selected player's HumanoidRootPart
        game.ReplicatedStorage.WarpHt:FireServer(RandomPlayer.Character.HumanoidRootPart)
        wait(0.3)

        -- Fire the WLOC event
        game:GetService("ReplicatedStorage").WLOC:FireServer()
        wait(0.2)

        -- Move to DEATHBARRIER position
        if workspace:FindFirstChild("DEATHBARRIER") then
            humanoidRootPart.CFrame = workspace.DEATHBARRIER.CFrame
        else
            warn("DEATHBARRIER not found in workspace.")
        end
    else
        warn("HumanoidRootPart not found for either the local player or the selected random player.")
    end

else
    -- Notify user if conditions are not met
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Error",
        Text = "Need Warp Glove And Located in the Arena.",
        Icon = "rbxassetid://7733658504",
        Duration = 10
    })
end
