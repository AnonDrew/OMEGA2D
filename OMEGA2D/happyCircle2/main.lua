--Class + File Structure Update

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Happy Circle')
    love.window.updateMode(WIN_WIDTH, WIN_HEIGHT)

    pipe = Pipe()
end

function love.update(dt)
    pipe:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(72/255, 180/255, 224/255)

    pipe:render()
end