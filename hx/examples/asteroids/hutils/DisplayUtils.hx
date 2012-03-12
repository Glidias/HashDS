package examples.asteroids.hutils;

import flash.display.DisplayObject;
import hashds.components.common.oneD.Alpha;
import hashds.ds.IRefreshableNode;
import hashds.ds.ISLMixNode;
import hashds.hutil.XY;

/**
 * ...
 * @author Glidias
 */

class DisplayUtils 
{
	public static inline var POSITION:Int = 1;
	public static inline var ROTATION:Int = 2;
	public static inline var SCALE:Int = 4;
	public static inline var ALPHA:Int = 8;

	public static inline function renderDisp(disp:DisplayObject, flags:Int, pos:XY=null, rot:Float=0, scale:XY=null, alpha:Float=1 ):Void {
		
		if ((flags & POSITION) !=0) {
			disp.x = pos.x;
			disp.y = pos.y;
		}
		if ((flags & ROTATION) !=0) {
			disp.rotation = rot * (180 / Math.PI);
		}
		if ((flags & SCALE) !=0) {
			disp.scaleX = scale.x;
			disp.scaleY = scale.y;
		}
	
		if ((flags & ALPHA) !=0) {
			disp.alpha = alpha;
		}
	}
	
	public static inline function refreshHeader(list:IRefreshableNode):Void {
		while (list != null) {
			list.refresh();
			list = list.nextRefresh();
		}
	}
	

	
}