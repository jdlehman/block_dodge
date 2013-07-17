Game = Core.class(Sprite)

function Game:init()
	-- setup player
	player = Player.new()
	stage:addChild(player)

	--add coin
	coin = Coin.new()
	stage:addChild(coin)

	--add first enemy
	local enemy = Enemy.new()
	enemyGroup = Sprite.new()
	enemyGroup:addChild(enemy)
	stage:addChild(enemyGroup)

	--add pause button
	local texture = Texture.new("pause-drawn-blue.png")
	local bitmap = Bitmap.new(texture)
	pause = GCpauseBut.new(texture)
	pause:setPosition(5, 30)
	stage:addChild(pause)

	--add score
	score = Scoreboard.new()
	stage:addChild(score)
end