--RNG + Procedural Gen. Update

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Happy Circle')
    love.window.updateMode(WIN_WIDTH, WIN_HEIGHT)

    math.randomseed(os.time())

    pipes = {}
    spawnTimer = 0
end

function love.update(dt)
    spawnTimer = spawnTimer + dt

    if spawnTimer > 1.4 then
        table.insert(pipes, Pipe())
        spawnTimer = 0
    end

    for i = 1, #pipes do
        pipes[i]:update(dt)
    end

    for i, pipe in ipairs(pipes) do
        if pipe:remove() then
            table.remove(pipes, i)
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(72/255, 180/255, 224/255)

    for i = 1, #pipes do
        pipes[i]:render()
    end
end