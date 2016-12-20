package game;

import js.Browser;
import pixi.core.math.Point;
import pixi.core.sprites.Sprite;
import pixi.core.textures.BaseTexture;
import pixi.core.textures.Texture;
import utils.FrameDispatcher;
import utils.GestureRecognizer;
import utils.KeyCode;
import utils.Keyboard;

/**
 * ...
 * @author RO/RO
 */
class Player extends Sprite
{
	private static var _instance: Player;
	private var _targetPos: Point;
	
	public function new() 
	{
		_instance = this;
		
		var firstFrameTex = Texture.fromImage("assets/player_frame1.png");
		firstFrameTex.baseTexture.scaleMode = 1;
		super(firstFrameTex);
		
		utils.FrameDispatcher.addListener(this, onFrame);
		
		scale.set(2);
		anchor.set(.5);
		position.set(16);
		
		_targetPos = new Point(x, y);
		
		GestureRecognizer.addListener(onSwipe);
	}
	
	private function onFrame()
	{
		position.x += (_targetPos.x - position.x) * .3;
		position.y += (_targetPos.y - position.y) * .3;
	}
	
	private function onSwipe(direction: String)
	{
		switch (direction)
		{
			case "left":  _targetPos.x += 32;
			case "right": _targetPos.x -= 32;
			case "up":    _targetPos.y += 32;
			case "down":  _targetPos.y -= 32;
		}
	}
	
	public static function Shift(direction: String) { _instance.onSwipe(direction); }
	
}