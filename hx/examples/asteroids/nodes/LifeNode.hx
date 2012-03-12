package examples.asteroids.nodes;
import hashds.components.common.oneD.Age;
import hashds.ds.IDead;
import hashds.game.nodes.DLEntNode;
import hashds.game.nodes.SLEntLifeNode;

/**
 * This is mainly to test singly linked list implementation
 * @author Glidias
 */

class LifeNode extends SLEntLifeNode<LifeNode>
{
	public var age:Age;
	
	public function new() 
	{
		super();
	}
	
}