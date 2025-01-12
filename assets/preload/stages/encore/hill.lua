local canStrike = true;
function onCreate()
	makeLuaSprite("sky", "encore/spooky/sky", (-200) - 2114, (-100) - 1075);
	addLuaSprite("sky", false);

	makeLuaSprite('android', 'encore/spooky/spookyBG', -200, -100);
	addLuaSprite('android', false);

	makeLuaSprite('pole', 'week2/spooky/streetpole', -200, -100);
	addLuaSprite('pole', false);

	-- vroom vroom
	makeLuaSprite('car', 'week2/spooky/spookyCar', -1449, -100);
	addLuaSprite('car', true);

	makeLuaSprite('overlay', 'week2/spookyOverlay', -200, -50);
	addLuaSprite('overlay', true);

	makeLuaSprite('white', 'coolVisuals/white', 0, 0);
	addLuaSprite('white', true);
	setObjectCamera('white', 'hud');
	setProperty('white.alpha', 0);
end

function onUpdate(elapsed)
	randomNum = getRandomInt(3, 5.5);
end

function onBeatHit()
	-- random number for cool lightning effect
	if canStrike then
		runTimer('thunder', randomNum);
		canStrike = false;
	end

	if curBeat % 28 == 0 then
		playSound('spookyDrive');
		runTimer('carTimer', 0.96);
	end
end

function onStepHit()

end

function onTimerCompleted(tag)
	bruh = getRandomInt(1, 2);
	if bruh == 1 then
		ass = 'thunder1';
	end
	if bruh == 2 then
		ass = 'thunder2';
	end
	if tag == 'thunder' then
		if flashingLights then
			doTweenAlpha('flashOn', 'white', 1, 0.001, 'linear');
		end
		playSound(ass);
		characterPlayAnim('boyfriend', 'scared', true);
		characterPlayAnim('gf', 'scared', true);
		doTweenAlpha('flashOff', 'white', 0, 0.3, 'linear');
		runTimer('coolDown', 2.1);
	end
	if tag == 'coolDown' then
		canStrike = true;
	end	
	if tag == 'carTimer' then
		moveCar();
	end	
end

-- beep beep :)
function moveCar()
	doTweenX('carTween', 'car', 2114, 0.5, 'linear');
end

function onTweenCompleted(tag)
	if tag == 'carTween' then
		setProperty('car.x', -1449);
	end
end
