package states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class PauseState extends FlxSubState 
{

	public function new(BGColor:FlxColor=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
        FlxG.mouse.visible = true;
        var x:Int = Math.floor(FlxG.width / 2 - 40);
         var Pausa = new FlxButton(x, 300, "Return to Game", returnToGame);

        var Exit = new FlxButton(x, 400, "Exit Game", salida);

        add(Pausa);
        add(Exit);
    }

    private function returnToGame()
    {
        close();
        FlxG.mouse.visible = false;
    }

    private function salida()
    {
        FlxG.switchState(new MenuState());
    }
	
    

		
	
	
}