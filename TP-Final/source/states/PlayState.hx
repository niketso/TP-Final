package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import entities.Player;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;                      

class PlayState extends FlxState
{
	private var player:Player;
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

		}
	}
	
}