state_name = {}

local buttons = {}
local labels = {}
local fields = {}

function state_name:init()
  mousePos = HC.point(love.mouse.getX(), love.mouse.getY())
  self:initializeButtons()
  self:initializeLabels()
  self:initializeFields()
end

function state_name:enter(from)
  love.graphics.setBackgroundColor(CLR.BLACK)
end

function state_name:update(dt)
  self:handleMouse()
end

function state_name:keypressed(key)
  for pos, field in pairs(fields) do
    field:keypressed(key)
  end
end

function state_name:textinput(text)
  for pos, field in pairs(fields) do
    field:textinput(text)
  end
end

function state_name:mousepressed(mousex, mousey, mouseButton)
  mousePos = HC.point(mousex, mousey)
  
  if mouseButton == 1 then
    for pos, field in pairs(fields) do
      field:highlight(mousePos)
      field:mousepressed(mouseButton)
    end
    
    for pos, button in pairs(buttons) do
      button:highlight(mousePos)
      button:mousepressed(mouseButton)
    end
  end
end

function state_name:draw()
  drawFPS(fpsCounter)
  for key, button in pairs(buttons) do
    button:draw()
  end
  for pos, field in pairs(fields) do
    field:draw()
  end
  for pos, label in pairs(labels) do
    label:draw()
  end
end

function state_name:initializeButtons()
  buttons.genericButton = Button(xPos, yPos, width, height, "Button Text")
  
  buttons.genericButton.action = function()
    love.mouse.setCursor()
  end
end

function state_name:initializeLabels()
  labels.title = Label("State Title", .5, .1, "center", CLR.WHITE)
end

function state_name:initializeFields()
  fields.genericField = FillableField(.5, .4, .15, .03, "Field Text", false, true, 16)
end

function state_name:handleMouse()
  mousePos:moveTo(love.mouse.getX(), love.mouse.getY())
  local highlightButton = false
  local highlightField = false
  
  for key, button in pairs(buttons) do
    if button:highlight(mousePos) then
      highlightButton = true
    end
  end
  
  for key, field in pairs(fields) do
    if field:highlight(mousePos) then
      highlightField = true
    end
  end
  
  if highlightButton then
    love.mouse.setCursor(CUR.H)
  elseif highlightField then
    love.mouse.setCursor(CUR.I)
  else
    love.mouse.setCursor()
  end
end

function state_name:quit()
  
end