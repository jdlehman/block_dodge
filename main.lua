-- Setup App
application:setBackgroundColor(0x000000)
application:setScaleMode("fitHeight")
application:setScaleMode("fitWidth")
application:setOrientation(Application.LANDSCAPE_LEFT)

speed = 2.5 --how fast the enemy moves
points = 0 --points player has
isMoving = 1 --1 if game going, 0 if paused or stopped
scoreWidth = 70

function Sprite:collidesWith(sprite2)
	local x,y,w,h = self:getBounds(stage)
	local x2,y2,w2,h2 = sprite2:getBounds(stage)

	return not ((y+h < y2) or (y > y2+h2) or (x > x2+w2) or (x+w < x2))
end

function startGame()
	game = Game.new()
	stage:addChild(game)
end

function endGame()
	stage:removeChild(game)
	points = 0
end

--start the game--will replace with menu in future
startGame() 

