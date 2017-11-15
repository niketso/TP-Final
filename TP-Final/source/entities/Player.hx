package entities;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author Nicolas Piccitto
 */
class Player extends FlxSprite
{
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(5, 5, 0xffffffff);
		
	}
	
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		movement();
	}
	private function movement()
	{
		if (FlxG.keys.pressed.RIGHT)
			velocity.x += 5;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= 5;
		if (FlxG.keys.pressed.UP)
			velocity.y -= 5;
		if (FlxG.keys.pressed.DOWN)
			velocity.y += 5;
	}
}