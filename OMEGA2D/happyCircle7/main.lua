--Score Update

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Happy Circle')
    love.window.updateMode(WIN_WIDTH, WIN_HEIGHT)

    math.randomseed(os.time())

    pipes = {}
    spawnTimer = 0

    happy = Happy()
    
    --added: score variable
    score = 0
    
    gameState = 'play'
end

function love.update(dt)
    if gameState == 'play' then
        spawnTimer = spawnTimer + dt

        if spawnTimer > SPAWN_RATE then
            table.insert(pipes, PipePair())
            spawnTimer = 0
        end

        happy:update(dt)

        for i = 1, #pipes do
            pipes[i]:update(dt)

            --added: if a passed pipe has not been scored once, +1 to score
            if not pipes[i].scored then
                if happy.x > pipes[i].x then
                    score = score + 1
                    pipes[i].scored = true
                end
            end

            if happy:collides(pipes[i]) then
                gameState = 'over'
            end
        end

        for i, pipePair in ipairs(pipes) do
            if pipePair:remove() then
                table.remove(pipes, i)
            end
        end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(72/255, 180/255, 224/255)

    for i = 1, #pipes do
        pipes[i]:render()
    end

    happy:render()

    --added: render a score counter
    love.graphics.setColor(200/255, 0, 0)
    love.graphics.setNewFont(50)
    love.graphics.printf(tostring(score), 0, 25, WIN_WIDTH, 'center')
end