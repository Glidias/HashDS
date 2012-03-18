package hashds.game.alchemy.nodes;
import de.polygonal.ds.IntIntHashTable;
import flash.display.DisplayObject;
import flash.display.Shape;
import hashds.components.common.twoD.Tuple2;
import hashds.game.alchemy.A_Game;
import hashds.game.alchemy.ComponentLookup;
import hashds.game.alchemy.components.common.A_Tuple2;
import hashds.game.alchemy.components.ds.VectorComponent;

/**
 * Example factory, with the ability to inject component ds dependencies fields (simlilar to how
 * nodes are handled) by registering such an instance, allowing easy construction of components to be added into the game.
 * 
 * @author Glenn Ko
 */

class ExampleFactory 
{
	private var _game:A_Game;
	
	@component('position') public var position:A_Tuple2;
	@component('rotation') public var rotation:A_Tuple2;
	@component('velocity') public var velocity:A_Tuple2;
	
	@component public var display:VectorComponent<DisplayObject>;
	

	public function new(game:A_Game) 
	{
		_game = game;
		
		//ComponentLookup.injectComponentsInto(this);
	}
	
	public function createParticleBullet(x:Float, y:Float, vx:Float, vy:Float):Void {
		var hash:IntIntHashTable = _game.getNewComponentHash();
		
		position.add(hash, x, y);
		velocity.add(hash, vx, vy);
		display.add(hash, new Shape() );
		
		_game.registerComponentHash(hash);	
	}
	
	
	
}