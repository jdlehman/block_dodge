Coin = Core.class(Sprite)

function Coin:init()

	self.size = 30

	self.shape = Shape.new() -- create the shape
	self.shape:beginPath()         -- begin a path
	self.shape:setLineStyle(1)     -- set the line width = 1
	self.shape:setFillStyle(Shape.SOLID, 0xffff00) -- gold
	self.shape:moveTo(0,0)     -- move pen to start of line
	self.shape:lineTo(self.size,0)     -- draw top of rectangle
	self.shape:lineTo(self.size,self.size)     -- draw right side of rectangle
	self.shape:lineTo(0,self.size)     -- draw bottom of rectangle
	self.shape:lineTo(0,0)     -- draw left side of triangle
	self.shape:endPath()           -- end the path
	
	--generate random position on screen
	math.randomseed(os.timer() + points - 1)--use points so if generate in same second, will still vary
	--do until coin does not start on player
	repeat
	self.xPos = math.random(self.size + scoreWidth, application:getContentWidth() - self.size)
	self.yPos = math.random(self.size, application:getContentHeight() - self.size)
	until player:hitTestPoint(self.xPos, self.yPos) == false
	
	self:setPosition(self.xPos, self.yPos)
	
	self:addChild(self.shape)   

end
