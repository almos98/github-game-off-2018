Stage = Room:extend()

function Stage:new()
    Stage.super.new(self)

    self:addGameObject('Player', gw/2, gh/2)
    for i = 1, 100 do
        self:addGameObject('Circle', love.math.random(-1000, 1000), love.math.random(0, gh), {radius=10})
    end
end

------------
return Stage