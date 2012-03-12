package hashds.signals;
import hashds.ds.IDLMixNode;

/**
 * ...
 * @author Glidias
 */

class ListenerNode3 implements IDLMixNode<ListenerNode3>
{
	
	public var prev : ListenerNode3;
	public var next : ListenerNode3;
	public var listener : Dynamic -> Dynamic -> Dynamic -> Void;
	
	public function new() 
	{
		
	}
	
}