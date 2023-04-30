local defaultNotePos = {};
local shake = 4; 
local Meow1 = 0
local Meow2 = 112
local Meow3 = 112 * 2
local Meow4 = 112 * 3

function onSongStart()
	for i = 0,7 do 
		x = getPropertyFromGroup('strumLineNotes', i, 'x')

		y = getPropertyFromGroup('strumLineNotes', i, 'y')

		table.insert(defaultNotePos, {x,y})
	end
end

function onUpdate(elapsed)
	songPos = getPropertyFromClass('Conductor', 'songPosition'); -- Note Movements
	currentBeat = (songPos / 750) * (bpm / 160)

	if curStep >= 5 and curStep < 100 then
		for i = 0,7 do
			setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 5 - 5 * math.sin((currentBeat + i*2) * math.pi))
		end                                                       
	end   

	if curStep == 100 then
		for i = 0,7 do 
			setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1])
			setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2])
		end
	end
end


