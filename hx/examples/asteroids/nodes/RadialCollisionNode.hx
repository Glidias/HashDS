package examples.asteroids.nodes;
import hashds.components.common.oneD.Size;
import hashds.components.common.twoD.Position2;
import hashds.game.nodes.DLEntNode;

/**
 * ...
 * @author Glidias
 */

class RadialCollisionNode extends DLEntNode<RadialCollisionNode>
{
	public var position:Position2;
	public var size:Size;
	
	public function new() 
	{
		super();
	}
	
}