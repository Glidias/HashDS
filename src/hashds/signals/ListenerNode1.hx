package hashds.signals;
import hashds.ds.IDLMixNode;

/**
 * ...
 * @author Glidias
 */

class ListenerNode1 implements IDLMixNode<ListenerNode1>
{
	
	public var prev : ListenerNode1;
	public var next : ListenerNode1;
	public var listener : Dynamic -> Void;
	
	public function new() 
	{
		
	}
	
	
}