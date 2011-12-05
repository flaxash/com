package com.flaxash.flare3D.primitives
{
	import flare.core.Pivot3D;
	import flare.primitives.Cube;
	
	import flash.geom.Vector3D;
	
	public class WireframeCube extends Pivot3D
	{
		private var listeCubes:Vector.<Cube>;
		private var dimensions:Vector3D;
		public function WireframeCube(_width:Number = 100,_height:Number = 100,_depth:Number = 100,name:String="")
		{
			super(name);
			construitCube();
			dimensions.x = _width;
			dimensions.y = _height;
			dimensions.z = _depth;
		}
		private function construitCube():void {
			var vectorPositions:Vector.<Vector3D> = new Vector.<Vector3D>();
			var cube1:Cube = new Cube("arete1Face1",dimensions.x,10,10,1);
			var cube3:Cube = cube1.clone();
			var cube2:Cube = new Cube("arete2Face1",dimensions.y,10,10,1);
			cube2.rotateZ(90);
			var cube4:Cube = cube2.clone();
			this.addChild(cube1);
			this.addChild(cube2);
			this.addChild(cube3);
			this.addChild(cube4);
		}
	}
}