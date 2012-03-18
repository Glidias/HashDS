package hashds.game.alchemy.nodes;
import flash.display.DisplayObject;
import flash.Memory;
import hashds.game.alchemy.A_Node;
import hashds.game.alchemy.components.common.A_Tuple2;
import hashds.game.alchemy.components.ds.VectorComponent;

/**
 * ...
 * @author Glenn Ko
 */

class A_DisplayNode extends A_Node
{
	@component('position') public var position:A_Tuple2;
	@component public var display:VectorComponent<DisplayObject>;
		
	override public function getOrderedComponents():Array<Dynamic> {
		return [position, display];
	}
	
	public function new() 
	{
		super();
	}

	public inline function get_position(addr:Int):Int {
		return Memory.getI32( addr );
	}
	public inline function get_display(addr:Int):Int {
		return Memory.getI32( addr + 4 );
	}
	
}