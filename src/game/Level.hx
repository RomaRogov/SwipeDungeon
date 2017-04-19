package game;
import game.Level.BinaryNode;
import js.Browser;
import pixi.core.Pixi;
import pixi.core.display.Container;
import pixi.core.graphics.Graphics;
import pixi.core.sprites.Sprite;
import pixi.core.textures.Texture;
import utils.FrameDispatcher;

/**
 * ...
 * @author RO/RO
 */
class BinaryNode
{
	private var _roomSize:Int = 10;
	
	public var _x: Int;
	public var _y: Int;
	public var _w: Int;
	public var _h: Int;
	
	public var _roomX: Int;
	public var _roomY: Int;
	public var _roomW: Int;
	public var _roomH: Int;
	
	public var _root: BinaryNode;
	public var _isLeft: Bool;
	
	public var leftNode: BinaryNode;
	public var rightNode: BinaryNode;
	public var hasChildren:Bool;
	
	public function new(x: Int, y: Int, width: Int, height: Int, root: BinaryNode, isLeft: Bool)
	{
		_root = root;
		_isLeft = isLeft;
		
		_x = x;
		_y = y;
		_w = width;
		_h = height;
		
		var splittingHor:Bool = width > height;//(Math.random() > .5); //choose split direction
		var randomFactor = .3 + Math.random() * .3; //choose split position
		
		//Split and return
		if (splittingHor)
		{
			if (width >= _roomSize * 2)
			{
				var pos = _roomSize + Math.floor(randomFactor * (width - _roomSize * 2));
				leftNode = new BinaryNode(x, y, pos, height, this, true);
				rightNode = new BinaryNode(x + pos, y, width - pos, height, this, false);
				hasChildren = true;
				return;
			}
		}
		else
		{
			if (height >= _roomSize * 2)
			{
				var pos = _roomSize + Math.floor(randomFactor * (height - _roomSize * 2));
				leftNode = new BinaryNode(x, y, width, pos, this, true);
				rightNode = new BinaryNode(x, y + pos, width, height - pos, this, false);
				hasChildren = true;
				return;
			}
		}
		hasChildren = false;
		
		//Can't split, make room then
		_roomX = 1 + Math.floor(Math.random() * _w / 2);
		_roomY = 1 + Math.floor(Math.random() * _h / 2);
		_roomW = Math.floor(Math.max((.6 + Math.random() * .4) * (_w - _roomX), _roomSize / 2 - 2));
		_roomH = Math.floor(Math.max((.6 + Math.random() * .4) * (_h - _roomY), _roomSize / 2 - 2));
	}
	
	public function drawRect(where: Graphics)
	{
		var dr = 32;
		
		if (hasChildren)
		{
			leftNode.drawRect(where);
			rightNode.drawRect(where);
			return;
		}
		where.drawRect(_x * dr, _y * dr, _w * dr, _h * dr);
		where.beginFill(0xFFFFFF, .6);
		where.drawRect((_x + _roomX) * dr, (_y + _roomY) * dr, _roomW * dr, _roomH * dr);
		where.endFill();
		
		if (_isLeft)
		{
			where.moveTo(getCenterX() * dr, getCenterY() * dr);
			where.lineTo(_root.rightNode.getCenterX() * dr, _root.rightNode.getCenterY() * dr);
		}
	}
	
	public function getCenterX():Float
	{
		return (_x + _roomX + _roomW / 2);
	}
	
	public function getCenterY():Float
	{
		return (_y + _roomY + _roomH / 2);
	}
}
 
class Level extends Container
{
	private var _player: Player;

	public function new() 
	{
		super();
		
		var floorTex = Texture.fromImage("assets/floor.png");
		var tiles = new Container();
		
		for (i in 0...10)
			for (j in 0...10)
			{
				var tile:Sprite = new Sprite(floorTex);
				tile.x = j * 32;
				tile.y = i * 32;
				tiles.addChild(tile);
			}
		//tiles.cacheAsBitmap = true;
		addChild(tiles);
		
		_player = new Player();
		addChild(_player);
		
		utils.FrameDispatcher.addListener(this, onFrame);
		
		/*var debugGraph = new Graphics();
		debugGraph.lineStyle(1, 0xFFFFFF, .3);
		addChild(debugGraph);
		
		var debugBSP = new BinaryNode(0, 0, 50, 50, null, true);
		debugBSP.drawRect(debugGraph);*/
	}
	
	private function onFrame(delta: Float)
	{
		x = Main.renderer.width / 2 - _player.x;
		y = Main.renderer.height / 2 - _player.y;
	}
	
}