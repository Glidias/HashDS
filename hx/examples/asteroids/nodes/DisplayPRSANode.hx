package examples.asteroids.nodes;
import examples.asteroids.components.Display;
import examples.asteroids.hutils.DisplayUtils;
import hashds.components.common.oneD.Alpha;
import hashds.components.common.twoD.Position2;
import hashds.components.common.twoD.Rotation2;
import hashds.components.common.twoD.Scale2;
import hashds.ds.IRefreshable;
import hashds.ds.IRefreshableNode;
import hashds.game.nodes.DLEntNode;

/**
 * ...
 * @author Glidias
 */

class DisplayPRSANode extends DLEntNode<DisplayPRSANode>, implements IRefreshableNode
{

	public var display:Display;
	public var pos:Position2;
	public var rot:Rotation2;
	public var scale:Scale2;
	public var alpha:Alpha;
	
	public function new() 
	{
		super();
	}
	
	inline public function refresh():Void {
		DisplayUtils.renderDisp(display.displayObject, DisplayUtils.POSITION | DisplayUtils.ROTATION | DisplayUtils.SCALE | DisplayUtils.ALPHA, pos, rot, scale, alpha.amount);
	}
	inline public function nextRefresh():IRefreshableNode {
		return next;
	}
	
}