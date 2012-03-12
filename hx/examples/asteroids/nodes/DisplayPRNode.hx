package examples.asteroids.nodes;
import examples.asteroids.components.Display;
import examples.asteroids.hutils.DisplayUtils;
import hashds.components.common.twoD.Position2;
import hashds.components.common.twoD.Rotation2;
import hashds.ds.IRefreshable;
import hashds.ds.IRefreshableNode;
import hashds.game.nodes.DLEntNode;

/**
 * ...
 * @author Glidias
 */

class DisplayPRNode extends DLEntNode<DisplayPRNode>, implements IRefreshableNode
{
	public var display:Display;
	public var pos:Position2;
	public var rot:Rotation2;

	public function new() 
	{
		super();
	}
	
	inline public function refresh():Void {
		DisplayUtils.renderDisp(display.displayObject, DisplayUtils.POSITION | DisplayUtils.ROTATION, pos, rot);
	}
	inline public function nextRefresh():IRefreshableNode {
		return next;
	}
}