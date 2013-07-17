Player = Core.class(Sprite)

function Player:init()

	self.size = 20
	
	self.shape = Shape.new() -- create the shape
	self.shape:beginPath()         -- begin a path
	self.shape:setLineStyle(1)     -- set the line width = 1
	self.shape:setFillStyle(Shape.SOLID, 0xff0000) -- red
	self.shape:moveTo(0,0)     -- move pen to start of line
	self.shape:lineTo(self.size,0)     -- draw top of rectangle
	self.shape:lineTo(self.size,self.size)     -- draw right side of rectangle
	self.shape:lineTo(0,self.size)     -- draw bottom of rectangle
	self.shape:lineTo(0,0)     -- draw left side of triangle
	self.shape:endPath()           -- end the path
	
	self.xPos = application:getContentWidth()/2 + 60
	self.yPos = application:getContentHeight()/2
	
	
	self:setPosition(self.xPos, self.yPos)
	
	self:addChild(self.shape)     -- add the shape to the sprite
	
	--add on enter frame event listener
	self:addListeners()
end

function Player:onMouseDown(event)
	--if self:hitTestPoint(event.x, event.y) then
		self.isFocus = true
 
		self.x0 = event.x
		self.y0 = event.y
 
		event:stopPropagation()
	--end
end
 
function Player:onMouseMove(event)
	if self.isFocus then
		local dx = event.x - self.x0
		local dy = event.y - self.y0
		
		local newX = self:getX() + dx
		local newY = self:getY() + dy
 
		--check screen bounds
		if newX > (application:getContentWidth() - self.size + 1) then
			newX = application:getContentWidth() - self.size
		elseif newX < (1 + scoreWidth) then
			newX = scoreWidth	
		end
		if newY > (application:getContentHeight() - self.size + 1) then	
			newY = application:getContentHeight() - self.size
		elseif newY < 1 then 
			newY = 1
		end
		
		self:setX(newX)
		self:setY(newY)
		
		self.xPos = newX
		self.yPos = newY
		
		self:onEnterFrame(event)
 
		self.x0 = event.x
		self.y0 = event.y
 
		event:stopPropagation()
	end
end
 
function Player:onMouseUp(event)
	if self.isFocus then
		self.isFocus = false
		event:stopPropagation()
	end
end

function Player:onEnterFrame(event)
	--if hit coin
	if(self:collidesWith(coin)) then
		points = points + 10--increment 
		coin:removeFromParent()--remove coin
		
		coin = Coin.new()
		stage:addChildAt(coin, 0)-- add new coin to back
		
		--add new enemy
		local enemy = Enemy.new()
		enemyGroup:addChild(enemy)
		
	end	
	
	local hit = false
	--if hit an enemy in group
	for i = enemyGroup:getNumChildren(), 1, -1 do
		local tempEnemy = enemyGroup:getChildAt(i)
		if(player:collidesWith(tempEnemy)) then
			hit = true
		end
		
	end
	
	--if hit recorded
	if(hit) then
	
		isMoving = 0
		pause:removeAllListeners(stage)--remove event listeners, to stop movement		
				
		endGame()
		for i = stage:getNumChildren(), 1, -1 do
			local child = stage:getChildAt(i)
			child = nil
			stage:removeChildAt(i)
		end
		collectgarbage()
		collectgarbage()
		collectgarbage()
		collectgarbage()
		startGame()
	end	
	
end



--function to see if player hit object
--[[function Player:hitPlayer(object)
	return object:hitTestPoint(self.xPos, self.yPos) or object:hitTestPoint(self.xPos + self.size, self.yPos) or object:hitTestPoint(self.xPos, self.yPos + self.size) or object:hitTestPoint(self.xPos + self.size, self.yPos + self.size)
end]]--

--add event listeners
function Player:addListeners()
	isMoving = 1
	--self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
end

--remove event listeners
function Player:removeListeners()
	isMoving = 0
	--self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:removeEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:removeEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:removeEventListener(Event.MOUSE_UP, self.onMouseUp, self)
end

