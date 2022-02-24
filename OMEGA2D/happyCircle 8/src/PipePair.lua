PipePair = Class{}

local GAP_SIZE = 125
local PIPE_LIMIT = 80

function PipePair:init()
    self.x = WIN_WIDTH
    self.y1 = math.random(GAP_SIZE + PIPE_LIMIT, WIN_HEIGHT - PIPE_LIMIT)

    self.width = 75
    self.height = WIN_HEIGHT

    self.y2 = self.y1 - self.height - GAP_SIZE

    self.dx = 250

    self.scored = false
end

function PipePair:remove()
    return self.x + self.width < 0
end

function PipePair:update(dt)
    self.x = self.x - self.dx * dt
end

function PipePair:render()
    love.graphics.setColor(95/255, 195/255, 20/255)
    love.graphics.rectangle('fill', self.x, self.y1, self.width, self.height)
    love.graphics.rectangle('fill', self.x, self.y2, self.width, self.height)
end
