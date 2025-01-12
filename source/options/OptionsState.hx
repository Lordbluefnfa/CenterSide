package options;

#if DISCORD
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;
import openfl.display.BlendMode;
import GameJolt.GameJoltLogin;

using StringTools;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Note Colors', 'Controls', 'Graphics', 'Visuals and UI', 'Gameplay', "System", 'Customize', "Useless Options", 'Save Files', "Gamejolt"];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Note Colors':
				openSubState(new options.NotesSubState());
			case 'Controls':
				MusicBeatState.switchState(new ControlsState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case "System":
				openSubState(new options.SysSettingsSubState());
			case 'Customize':
				LoadingState.loadAndSwitchState(new CustomizeState());
			case "Useless Options":
				openSubState(new options.UselessSubState());
			case 'Save Files':
				FlxG.sound.music.stop();
				MusicBeatState.switchState(new SaveFileMenu());
			case "Gamejolt":
				FlxG.sound.music.stop();
				MusicBeatState.switchState(new GameJoltLogin());
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	public static var playstate:Bool = false;

	override function create() {
		#if MODS_ALLOWED
		Paths.destroyLoadedImages();
		#end
		
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		var size:Float = 0.25;

		if (playstate)
		{
			options = ["Note Colors", "Controls", "Graphics", "Visuals and UI", "Gameplay", "System", "Customize", "Useless Options"];
			size = 0.8;
		}

		FlxG.sound.music.stop();

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('options'));
		}

		var backdrop:GridBackdrop = new GridBackdrop();
		add(backdrop);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('backdropSHADER'));
		bg.blend = BlendMode.DARKEN;
		bg.updateHitbox();

		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true, false, size);
			optionText.x = 25;
			optionText.forceX = optionText.x;
			var newY:Float = 80;
			if (size != 0.8)
			{
				newY = 80 - (80 * size);
			}
			optionText.y += Std.int(newY * i);
			grpOptions.add(optionText);
		}

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}


	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.sound.music.stop();
			if (!playstate)
			{
				if (!ClientPrefs.babyShitPiss)
					MusicBeatState.switchState(new MainMenuState());
				else
					MusicBeatState.switchState(new Baby());
			}
			else
			{
				LoadingState.loadAndSwitchState(new PlayState());
			}
		}

		if (controls.ACCEPT) {
			openSelectedSubstate(options[curSelected]);
		}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}