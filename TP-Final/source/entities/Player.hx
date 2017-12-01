package entities;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import flixel.text.FlxText;


/**
 * ...
 * @author Nicolas Piccitto
 */
enum States
{
	IDLE;
	RUN;
	JUMP;
	ATTACK;

}
class Player extends FlxSprite
{
	public var currentState(get, null):States;
	private var lives:Int;
	private var timer:Float;
	private var youdie:FlxText;
	
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		makeGraphic(10, 10, 0xffffffff);
		currentState = States.IDLE;
		acceleration.y = 1500;
		lives = 1;
		
		
	}
	
	override public function update(elapsed:Float)
	{
		stateMachine();
		super.update(elapsed);
		
	}
	private function stateMachine():Void
	{

		switch (currentState)
		{
			case States.IDLE:
				attack();
				horizontalMovement();
				jump();
				//animation.play("idle");
				if (velocity.y != 0)
					currentState = States.JUMP;
				else if (velocity.x != 0)
					currentState = States.RUN;

			case States.RUN:
				attack();
				horizontalMovement();
				jump();
				//animation.play("run");
				if (velocity.y != 0)
					currentState = States.JUMP;
				else if (velocity.x == 0)
					currentState = States.IDLE;

			case States.JUMP:
				attack();
				//animation.play("jump");

				if (velocity.y == 0)
				{
					if (velocity.x == 0)
						currentState = States.IDLE;
					else
						currentState = States.RUN;
				}

			case States.ATTACK:
				//animation.play("attack");
				this.velocity.x = 0;
				attack();
				

		}
	}
	private function horizontalMovement():Void //esta haciendo conflicto con el objeto deslizante
	{
		velocity.x = 0; //esto hace que no se mueva al parecer

		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x += 100;
			facing = FlxObject.RIGHT;
		}
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x -= 100;
			facing = FlxObject.LEFT;
		}
	}

	private function jump():Void
	{
		if (FlxG.keys.justPressed.A /*&& isTouching(FlxObject.FLOOR)*/)
		{
			velocity.y = -400;

		}
	}

	function get_currentState():States
	{
		return currentState;
	}

	public function attack():Void
	{

		

	}

	public function getDamage(damage:Int)
	{
		if (lives<=0)
		{	
			youdie = new FlxText (this.x-30, this.y-5, 0, "Press R to restart, Esc to quit", 7);
			FlxG.state.add(youdie);
			this.kill();
			
		
		}
		
	}

	public function die():Void
	{
		lives--;
		if (lives<=0)
		{
			youdie = new FlxText (this.x-30, this.y-8, 0, "Press R to restart, Esc to quit", 7);
			FlxG.state.add(youdie);
			this.kill();
			
			
		}
	}

	
}