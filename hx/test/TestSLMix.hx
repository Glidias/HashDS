package test;
import hashds.ds.ISLMixNode;
import hashds.hutil.XYZ;

/**
 * ...
 * @author Glidias
 */

class TestSLMix implements ISLMixNode<TestSLMix>, implements XYZ
{
	public var data1:Float;
	public var data2:Float;
	
	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	public var next:TestSLMix;
	
	public function new() 
	{
		
	}
	
	public static inline function get(data1:Float, data2:Float, x:Float, y:Float, z:Float):TestSLMix {
		var me:TestSLMix = new TestSLMix();
		me.data1 = data1;
		me.data2 = data2;
		me.x = 0;
		me.y = 0;
		me.z = 0;
		return me;
	}
	
}