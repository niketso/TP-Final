package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import openfl.Lib;

/**
 * ...
 * @author ...
 */
class MenuState extends FlxState 
{

private var nombre:FlxText;
	
	override public function create() 
	{
		FlxG.mouse.visible = true;
		var x:Int = Math.floor(FlxG.width / 2 - 40);
		var juego = new FlxText(220, 10,0, "PLATFORMER",25);
		
		add(juego);
		 var Nombre = new FlxText (270, 220, 0, "Nicolas Piccitto", 10);
		var botonNuevoJuego = new FlxButton(x, 120, "New game", nuevo);
		var botonSalir = new FlxButton(x, 160, "Exit", salida);
		add(botonNuevoJuego);
		add(botonSalir);
		add(Nombre);
		
	}
	
	private function nuevo()
	{
		FlxG.switchState(new PlayState());
	}
	
	private function salida()
	{
		Lib.close();
	}
	
}