--Planning

WIN_WIDTH = 1080
WIN_HEIGHT = 640

love.window.updateMode(WIN_WIDTH, WIN_HEIGHT)

function love.load()
    pipe = {
        x = WIN_WIDTH / 2,
        y = WIN_HEIGHT / 2,
        width = 75,
        height = WIN_HEIGHT,
        dx = 250
    }
end

function love.update(dt)
    pipe.x = pipe.x - pipe.dx * dt
end

function love.draw()
    love.graphics.setBackgroundColor(72/255, 180/255, 224/255)

    love.graphics.setColor(95/255, 195/255, 20/255)
    love.graphics.rectangle('fill', pipe.x, pipe.y, pipe.width, pipe.height)
end