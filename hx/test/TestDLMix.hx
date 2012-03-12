package test;
import hashds.components.common.threeD.Position3;
import hashds.components.common.threeD.Rotation3;
import hashds.components.common.threeD.Scale3;
import hashds.ds.IDLMixNode;
import hashds.ds.ISLMixNode;
import hashds.game.Entity;
import hashds.game.IEntityMarker;
import hashds.hutil.XYZ;
import haxe.rtti.Infos;
import hashds.ds.Indexable;

/**
 * ...
 * @author Glidias
 */

class TestDLMix implements IDLMixNode<TestDLMix>, implements XYZ 
// boiler-plate
,implements IEntityMarker
#if (!entityOwns && usePolygonal) , implements Indexable #end

{
	// IEntityMarker, IDLMixNode variables
	public var entity:Entity;
	public var next:TestDLMix;
	public var prev:TestDLMix;
	
	// Components go here
	public var pos:Position3;
	public var rot:Rotation3;
	public var scale:Scale3;

	// boiler-plate if supporting polygonal and family owns hash implementation
	#if (!entityOwns && usePolygonal)
	public var index:Int;
	#end
	
	// extra misc data
	public var data1:Float;
	public var data2:Float;
	public var x:Float;
	public var y:Float;
	public var z:Float;
	
	public function new() 
	{
		
	}

	
}