package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxObject;
import entities.Player;
import entities.Enemy;
import entities.Enemy1;
import entities.Enemy2;
import entities.Guide;
import entities.Limit;
import entities.Shot;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import openfl.Lib;

class PlayState extends FlxState
{
	private var player:Player;
	private var enemy1:Enemy1;
	private var enemies1:FlxTypedGroup<Enemy1>;
	private var enemies2:FlxTypedGroup<Enemy2>;
	private var enemy2:Enemy2;
	private var loader:FlxOgmoLoader;
	private var tilemap:FlxTilemap;
	private var guide:Guide;
	private var obsLimit:FlxTypedGroup<Limit>;
	private var playerbar:FlxBar;
	
	
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		super.create();
		enemies1 = new FlxTypedGroup<Enemy1>();
		enemies2 = new FlxTypedGroup<Enemy2>();
		obsLimit = new FlxTypedGroup<Limit>();
		loader = new FlxOgmoLoader(AssetPaths.Level__oel);
		tilemap = loader.loadTilemap(AssetPaths.Tile__png, 16, 16, "Tiles");
		loader.loadEntities(entityCreator, "Entities");
		guide = new Guide(player.x, FlxG.height / 2);
		playerbar = new FlxBar(100, 100, FlxBarFillDirection.BOTTOM_TO_TOP, 5, 30, player, "lives", 0, 10, true);
		
		FlxG.worldBounds.set(0, 0, tilemap.width, tilemap.height);
		FlxG.camera.follow(guide);
		FlxG.camera.setScrollBounds(0, tilemap.width,0, tilemap.height);
		checkTileCollision();

		add(guide);
		add(tilemap);
		add(obsLimit);
		add(playerbar);
		
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		guide.getPlayerPos(player.x, player.y);
		playerbar.x = player.x - 7;
		playerbar.y = player.y + 3;
		
		if (FlxG.keys.justPressed.R)
		FlxG.resetState();
		
		if (FlxG.keys.justPressed.P)
            pauseState();
		if (FlxG.keys.justPressed.ESCAPE)
			Lib.close();
		
		FlxG.collide(tilemap, player);
		FlxG.collide(enemies1, tilemap);
		enemies1.forEachAlive(checkEnemyVision);
		FlxG.collide(enemies2, tilemap);
		FlxG.collide(enemies1, player, colPlayerEnemy1);
		FlxG.collide(enemies2, player, colPlayerEnemy2);
		FlxG.overlap(obsLimit, player, colPlayerLimit);
		FlxG.collide(enemies1, player.get_bullets(),colEnemybullet);
		FlxG.collide(enemies2, player.get_bullets(),colEnemybullet2);

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
				enemies1.add(enemy1);
				add(enemies1);
				
			case "enemy2":
				enemy2 = new Enemy2();

				enemy2.x = x;
				enemy2.y = y;
				enemies2.add(enemy2);
				add(enemies2);
			
			case "Limit":
				var obstaculoLimit = new Limit();
				obstaculoLimit.x = x;
				obstaculoLimit.y = y;
				obsLimit.add(obstaculoLimit);
				add(obsLimit);
		}
	}
	private function checkTileCollision():Void
	{
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);

	}
	private function checkEnemyVision(e:Enemy1):Void
	{
		if (tilemap.ray(e.getMidpoint(), player.getMidpoint()))
		{
			e.seesPlayer = true;
			e.playerPos.copyFrom(player.getMidpoint());
		}
		else
			e.seesPlayer = false;
	}
	private function colPlayerEnemy1(e:Enemy1, p:Player):Void
	{
		enemies1.remove(e, true);
		player.die();
	}
	
	private function colPlayerEnemy2(e:Enemy2, p:Player):Void
	{
		enemies2.remove(e, true);
		player.die();
	}
	private function colPlayerLimit(e:Limit, p:Player):Void
	{
		p.getDamage(Reg.damageLimit);
		
	}
	private function colEnemybullet(e:Enemy1,s:Shot):Void
	{
		
		enemies1.remove(e, true);
		player.get_bullets().remove(s, true);
		
	}
	private function colEnemybullet2(e:Enemy2,s:Shot):Void
	{
		
		enemies2.remove(e, true);
		player.get_bullets().remove(s, true);
		
	}
	private function pauseState():Void
    {
        var substate:PauseState = new PauseState(FlxColor.TRANSPARENT);
        openSubState(substate);
    }
}