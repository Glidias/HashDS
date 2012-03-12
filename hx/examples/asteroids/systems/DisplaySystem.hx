package examples.asteroids.systems;
import examples.asteroids.hutils.DisplayUtils;
import examples.asteroids.nodes.DisplayPNode;
import examples.asteroids.nodes.DisplayPRNode;
import examples.asteroids.nodes.DisplayPRSANode;
import examples.asteroids.nodes.DisplayPSANode;
import flash.display.DisplayObjectContainer;
import hashds.ds.DLMixList;
import hashds.game.Game;
import hashds.game.GameSystem;

/**
 * ...
 * @author Glidias
 */

class DisplaySystem extends GameSystem
{

	public function new(container:DisplayObjectContainer) 
	{
		super();
		this.container = container;
	}
	
	private var container:DisplayObjectContainer;
	private var r1:DLMixList<DisplayPNode>;
	private var r2:DLMixList<DisplayPRNode>;
	private var r3:DLMixList<DisplayPRSANode>;
	private var r4:DLMixList<DisplayPSANode>;
	
	override public function addToGame( game : Game ) : Void
		{
			r1= game.getDataStructure(DisplayPNode);
			r2 = game.getDataStructure(DisplayPRNode);
			r3 = game.getDataStructure(DisplayPRSANode);
			r4 = game.getDataStructure(DisplayPSANode);
			
			r1.nodeAdded.add(onAddedNode);
			r2.nodeAdded.add(onAddedNode);
			r3.nodeAdded.add(onAddedNode);
			r4.nodeAdded.add(onAddedNode);
			
			r1.nodeRemoved.add(onRemovedNode);
			r2.nodeRemoved.add(onRemovedNode);
			r3.nodeRemoved.add(onRemovedNode);
			r4.nodeRemoved.add(onRemovedNode);
		}
		
		private function onRemovedNode(node:Dynamic):Void 
		{
			container.removeChild( node.display.displayObject ); // untyped...darn
		}
		
		private function onAddedNode(node:Dynamic):Void 
		{
			container.addChild( node.display.displayObject ); // untyped...darn
		}
	
		override public function update( dt : Float ) : Void
		{
			var d1 = r1.head;
			var d2 = r2.head;
			var d3 = r3.head;
			var d4 = r4.head;
			while (d1 != null) {
				d1.refresh();
				d1  = d1.next;
			}
			while (d2 != null) {
				d2.refresh();
				d2  = d2.next;
			}
			while (d3 != null) {
				d3.refresh();
				d3  = d3.next;
			}
			while (d4 != null) {
				d4.refresh();
				d4  = d4.next;
			}
		}
	
}