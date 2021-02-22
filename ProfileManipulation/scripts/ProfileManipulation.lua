--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

-- Create viewer
local v = View.create()

local DELAY_BETWEEN_PLOTS = 1500

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  local prof1 = Profile.create(135, 0.0)
  for k = 1, prof1:getSize(), 1 do
    if k > 50 and k < 100 then
      prof1:setValue(k - 1, (100 - k) / 2)
    end
  end

  local prof2 = Profile.create(104, 0.0)
  for k = 1, prof2:getSize(), 1 do
    if k > 30 and k < 70 then
      prof2:setValue(k - 1, 20)
    end
  end

  local deco = View.GraphDecoration.create()
  deco:setAspectRatio('EQUAL')
  deco:setTitleSize(3)

  -- Plot profiles
  deco:setTitle('Profile 1')
  deco:setYBounds(-10, 25)
  v:clear()
  v:addProfile(prof1, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  deco:setTitle('Profile 2')
  v:clear()
  v:addProfile(prof2, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  deco:setYBounds(0, 0)
  deco:setTitleSize(7)

  -- Concatenate the profiles
  deco:setTitle('Concatenate')
  prof1:concatenateInplace(prof2)
  v:clear()
  v:addProfile(prof1, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  -- Mirror profile
  deco:setTitle('Mirror')
  prof1:mirrorInplace()
  v:clear()
  v:addProfile(prof1, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  -- Rotate profile
  deco:setTitle('Rotate')
  prof1:rotateInplace(-0.3)
  v:clear()
  v:addProfile(prof1, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  -- Translate profile
  deco:setTitle('Translate')
  prof1:translateInplace(-100, -50)
  v:clear()
  v:addProfile(prof1, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  -- Add noise
  deco:setTitle('Add noise')
  prof1:addNoiseInplace('NORMAL', 2.0)
  v:clear()
  v:addProfile(prof1, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  -- Clamp
  deco:setTitle('Clamp')
  prof1:clampInplace(-100, -50)
  v:clear()
  v:addProfile(prof1, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  -- Find equal
  deco:setTitle('Find values')
  local equalInd = prof1:findEqual(-90, 3)
  local coordV = prof1:getCoordinate(equalInd)
  local valueV = prof1:getValue(equalInd)
  local nInd = #equalInd
  local points = {}
  for k = 1, nInd do
    points[#points + 1] = Point.create(coordV[k], valueV[k])
  end
  v:clear()
  v:addProfile(prof1, deco)
  local pointDeco = View.ShapeDecoration.create()
  pointDeco:setPointSize(2.3)
  pointDeco:setPointType('DOT')
  pointDeco:setLineColor(255, 0, 0)
  v:addShape(points, pointDeco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)

  -- Profile with extracted values
  deco:setTitle('Extract values')
  deco:setTitleSize(1.5)
  deco:setGraphType('DOT')
  deco:setDrawSize(0.5)
  local profFound = Profile.createFromVector(valueV, coordV)
  v:clear()
  v:addProfile(profFound, deco)
  v:present()
  Script.sleep(DELAY_BETWEEN_PLOTS)
  print("App finished.")
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope--------------------------------------------------
