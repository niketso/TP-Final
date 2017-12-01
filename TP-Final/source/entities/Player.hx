package entities;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;


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
	private var bullets(get, null):FlxTypedGroup<Shot>;
	public var currentState(get, null):States;
	private var lives:Int;
	private var timer:Float;
	private var youdie:FlxText;
	
	
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.Personaje__png, true, 49, 42);
		animation.add("idle", [0]);
		animation.add("jump", [1]);
		animation.add("attack",[2,3],4, false);
		currentState = States.IDLE;
		acceleration.y = 1500;
		lives = 10;
		bullets = new FlxTypedGroup<Shot>();
		
		
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
				animation.play("idle");
				if (velocity.y != 0)
					currentState = States.JUMP;
				else if (velocity.x != 0)
					currentState = States.RUN;

			case States.RUN:
				attack();
				
				horizontalMovement();
				jump();
				
				if (velocity.y != 0)
					currentState = States.JUMP;
				else if (velocity.x == 0)
					currentState = States.IDLE;

			case States.JUMP:
				attack();
				animation.play("jump");

				if (velocity.y == 0)
				{
					if (velocity.x == 0)
						currentState = States.IDLE;
					else
						currentState = States.RUN;
				}

			case States.ATTACK:
				animation.play("attack");
				this.velocity.x = 0;
				attack();
				
				

		}
	}
	private function horizontalMovement():Void 
	{
		velocity.x = 0; 

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
		if (FlxG.keys.justPressed.Z )
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
		if (FlxG.keys.justPressed.X){
			currentState = States.ATTACK;
			shoot();
		}
			
		else if (velocity.x == 0)
						currentState = States.IDLE;
					else
						currentState = States.RUN;
				
			
		
		
		

	}

	public function getDamage(damage:Int)
	{
		
		
			
			youdie = new FlxText (this.x-30, this.y-5, 0, "Press R to restart, Esc to quit", 7);
			FlxG.state.add(youdie);
			this.kill();
			
		
		
		
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

	private function shoot():Void
	{
		
		
			var bullet = new Shot(this.x + 5, this.y + 3);
			bullets.add(bullet);
			FlxG.state.add(bullets);
			bullet.velocity.x = Reg.velBullet;
		
	}	
	public function get_bullets():FlxTypedGroup<Shot>
	{
		return bullets;
	}
}