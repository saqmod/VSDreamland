package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.FlxCamera;
import lime.app.Application;

class LooseState extends MusicBeatState
{
	var MainCamera:FlxCamera;

	override function create()
	{
		super.create();

		var loser:FlxSprite = new FlxSprite(100, 100);
		var loseTex = Paths.getSparrowAtlas('lose');
		loser.frames = loseTex;
		loser.animation.addByPrefix('lose', 'lose', 24, false);
		loser.animation.play('lose');
		if(FlxG.save.data.antialiasing)
			loser.antialiasing = true;
		add(loser);

		var restart:FlxSprite = new FlxSprite(500, 50).loadGraphic(Paths.image('restart'));
		restart.setGraphicSize(Std.int(restart.width * 0.6));
		restart.updateHitbox();
		restart.alpha = 0;
		if(FlxG.save.data.antialiasing)
			restart.antialiasing = true;
		add(restart);

		FlxTween.tween(restart, {alpha: 1}, 1, {ease: FlxEase.quartInOut});
		FlxTween.tween(restart, {y: restart.y + 40}, 7, {ease: FlxEase.quartInOut, type: PINGPONG});
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			FlxG.switchState(new PlayState());
		}
		if (controls.BACK)
		{
			if (PlayState.isStoryMode)
			{
				FlxG.switchState(new StoryMenuState());
			}
			else
			{
				FlxG.switchState(new FreeplayState());
			}
		}
		super.update(elapsed);
	}
}
