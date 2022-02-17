Pipe = Class{}

function Pipe:init()
    self.x = WIN_WIDTH / 2
    self.y = WIN_HEIGHT / 2
    self.width = 75
    self.height = WIN_HEIGHT

    self.dx = 250
end

function Pipe:update(dt)
    self.x = self.x - self.dx * dt
end

function Pipe:render()
    love.graphics.setColor(95/255, 195/255, 20/255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end