Enemy = Core.class(Sprite)

function Enemy:init()

	self.size = 10
	
	--start enemy in a random location not on the player
	self.shape = Shape.new() -- create the shape
	self.shape:beginPath()         -- begin a path
	self.shape:setLineStyle(1)     -- set the line width = 1
	self.shape:setFillStyle(Shape.SOLID, 0xffffff) -- white
	self.shape:moveTo(0,0)     -- move pen to start of line
	self.shape:lineTo(self.size,0)     -- draw top of rectangle
	self.shape:lineTo(self.size,self.size)     -- draw right side of rectangle
	self.shape:lineTo(0,self.size)     -- draw bottom of rectangle
	self.shape:lineTo(0,0)     -- draw left side of triangle
	self.shape:endPath()           -- end the path
	
	--generate random position on screen
	math.randomseed(os.timer() + points)--use points so if generate in same second, will still vary
	--do until enemeny does not start on player
	repeat
		self.xPos = math.random(self.size + scoreWidth, application:getContentWidth() - self.size)
		self.yPos = math.random(self.size * 2, application:getContentHeight() - 2 * self.size)
	until player:hitTestPoint(self.xPos, self.yPos) == false
	
	--set position
	self:setPosition(self.xPos, self.yPos)
	
	--set plane to move (up/down or left/right)
	self.plane = math.random(0, 1)
	--set direction (up vs down , left vs right)
	self.dir = 1
	
	--add shape to sprite
	self:addChild(self.shape)   
	
	--add on enter frame event listener
	self:addListeners()
end

function Enemy:onEnterFrame(event)
   if(self.plane == 1) then--up/down
		
		--set y boundaries for enemy
		if self.yPos > application:getContentHeight() - 31 then	
			self.dir = - 1
		elseif self.yPos < 21 then 
			self.dir = 1
		end
	
		self.yPos = self:getY() + speed * self.dir * isMoving
   else--left/right
   
		--set x boundaries for enemy
		if self.xPos > application:getContentWidth() - 11 then	
			self.dir = -1
		elseif self.xPos < scoreWidth then 
			self.dir = 1
		end
   
		self.xPos = self:getX() + speed * self.dir * isMoving
   end
   
   --move
   self:setPosition(self.xPos, self.yPos)
   
end

--function to see if enemy hit object
--[[function Enemy:hitEnemy(object)
	return object:hitTestPoint(self.xPos, self.yPos) or object:hitTestPoint(self.xPos + self.size, self.yPos) or object:hitTestPoint(self.xPos, self.yPos + self.size) or object:hitTestPoint(self.xPos + self.size, self.yPos + self.size)
end ]]--

--add event listeners
function Enemy:addListeners()
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

--remove event listeners
function Enemy:removeListeners()
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end


