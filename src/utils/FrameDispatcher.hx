package utils;
import pixi.core.display.DisplayObject;
import pixi.core.ticker.Ticker;

/**
 * ...
 * @author RO/RO
 */
class FrameDispatcher 
{
	
	private static var _instance: FrameDispatcher;
	private var _listeners: Map<DisplayObject, Void -> Void>;
	
	public function new() 
	{
		_listeners = new Map();
	}
	
	public static function init() { _instance = new FrameDispatcher(); }
	
	public static function addListener(listener: DisplayObject, frameFunc: Void -> Void)
	{
		_instance._listeners.set(listener, frameFunc);
	}
	
	public static function update()
	{
		for (listener in _instance._listeners.keys())
		{
			if (listener.worldVisible)
			{
				_instance._listeners[listener]();
			}
		}
	}
	
}