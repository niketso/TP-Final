package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author ...
 */
class Enemy2 extends Enemy 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Enemigo__png, false, 38, 48);
		movement();
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	public function movement():Void
	{
		//velocity.x = -30;
		var v = y + 50;
		FlxTween.tween(this, { y: v }, 1, {type:FlxTween.PINGPONG, ease: FlxEase.sineInOut});
	}
}