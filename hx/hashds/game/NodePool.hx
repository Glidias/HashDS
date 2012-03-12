package hashds.game;


/**
 * RichardLord's implementation of doubly-linked linked item pool ported over to Haxe .
 * @author Glidias
 */

class NodePool 
{
	private var _tail : Node;
	private var _cacheTail : Node;
	private var _C:Class<Node>;
	public inline function getClass():Class<Node> {
		return _C;
	}
	
	public function new(C:Class<Node>) 
	{
		_C = C;
	}
	
	public function get():Node
	{
		var node : Node = _tail!=null ? _tail : untyped __new__(_C);
		_tail = _tail.prev;
		node.prev = null;
		return node;
	}

		public function dispose( node : Node ):Void
		{
			node.next = null;
			node.prev = _tail;
			_tail = node;
		}
		
		public function cache( node : Node ) : Void
		{
			node.prev = _cacheTail;
			_cacheTail = node;
		}
		
		public function releaseCache() : Void
		{
			while( _cacheTail!=null )
			{
				var node:Node = _cacheTail;
				_cacheTail = node.prev;
				node.next = null;
				node.prev = _tail;
				_tail = node;
			}
		}
	
}