package game;
import js.Browser;
import pixi.core.Pixi;
import pixi.core.display.Container;
import pixi.core.sprites.Sprite;
import pixi.core.textures.Texture;
import utils.FrameDispatcher;

/**
 * ...
 * @author RO/RO
 */
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
	}
	
	private function onFrame()
	{
		x = Main.renderer.width / 2 - _player.x;
		y = Main.renderer.height / 2 - _player.y;
	}
	
}