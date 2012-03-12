package examples.asteroids.nodes;
import examples.asteroids.components.Motion;
import hashds.components.common.oneD.Rotation;
import hashds.components.common.twoD.Position2;
import hashds.game.nodes.DLEntNode;

/**
 * ...
 * @author Glidias
 */

class MovementNode extends DLEntNode<MovementNode>
{
	public var position:Position2;
	public var rotation:Rotation;
	public var motion:Motion;

	public function new() 
	{
		super();
	}
	
}