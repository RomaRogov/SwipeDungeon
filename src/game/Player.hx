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
	private var _targetPos: Point;
	private var _timeSinceLastMove: Float;
	private var _stepTime: Float = 5;
	private var _face: Sprite;
	
	public function new() 
	{
		var firstFrameTex = Texture.fromImage("assets/player_frame1.png");
		firstFrameTex.baseTexture.scaleMode = 1;
		super(firstFrameTex);
		
		var faceTex = Texture.fromImage("assets/face.png");
		faceTex.baseTexture.scaleMode = 1;
		_face = new Sprite(faceTex);
		_face.anchor.set(.5, 1);
		addChild(_face);
		
		scale.set(2);
		anchor.set(.5, 1);
		position.set(16);
		
		_targetPos = new Point(x, y);
		_timeSinceLastMove = 0;
		tint = 0xFF00FF;
		_face.tint = 0xFFFF00;
		
		GestureRecognizer.addListener(onSwipe);
		utils.FrameDispatcher.addListener(this, onFrame);
	}
	
	private function onFrame(delta: Float)
	{
		position.x += (_targetPos.x - position.x) * .3;
		position.y += (_targetPos.y - position.y) * .3;
		_timeSinceLastMove += delta;
	}
	
	private function onSwipe(direction: String)
	{
		if (_timeSinceLastMove < _stepTime) { return; }
		
		switch (direction)
		{
			case "left":  _targetPos.x += 32;
			case "right": _targetPos.x -= 32;
			case "up":    _targetPos.y += 32;
			case "down":  _targetPos.y -= 32;
		}
		
		_timeSinceLastMove = 0;
	}
	
}