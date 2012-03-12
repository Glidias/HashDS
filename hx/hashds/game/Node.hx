package hashds.game;
import hashds.ds.IDLMixNode;
import hashds.ds.Indexable;
import hashds.game.Entity;

/**
 * Abstract base class Node.
 * 
 * The default Node implementation for Ash, by RichardLord, ported over to Haxe/HashDS for dynamic (non-strict) typing. 
 * This class is usually extended to support a concrete implementation, as the next/prev pointers aren't strictly typed and so can be type-coerced during list iteration.
 * 
 * @see hashds.game.NodeList
 * 
 * @author Glidias
 */

class Node 
#if (usePolygonal && !entityOwns) implements Indexable #end
{
	public var entity:Entity;
	public var next:Dynamic;
	public var prev:Dynamic;
	
	#if (usePolygonal && !entityOwns)
	public var index:Int; 
	#end

	public function new() 
	{
		
	}
	
}