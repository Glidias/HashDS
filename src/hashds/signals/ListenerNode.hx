package hashds.signals;
import hashds.ds.IDLMixNode;

/**
 * ...
 * @author Glidias
 */

class ListenerNode implements IDLMixNode<ListenerNode>
{
	
	public var prev : ListenerNode;
	public var next : ListenerNode;
	public var listener : Void->Void ;
	
	public function new() 
	{
		
	}
	
}