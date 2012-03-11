package test;
import hashds.game.Game;
import hashds.game.GameSystem;
import hashds.game.Node;
import hashds.game.NodeList;

/**
 * ...
 * @author Glidias
 */

class TestSystem extends GameSystem
{

	private var _game:Game;
	public function new() 
	{
		
	}
	private var p:NodeList;
	private var prs:NodeList;
	private var ps:NodeList;
	private var pr:NodeList;
	
	override public function addToGame( game : Game ) : Void
		{
			_game = game;
			p = game.getDataStructure( PNode);
			prs = game.getDataStructure( PRSNode);
			ps = game.getDataStructure( PSNode);
			pr = game.getDataStructure( PRNode);
		}

		override public function update( dt : Int ) : Void
		{
			var n:Node = p.tail;
			while ( n != null) {	
				_game.removeEntity(n);	
				n = n.prev;
			}
		}
	
}