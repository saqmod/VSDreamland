package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import lime.app.Application;

#if windows
import Discord.DiscordClient;
#end

class CreditsState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";

	private var daChar:Character;
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();

		FlxG.sound.music.stop();
		FlxG.sound.playMusic(Paths.music('breakfast', 'preload'));

		leftState = false;

		
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image((FlxG.random.bool(10) ? 'EasterEggsLmfao/Go pico yeah yeah' : 'bgMenuNight'), 'dreamland'));
		bg.scale.x *= 1.55;
		bg.scale.y *= 1.55;
		bg.screenCenter();
		add(bg);

		if (FlxG.random.bool(50))
			daChar = new Character(100, 100, 'bat');
		else
			daChar = new Character(100, 100, 'yumi');
		add(daChar);

		#if windows
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Credits menu", null);
		#end
		
		var kadeLogo:FlxSprite = new FlxSprite(FlxG.width, 0);
		kadeLogo.frames = Paths.getSparrowAtlas('Vs_Dreamland_bumpin', 'dreamland');
		kadeLogo.animation.addByPrefix('bump', 'logo bumpin', 24);
		kadeLogo.animation.play('bump');
		kadeLogo.scale.y = 0.3;
		kadeLogo.scale.x = 0.3;
		kadeLogo.x -= kadeLogo.frameHeight;
		kadeLogo.y -= 180;
		kadeLogo.alpha = 0.8;
		add(kadeLogo);
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			(FlxG.random.bool(20) ? "July 26 Aaronrocks40 birthday yee" : "-- Idea --" +
			"\nAaronrocks40\n\n" +
			"-- Programmers --" +
			"\nGEDON6676" +
			"\nSaqzar\n\n" + 
			"-- Artists --" +
			"\nR3M" +
			"\nJohnnyAnimates\n\n" +
			"-- Voice Actors --" +
			"\nMasked Sender" +
			"\nInspired Sarah" +
			"\n\n-- Composers --" +
			"\nChocoChurro" +
			"\nJorclai" +
			"\nChoke Me" +
			"\n\n-- Charters --" +
			"\nwager.mp3" +
			"\nspeedbattle" +
			"\n\nPress SPACE or ESCAPE to return to main menu"),
		4);
		txt.screenCenter(X);
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
		
		FlxTween.color(bg, 2, bg.color, FlxColor.fromString(bgColors[colorRotation]));
		FlxTween.angle(kadeLogo, kadeLogo.angle, -10, 2, {ease: FlxEase.quartInOut});
		
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			if(kadeLogo.angle == -10) FlxTween.angle(kadeLogo, kadeLogo.angle, 10, 2, {ease: FlxEase.quartInOut});
			else FlxTween.angle(kadeLogo, kadeLogo.angle, -10, 2, {ease: FlxEase.quartInOut});
		}, 0);
		
		new FlxTimer().start(0.8, function(tmr:FlxTimer)
		{
			if(kadeLogo.alpha == 0.8) FlxTween.tween(kadeLogo, {alpha: 1}, 0.8, {ease: FlxEase.quartInOut});
			else FlxTween.tween(kadeLogo, {alpha: 0.8}, 0.8, {ease: FlxEase.quartInOut});
		}, 0);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		if (controls.BACK)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		var danced:Bool = false;
		if (!danced)
			danced = true;
			daChar.dance();
		if (danced)
			daChar.dance();
			danced = false;
		if(leftState)
			daChar.playAnim('singRIGHT');

		super.update(elapsed);
	}
}