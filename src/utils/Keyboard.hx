package utils;
import js.Browser;
import js.html.KeyboardEvent;

/**
 * ...
 * @author RO/RO
 */
class Keyboard 
{
	private static var _instance:Keyboard;
	private var _pressedKeys:Array<Int>;
	public static var currentKey:Null<Int>;

	public function new() 
	{
		_pressedKeys = new Array<Int>();
		Browser.document.addEventListener('keydown', onKeyDown);
		Browser.document.addEventListener('keyup', onKeyUp);
	}
	
	public static function init():Void { _instance = new Keyboard(); }
	
	public static function keyPressed(which:Int):Bool 
	{
		return (_instance._pressedKeys.indexOf(which) != -1);
	}
	
	private function onKeyDown(e: KeyboardEvent):Void
	{
		if (_pressedKeys.indexOf(e.which) == -1)
		{
			_pressedKeys.push(e.which);
		}
		currentKey = e.which;
	}
	
	private function onKeyUp(e: KeyboardEvent)
	{
		_pressedKeys.remove(e.which);
		currentKey = null;
	}
}