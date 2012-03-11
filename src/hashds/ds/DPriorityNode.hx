package hashds.ds;

/**
 * ...
 * @author Glidias
 */

class DPriorityNode<T:IPrioritizable>
{
	public var data:T;
	public var next:DPriorityNode<T>;
	public var prev:DPriorityNode<T>;

	public function new() 
	{
		
	}
}