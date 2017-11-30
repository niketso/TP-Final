package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import entities.Player;
import entities.Enemy;
import entities.Enemy1;
import entities.Enemy2;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;                      

class PlayState extends FlxState
{
	private var player:Player;
	private var enemy1:Enemy;
	private var enemy2:Enemy;
	private var loader:FlxOgmoLoader;
	private var tilemap:FlxTilemap;
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		super.create();
		loader = new FlxOgmoLoader(AssetPaths.Level__oel);
		tilemap = loader.loadTilemap(AssetPaths.Tile__png, 16, 16, "Tiles");
		loader.loadEntities(entityCreator, "Entities");
		add(tilemap);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	private function entityCreator(entityName:String, entityData:Xml)
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		switch (entityName)
		{
			case "player":
				player = new Player();

				player.x = x;
				player.y = y;
				add(player);
			case "enemy1":
				enemy1 = new Enemy1();
				
				enemy1.x = x;
				enemy1.y = y;
				add(enemy1);
			case "enemy2":
				enemy2 = new Enemy2();
				
				enemy2.x = x;
				enemy2.y = y;
				add(enemy2);	
		}
	}
	
}