--State Expansion Update

require 'src/Dependencies'

function love.load()
    love.window.setTitle('Happy Circle')

    math.randomseed(os.time())

    happy = Happy()
    score = 0

    pipes = {}
    spawnTimer = 0

    --changed: initial state is 'start' for start screen
    gameState = 'start'
end

function love.update(dt)
    --changed: gameplay begins only when in 'play' state
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

            --changed: proper transition to game over screen
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
end

--added: transitioning states using space and closing the game with escape
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()

    elseif key == 'space' then

        --added: if space pressed and in start screen, transition to gameplay
        if gameState == 'start' then
            gameState = 'play'

        --added: if space pressed and in gameover screen, refresh and transition to start screen
        elseif gameState == 'over' then

            --added: reset() function in Happy
            happy:reset()
            
            pipes = {}
            score = 0
            gameState = 'start'
        end
    end
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

    --added: render start screen
    if gameState == 'start' then
        love.graphics.setNewFont(30)
        love.graphics.printf('Press Space to begin!', 0, WIN_HEIGHT / 3, WIN_WIDTH, 'center')
    end

    --added: render game over screen
    if gameState == 'over' then
        love.graphics.setNewFont(100)
        love.graphics.printf('GAME OVER', 0, WIN_HEIGHT / 3, WIN_WIDTH, 'center')
    end
end