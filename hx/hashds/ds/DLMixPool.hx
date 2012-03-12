package hashds.ds;
import haxe.rtti.Generic;

/**
 * RichardLord's implementation of doubly-linked linked item pool ported over to Haxe as a generic reusable class.
 * @author Glidias
 */

class DLMixPool<T:IDLMixNode<T>> implements Generic
{
	private var _tail : T;
	private var _cacheTail : T;
	private var _C:Class<T>;
	public inline function getClass():Class<T> {
		return _C;
	}
	
	public function new(C:Class<T>) 
	{
		_C = C;
	}
	
	public function get():T
	{
		var node : T = _tail!=null ? _tail : untyped __new__(_C);
		_tail = node.prev;
		node.prev = null;
		return node;
	}

		public function dispose( node : T ):Void
		{
			node.next = null;
			node.prev = _tail;
			_tail = node;
		}
		
		public function cache( node : T ) : Void
		{
			node.prev = _cacheTail;
			_cacheTail = node;
		}
		
		public function releaseCache() : Void
		{
			while( _cacheTail!=null )
			{
				var node:T = _cacheTail;
				_cacheTail = node.prev;
				node.next = null;
				node.prev = _tail;
				_tail = node;
			}
		}
	
}