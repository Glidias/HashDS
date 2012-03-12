package hashds.signals;
import hashds.ds.IDLMixNode;

/**
 * ...
 * @author Glidias
 */

class ListenerNode2 implements IDLMixNode<ListenerNode2>
{
	
	public var prev : ListenerNode2;
	public var next : ListenerNode2;
	public var listener : Dynamic -> Dynamic -> Void;
	
	public function new() 
	{
		
	}
	
}