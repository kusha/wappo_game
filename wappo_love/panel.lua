local class = require 'libs/middleclass'
local tilesize = {40, 52}

local PanelObj = class('PanelObj')

function PanelObj:initialize(unit_type, count)
    self.count = count
    self.description = unit_type

    local animation_time = 0.3
    local anim_letter
    if unit_type == 'teleport' then
        self.sprite = load_animation('tele.png', '1-4', 1, animation_time)
        self.index = 7
    elseif unit_type == 'flame' then
        self.sprite = load_animation('flame.png', '1-4', 1, animation_time)
        self.index = 5
    elseif unit_type == 'exit' then
        self.sprite = load_animation('exit.png', '1-1', 1, animation_time)
        self.index = 6
    elseif unit_type == 'vwall' then
        self.sprite = load_animation('vwall.png', '1-1', 1, animation_time)
        self.index = 13
    elseif unit_type == 'cvwall' then
        self.sprite = load_animation('cVWall.png', '1-1', 1, animation_time)
        self.index = 14
    elseif unit_type == 'hwall' then
        self.sprite = load_animation('hwall.png', '1-1', 1, animation_time)
        self.index = 15
    elseif unit_type == 'chwall' then
        self.sprite = load_animation('cHWall.png', '1-1', 1, animation_time)
        self.index = 16
    elseif unit_type == 'player' then
        self.sprite = load_animation('wstrip.png', 1, '1-4', animation_time)
        self.index = 1
    elseif unit_type == 'red enemy' then
        self.sprite = load_animation('ystrip.png', '1-4', 2, animation_time)
        self.index = 2
    elseif unit_type == 'blue enemy' then
        self.sprite = load_animation('xstrip.png', '1-4', 2, animation_time)
        self.index = 4
    elseif unit_type == 'violet enemy' then
        self.sprite = load_animation('pstrip.png', '1-4', 2, animation_time)
        self.index = 3
    end
end

function PanelObj:update(dt)
    self.sprite:update(dt)
end

function PanelObj:draw(x, y)
    self.sprite:draw(x, y)
end


local Panel = class('Panel')

function Panel:initialize(location, position)
    self.list = {}
    self.location = location
    self.position = position
end

function Panel:add_object(unit_type, count)
    table.insert(self.list, PanelObj:new(unit_type,count))
end

function Panel:update(dt)
    for i=1, #self.list do
        self.list[i]:update(dt)
    end
end

function Panel:draw()
    for i=1, #self.list do
        if i<=6 then
            self.list[i]:draw(self.location[1] + self.position[1]*tilesize[1]*(i-1),
                                self.location[2] + self.position[2]*tilesize[2]*(i-1))
        else
            self.list[i]:draw(self.location[1] + self.position[1]*tilesize[1]*(i-7) + tilesize[1],
                                self.location[2] + self.position[2]*tilesize[2]*(i-7))
        end
    end
end


return Panel