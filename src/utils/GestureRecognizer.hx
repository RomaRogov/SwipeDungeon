package utils;
import js.Browser;
import pixi.core.math.Point;
import pixi.interaction.InteractionData;
import pixi.interaction.InteractionManager;

/**
 * ...
 * @author RO/RO
 */
class GestureRecognizer 
{
	private static var _instance: GestureRecognizer;
	
	private var _manager: InteractionManager;
	private var _start: Point;
	private var _maxDeviation: Point;
	private var _allowedDeviation: Float = .2;
	private var _minDistance:Float = .1;
	private var _actionDistance: Float = 32;
	private var _listeners: Array<String -> Void>;

	public function new() 
	{
		_manager = cast Main.renderer.plugins.interaction;
		
		_manager.on("pointerdown", onDown);
		_manager.on("pointermove", onMove);
		_manager.on("pointerup", onUp);
		_manager.on("pointerout", onOut);
		
		_listeners = new Array();
	}
	
	public static function init() { _instance = new GestureRecognizer(); }
	
	public static function addListener(func: String -> Void) { _instance._listeners.push(func); }
	
	private function onDown(e: Dynamic)
	{
		_start = e.data.global.clone();
		_maxDeviation = new Point();
	}
	
	private function onMove(e: Dynamic)
	{
		if (_start == null) { return; }
		
		_maxDeviation.x = Math.max(Math.abs(e.data.global.x - _start.x), _maxDeviation.x);
		_maxDeviation.y = Math.max(Math.abs(e.data.global.y - _start.y), _maxDeviation.y);
		
		var distance = Math.sqrt(_maxDeviation.x * _maxDeviation.x + _maxDeviation.y * _maxDeviation.y);
		var screenMagnitude = Math.sqrt(Main.renderer.width * Main.renderer.width + Main.renderer.height * Main.renderer.height);
		
		if (distance < _actionDistance) { return; } //check distance
		checkSwipe(e.data.global);
		
		_start = e.data.global.clone();
		_maxDeviation = new Point();
	}
	
	private function onUp(e: Dynamic)
	{
		if (_start == null || _maxDeviation == null) { return; }
		
		var distance = Math.sqrt(_maxDeviation.x * _maxDeviation.x + _maxDeviation.y * _maxDeviation.y);
		var screenMagnitude = Math.sqrt(Main.renderer.width * Main.renderer.width + Main.renderer.height * Main.renderer.height);
		
		dispatch("end");
		
		//reset all states
		_start = null;
		_maxDeviation = new Point();
	}
	
	private function onOut()
	{
		_start = null;
		_maxDeviation = null;
	}
	
	private function checkSwipe(currentPos: Point)
	{
		var deviation:Float = Math.min(_maxDeviation.x, _maxDeviation.y) / Math.max(_maxDeviation.x, _maxDeviation.y);
		if (deviation > _allowedDeviation) { return; } //check deviation
		
		var delta = new Point(currentPos.x - _start.x, currentPos.y - _start.y);
		if (_maxDeviation.x > _maxDeviation.y) //Horizontal
		{
			if (delta.x > 0) { dispatch("right"); }
			else { dispatch("left"); }
		}
		else
		{
			if (delta.y > 0) { dispatch("down"); }
			else { dispatch("up"); }
		}
	}
	
	private function dispatch(side: String)
	{
		for (listener in _listeners) { listener(side); };
	}
	
	private static function sign(x: Float)
	{
		return (x > 0 ? 1 : (x < 0 ? -1 : 0));
	}
}