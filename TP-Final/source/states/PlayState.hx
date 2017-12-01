package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import entities.Player;
import entities.Enemy;
import entities.Enemy1;
import entities.Enemy2;
import entities.Guide;
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
	private var guide:Guide;
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		super.create();
		loader = new FlxOgmoLoader(AssetPaths.Level__oel);
		tilemap = loader.loadTilemap(AssetPaths.Tile__png, 16, 16, "Tiles");
		loader.loadEntities(entityCreator, "Entities");
		guide = new Guide(player.x, FlxG.height / 2);
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		FlxG.camera.follow(guide);
		FlxG.camera.setScrollBounds(0, tilemap.width,0, tilemap.height);
		checkTileCollision();
		
		
		add(guide);
		add(tilemap);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		guide.getPlayerPos(player.x, player.y);
		FlxG.collide(tilemap, player);
		if (FlxG.keys.justPressed.R)
			FlxG.resetState();
		
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
	private function checkTileCollision():Void
	{
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);
		
	}
}