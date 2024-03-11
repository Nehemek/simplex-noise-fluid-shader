---------------------------------------------------------------------------
-- LOAD
---------------------------------------------------------------------------
function love.load()

    love.window.setMode(720,720,{resizable = true, stencil = false})
    love.graphics.setBackgroundColor(1,1,1)
    love.graphics.setDefaultFilter("nearest","nearest")

    time = 0

    sprite1 = love.graphics.newImage("sprite.png")

    canvassize = 512
    canvas1 = love.graphics.newCanvas(canvassize,canvassize)
    canvas2 = love.graphics.newCanvas(canvassize,canvassize)

    shader1 = love.graphics.newShader("shaders/turbulence.glsl")
    shader2 = love.graphics.newShader("shaders/difussion.glsl")
end

---------------------------------------------------------------------------
-- DRAW
---------------------------------------------------------------------------
function love.draw()

    -----------------------------------------------------------------------
    -- STEP 1: COPY CANVAS 2 DATA AND APPLY NOISE TURBULENCE
    -----------------------------------------------------------------------
    love.graphics.setCanvas(canvas1)
        love.graphics.clear(0,0,0,1)

        love.graphics.setShader(shader1)
            shader1:send("time",time)
            love.graphics.draw(canvas2)
        love.graphics.setShader()

        if time % 1 == 0 then
            love.graphics.setColor(1,1,1)
            love.graphics.draw(sprite1,canvassize/2,canvassize/2,0,.5,.5,sprite1:getWidth()/2,sprite1:getHeight()/2)

            local angle = math.rad(time)
            local cos, sin = math.cos(angle) * 100, math.sin(angle) * 60

            love.graphics.setColor(1,0,.5)
            love.graphics.circle("fill",canvassize/2+cos,canvassize/2+sin,20)

            love.graphics.setColor(0,.5,1)
            love.graphics.circle("fill",canvassize/2-cos,canvassize/2-sin,20)

            love.graphics.setColor(1,1,1)
        end
        
    love.graphics.setCanvas()

    -----------------------------------------------------------------------
    -- STEP 2: COPY CANVAS 1 DATA AND APPLY DIFFUSION
    -----------------------------------------------------------------------
    love.graphics.setCanvas(canvas2)
        love.graphics.clear(0,0,0,1)
        love.graphics.setShader(shader2)
            love.graphics.draw(canvas1)
        love.graphics.setShader()
    love.graphics.setCanvas()

    -----------------------------------------------------------------------
    -- STEP 3: DRAW RESULT
    -----------------------------------------------------------------------
    love.graphics.translate(love.graphics.getWidth()*.5, love.graphics.getHeight()*.5)    
    love.graphics.draw(canvas2,0,0,0,1,1,canvas2:getWidth()/2,canvas2:getWidth()/2)

    -----------------------------------------------------------------------
    -- TIME
    -----------------------------------------------------------------------
    time = time + 1
end

---------------------------------------------------------------------------
-- KEYBOARD
---------------------------------------------------------------------------
function love.keypressed(key,scancode,isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end