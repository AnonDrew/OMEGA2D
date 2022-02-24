Happy = Class{}

local GRAVITY = 20

--changed: increased by one
local JUMP_HEIGHT = 6

function Happy:init()
    self.x = WIN_WIDTH / 3
    self.y = WIN_HEIGHT / 2
    self.r = 20

    self.dy = 0
end

function Happy:collides(pipe)
    if self.x + self.r > pipe.x and self.x - self.r < pipe.x + pipe.width then
        if self.y + self.r > pipe.y1 and self.y - self.r < pipe.y1 + pipe.height then
            return true
        end
        
        if self.y + self.r > pipe.y2 and self.y - self.r < pipe.y2 + pipe.height then
            return true
        end
    end

    return false
end

function Happy:reset()
    self.x = WIN_WIDTH / 3
    self.y = WIN_HEIGHT / 2
    self.dy = 0
end

function Happy:update(dt)
    if self.y + self.r < 0 or self.y - self.r > WIN_HEIGHT then
        gameState = "over"
    end

    --changed: uses newly created wasPressed() and keyPressed table for input now
    if love.keyboard.wasPressed('space') then
        self.dy = -JUMP_HEIGHT
    end

    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy
end

function Happy:render()
    love.graphics.setColor(246/255, 190/255, 0)
    love.graphics.circle('fill', self.x, self.y, self.r)
end