Scoreboard = Core.class(Sprite)

function Scoreboard:init()
	self.txt = TextField.new(nil, "Score: " .. points)
	self.txt:setPosition(10, application:getContentHeight()/4)
	self.txt:setTextColor(0xffffff)
	
	self:addChild(self.txt)
	
	self:addListeners()
end

function Scoreboard:onEnterFrame(event)
	self.txt:setText("Score: " .. points)
end

--add event listeners
function Scoreboard:addListeners()
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

--remove event listeners
function Scoreboard:removeListeners()
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end