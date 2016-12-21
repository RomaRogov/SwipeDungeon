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
	private var _listeners: Map<DisplayObject, Float -> Void>; //onFrame(delta)
	private var _ticker: Ticker;
	
	public function new() 
	{
		_listeners = new Map();
		_ticker = new Ticker();
		_ticker.autoStart = true;
		_ticker.add(update);
	}
	
	public static function init() { _instance = new FrameDispatcher(); }
	
	public static function addListener(listener: DisplayObject, frameFunc: Float -> Void)
	{
		_instance._listeners.set(listener, frameFunc);
	}
	
	private function update()
	{
		for (listener in _listeners.keys())
		{
			if (listener.worldVisible)
			{
				_listeners[listener](_ticker.deltaTime);
			}
		}
	}
	
}