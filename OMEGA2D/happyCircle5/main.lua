--Happy Planning

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Happy Circle')
    love.window.updateMode(WIN_WIDTH, WIN_HEIGHT)

    math.randomseed(os.time())

    pipes = {}
    spawnTimer = 0

    --added: happy attributes
    happy = {
        x = WIN_WIDTH / 2,
        y = WIN_HEIGHT / 2,
        r = 20,
        dy = 0
    }
end

function love.update(dt)
    spawnTimer = spawnTimer + dt

    if spawnTimer > 1.4 then
        table.insert(pipes, PipePair())
        spawnTimer = 0
    end

    for i = 1, #pipes do
        pipes[i]:update(dt)
    end

    for i, pipePair in ipairs(pipes) do
        if pipePair:remove() then
            table.remove(pipes, i)
        end
    end

    --added: gravity for happy
    happy.dy = happy.dy - 20 * dt
    happy.y = happy.y - happy.dy
end

function love.draw()
    love.graphics.setBackgroundColor(72/255, 180/255, 224/255)

    for i = 1, #pipes do
        pipes[i]:render()
    end

    --added: rendering happy
    love.graphics.setColor(246/255, 190/255, 0)
    love.graphics.circle('fill', happy.x, happy.y, happy.r)
end