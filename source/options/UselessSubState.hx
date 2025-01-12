package options;

#if desktop
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

using StringTools;

class UselessSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Useless Settings';
		rpcTitle = 'Useless Settings Menu'; //for Discord Rich Presence

        var option:Option = new Option("Wish Downscroll",
        "If checked, downscroll is enabled. However, not really.",
        "wishDownscroll",
        "useless",
        false);

        addOption(option);

        var option:Option = new Option("Flip Characters",
        "If checked, all chracters are flipped on the Y axis",
        "flipChar",
        "useless",
        false);

        addOption(option);

		super();
	}
}