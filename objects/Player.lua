Player = GameObject:extend()

function Player:new(room, x, y, opt)
    Player.super.new(self, room, x, y, opt)

    if not self.controller then
        self.controller = input
    end
    
    self.sheet = love.graphics.newImage('media/spritesheet.png')
    self.g = Anim.newGrid(23,23, 121,25, 0,0, 1)
    self.Animations = {
        idle = Anim.newAnimation(self.g(1,1),2),
        walking = Anim.newAnimation(self.g('2-4', 1), 0.1),
    }

    self.status = 'idle'
    self.speed = 100
    self.direction = 1
    self.w = 25
    self.controller:bind('a', 'left')
    self.controller:bind('s', 'down')
    self.controller:bind('d', 'right')
    self.controller:bind('w', 'up')
end

function Player:update(dt)
    local dx, dy = 0,0
    if self.controller:down('left') then dx = -self.speed end
    if self.controller:down('down') then dy = self.speed end
    if self.controller:down('right') then dx = self.speed end
    if self.controller:down('up') then dy = -self.speed end

    dx,dy = dx*dt,dy*dt
    if (dx==0 and dy==0) then
        self.status = 'idle'
    else
        self:walk(dx,dy)
    end
    self.currentAnimation = self.Animations[self.status]
    self.currentAnimation:update(dt)
end

function Player:draw()
    self.currentAnimation:draw(self.sheet, self.x, self.y)
end

function Player:walk(dx, dy)
    local direction = dx > 0 and 1 or dx < 0 and -1 or self.direction
    print(self.direction, direction)
    if self.direction ~= direction then self:flipAnimations() end
    self.status = 'walking'
    self.x, self.y = self.x + dx, self.y + dy
end

function Player:flipAnimations()
    self.direction = -self.direction
    M.each(self.Animations, function(o)
        o:flipH()
    end)
end
-------------
return Player