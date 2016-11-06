function love.load()
	math.randomseed(os.time())
	game = {}
	game.width = 800
	game.height = 480
	love.window.setMode(game.width, game.height)
	-- Background
	background = {}
	background.img = love.graphics.newImage('assets/sprites/background.jpg')
	background.x = 0
	background.y = 0
	-- Spaceship
	spaceship = {}
	spaceship.img = love.graphics.newImage('assets/sprites/spaceship.png')
	spaceship.x = game.height / 8
	spaceship.num_frames = 4
	spaceship.pos_frame = 1
  	spaceship.frame_width = spaceship.img:getWidth() / spaceship.num_frames
	spaceship.y = {
		(game.height / 4) - (spaceship.img:getHeight() / 2),	
		2 * (game.height / 4) - (spaceship.img:getHeight() / 2),	
		3 * (game.height / 4) - (spaceship.img:getHeight() / 2),	
	}
	spaceship.pos = 2
	spaceship.frames = {
                 love.graphics.newQuad(spaceship.frame_width * 0, 0, spaceship.frame_width, spaceship.img:getHeight(), spaceship.img:getWidth(), spaceship.img:getHeight()),
                 love.graphics.newQuad(spaceship.frame_width * 1, 0, spaceship.frame_width, spaceship.img:getHeight(), spaceship.img:getWidth(), spaceship.img:getHeight()),
                 love.graphics.newQuad(spaceship.frame_width * 2, 0, spaceship.frame_width, spaceship.img:getHeight(), spaceship.img:getWidth(), spaceship.img:getHeight()),
                 love.graphics.newQuad(spaceship.frame_width * 3, 0, spaceship.frame_width, spaceship.img:getHeight(), spaceship.img:getWidth(), spaceship.img:getHeight())
             }
	-- Asteroids
	num_asteroids = 3
	asteroids = {}
	for i = 1, num_asteroids do
		asteroid = {}
		asteroid.img = love.graphics.newImage('assets/sprites/asteroid_1.png')
		asteroid.x = game.width
		asteroid.y = {
			(game.height / 4) - (asteroid.img:getHeight() / 2),	
			2 * (game.height / 4) - (asteroid.img:getHeight() / 2),	
			3 * (game.height / 4) - (asteroid.img:getHeight() / 2),	
		}
		asteroid.pos = 2
		asteroid.speed = 100
		asteroids[i] = asteroid
	end
end

function love.update(dt)
	-- Sprite spaceship
	if spaceship.pos_frame ~= spaceship.num_frames then
		spaceship.pos_frame = spaceship.pos_frame + 1
	else
		spaceship.pos_frame = 1
	end
	-- Asteroids
	for key, asteroid in pairs(asteroids) do
		asteroid.x = asteroid.x - (dt * asteroid.speed)
		if asteroid.x < -asteroid.img:getWidth() then
			asteroid.x = game.width + math.random(0, game.width)
			asteroid.pos = math.random(1, 3)
		end
	end
end

function love.draw()
	love.graphics.draw(background.img, background.x, background.y)
	love.graphics.draw(spaceship.img, spaceship.frames[spaceship.pos_frame], spaceship.x, spaceship.y[spaceship.pos])
	for key, asteroid in pairs(asteroids) do
		love.graphics.draw(asteroid.img, asteroid.x, asteroid.y[asteroid.pos])
	end
end

-- Controls
function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' then
		love.event.push('quit')
	end
	if key == 'up' and spaceship.pos > 1 then
		spaceship.pos = spaceship.pos - 1
	elseif key == 'down' and spaceship.pos < 3 then
		spaceship.pos = spaceship.pos + 1
	end
end