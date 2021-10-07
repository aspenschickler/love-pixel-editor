Point = {px = 0, py = 0, color=selected_color}

function Point:create (o)
    o.parent = self
    return o
end

function love.load()
    lovecc = require 'lovecc'

    points = {}
    grid_toggle = true
    scale = 20
    padding = 0
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    color_menu_toggle = false
    
    colors = {lovecc:getHex('17111a'),
              lovecc:getHex('372538'),
              lovecc:getHex('7a213a'),
              lovecc:getHex('e14141'),
              lovecc:getHex('ffa070'),
              lovecc:getHex('c44d29'),
              lovecc:getHex('ffbf36'),
              lovecc:getHex('fff275'),
              lovecc:getHex('753939'),
              lovecc:getHex('cf7957'),
              lovecc:getHex('ffd1ab'),
              lovecc:getHex('39855a'),
              lovecc:getHex('83e04c'),
              lovecc:getHex('dcff70'),
              lovecc:getHex('243b61'),
              lovecc:getHex('3898ff'),
              lovecc:getHex('6eeeff'),
              lovecc:getHex('682b82'),
              lovecc:getHex('bf3fb3'),
              lovecc:getHex('ff80aa'),
              lovecc:getHex('3e375c'),
              lovecc:getHex('7884ab'),
              lovecc:getHex('b2bcc2'),
              lovecc:getHex('ffffff')}

    tan = {0.8901, 0.8649, 0.7882, 1}
    brown = {0.5137, 0.4118, 0.3216, 1}
    grid_color = {1, 1, 1, 0.2}
    selected_color = colors[1]

    font = love.graphics.newFont("m5x7.ttf", 32)
end

function love.update(dt)

end

function love.draw()
    for k, v in pairs(points) do
        love.graphics.setColor(v.color)
        love.graphics.rectangle("fill", v.px, v.py, scale, scale)
    end

    if grid_toggle then
        love.graphics.setColor(grid_color)
        for i = padding, width - padding, scale do
            love.graphics.line(i, padding, i, height - padding)
        end
        for i = padding, height - padding, scale do
            love.graphics.line(padding, i, width - padding, i)
        end
    end

    if color_menu_toggle then
        love.graphics.setColor(tan)
        love.graphics.rectangle("fill", width - 100, 60, 100, 220)

        love.graphics.setColor(brown)
        love.graphics.draw(love.graphics.newText(font, "Colors"), width - 80, 70)
        for i = 1, 8, 1 do
            love.graphics.setColor(colors[i])
            love.graphics.rectangle("fill", width - 80, 80 + i * scale, scale, scale)
            love.graphics.setColor(colors[i+8])
            love.graphics.rectangle("fill", width - 80 + scale, 80 + i * scale, scale, scale)
            love.graphics.setColor(colors[i+16])
            love.graphics.rectangle("fill", width - 80 + scale * 2, 80 + i * scale, scale, scale)
        end
    end
end

function love.mousepressed(x, y, button, isTouch)
    local cx = x - (x % scale)
    local cy = y - (y % scale)

    if button == 1 then
        if color_menu_toggle and CheckCollision(cx, cy, scale, scale, width - 100, 80, 100, 200) then
            for i = 1, 8, 1 do
                if CheckCollision(cx, cy, scale, scale, width - 80, 90 + i * scale, scale, scale) then
                    selected_color = colors[i]
                end
                if CheckCollision(cx, cy, scale, scale, width - 80 + scale, 80 + i * scale, scale, scale) then
                    selected_color = colors[i + 8]
                end
                if CheckCollision(cx, cy, scale, scale, width - 80 + scale * 2, 80 + i * scale, scale, scale) then
                    selected_color = colors[i + 16]
                end
            end
        else
            table.insert(points, Point:create{px = cx, py = cy, color=selected_color})
        end
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "g" then
        grid_toggle = not grid_toggle
    end

    if key == "m" then
        color_menu_toggle = not color_menu_toggle
    end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
  end