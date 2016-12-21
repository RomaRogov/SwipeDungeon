package;

import game.Level;
import game.Player;
import js.Browser;
import js.Lib;
import pixi.core.display.Container;
import pixi.core.renderers.Detector;
import pixi.core.renderers.SystemRenderer;
import utils.FrameDispatcher;
import utils.GestureRecognizer;
import utils.Keyboard;
/**
 * ...
 * @author RO/RO
 */
class Main 
{
	
	public static var renderer: SystemRenderer;
	private var _stage: Container;
	
	public function new()
	{
		//Create PIXI stage and renderer
		_stage = new Container();
		var width:Float  = Browser.window.innerWidth  ? Browser.window.innerWidth  : Browser.document.documentElement.clientWidth;
		var height:Float = Browser.window.innerHeight ? Browser.window.innerHeight : Browser.document.documentElement.clientHeight;
		
		renderer = Detector.autoDetectRenderer(width, height, { backgroundColor: 0x000000, roundPixels: false });
		Browser.document.body.appendChild(renderer.view);
		Browser.window.requestAnimationFrame(cast onFrame);
		Browser.window.onresize = onResize;
		
		//Init static utils
		FrameDispatcher.init();
		Keyboard.init();
		GestureRecognizer.init();
		
		//Create player
		var level = new Level();
		_stage.addChild(level);
		
		//var btns = new DirectionButtons();
		//_stage.addChild(btns);
	}
	
	function onFrame()
	{
		Browser.window.requestAnimationFrame(cast onFrame);
		renderer.render(_stage);
	}
	
	function onResize()
	{
		var width:Float  = Browser.window.innerWidth  ? Browser.window.innerWidth  : Browser.document.documentElement.clientWidth;
		var height:Float = Browser.window.innerHeight ? Browser.window.innerHeight : Browser.document.documentElement.clientHeight;
		
		renderer.resize(width, height);
	}
	
	static function main() 
	{
		new Main();
	}
}