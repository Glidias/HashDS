package examples.asteroids.nodes;
import examples.asteroids.components.Display;
import examples.asteroids.hutils.DisplayUtils;
import hashds.components.common.twoD.Position2;
import hashds.ds.IRefreshable;
import hashds.ds.IRefreshableNode;
import hashds.game.nodes.DLEntNode;

/**
 * ...
 * @author Glidias
 */

class DisplayPNode extends DLEntNode<DisplayPNode>,implements IRefreshableNode
{
	public var display:Display;
	public var pos:Position2;

	public function new() 
	{
		super();
	}
	
	inline public function refresh():Void {
		DisplayUtils.renderDisp(display.displayObject, DisplayUtils.POSITION, pos);
	}
	inline public function nextRefresh():IRefreshableNode {
		return next;
	}
}