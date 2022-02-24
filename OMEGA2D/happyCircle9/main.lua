--Improved/Alternative Input Handling Update

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Happy Circle')

    math.randomseed(os.time())

    happy = Happy()
    score = 0

    pipes = {}
    spawnTimer = 0

    gameState = 'start'

    --added: create empty table "keysPressed" inside love.keyboard table
    love.keyboard.keysPressed = {}
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
                table.remove(pipes, 1)
            end
        end
    end

    --added: flush keysPressed table every frame
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    --added: insert new key, value pair into keysPressed table
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()

    elseif key == 'space' then
        if gameState == 'start' then
            gameState = 'play'
        elseif gameState == 'over' then
            happy:reset()
            pipes = {}
            score = 0
            gameState = 'start'
        end
    end
end

--added: create new wasPressed() in love.keyboard table
--       returns whether key has been pressed in last frame
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    love.graphics.setBackgroundColor(72/255, 180/255, 224/255)

    for i = 1, #pipes do
        pipes[i]:render()
    end

    happy:render()

    love.graphics.setColor(200/255, 0, 0)
    love.graphics.setNewFont(50)
    love.graphics.printf(tostring(score), 0, 25, WIN_WIDTH, 'center')

    if gameState == 'start' then
        love.graphics.setNewFont(30)
        love.graphics.printf('Press Space to begin!', 0, WIN_HEIGHT / 3, WIN_WIDTH, 'center')
    end

    if gameState == 'over' then
        love.graphics.setNewFont(100)
        love.graphics.printf('GAME OVER', 0, WIN_HEIGHT / 3, WIN_WIDTH, 'center')
    end
end