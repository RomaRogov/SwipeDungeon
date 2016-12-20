package ui;
import game.Player;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.math.shapes.Rectangle;

/**
 * ...
 * @author RO/RO
 */
class DirectionButtons extends Container
{
	private var _leftBtn: Graphics;
	private var _rightBtn: Graphics;
	private var _upBtn: Graphics;
	private var _downBtn: Graphics;
	
	public function new() 
	{
		super();
		
		var size = 100;
		
		_leftBtn = fillBtn(size);
		_leftBtn.position.set(size, Main.renderer.height / 2);
		_leftBtn.on("pointerdown", function() { Player.Shift("left"); });
		addChild(_leftBtn);
		
		_rightBtn = fillBtn(size);
		_rightBtn.position.set(Main.renderer.width - size, Main.renderer.height / 2);
		_rightBtn.on("pointerdown", function() { Player.Shift("right"); });
		addChild(_rightBtn);
		
		_upBtn = fillBtn(size);
		_upBtn.position.set(Main.renderer.width / 2, size);
		_upBtn.on("pointerdown", function() { Player.Shift("up"); });
		addChild(_upBtn);
		
		_downBtn = fillBtn(size);
		_downBtn.position.set(Main.renderer.width / 2, Main.renderer.height - size);
		_downBtn.on("pointerdown", function() { Player.Shift("down"); });
		addChild(_downBtn);
	}
	
	private function fillBtn(size: Float):Graphics
	{
		var btn:Graphics = new Graphics();
		btn.beginFill(0xFFFFFF, .6);
		btn.drawRect( -size/2, -size/2, size, size);
		btn.endFill();
		btn.hitArea = new Rectangle( -size/2, -size/2, size, size);
		btn.interactive = true;
		return btn;
	}
}