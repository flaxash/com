package com.flaxash.flare3D.scene
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	
	import flare.core.Light3D;
	import flare.core.Pivot3D;
	import flare.core.Texture3D;
	import flare.events.MouseEvent3D;
	import flare.materials.Shader3D;
	import flare.materials.filters.ColorFilter;
	import flare.materials.filters.LightFilter;
	import flare.materials.filters.TextureFilter;
	import flare.primitives.Cube;
	import flare.primitives.Plane;
	import flare.system.Device3D;
	
	import flash.geom.Vector3D;
	
	import org.osflash.signals.Signal;
	
	public class SceneDD extends Pivot3D
	{
		public var workshops3D:Pivot3D;
		public var seminaires3D:Pivot3D;
		public var off3D:Pivot3D;
		public var signalMouse:Signal;
		public var conteneur:Pivot3D;
		
		private var cubes:Vector.<Pivot3D>;
		
		private var wireframeTexture:Texture3D;
		public var light1 : Light3D;
		public var light2 : Light3D;
		private static const URL_WORKSHOPS3D:String= "workshops.f3d";
		private static const URL_SEMINAIRES3D:String ="workshops.f3d";
		private static const URL_OFF3D:String = "workshops.f3d";
		private static const TAILLE_CUBE:uint = 20;
		
		public function SceneDD(name:String="")
		{
			super(name);
		}
		public function placeTitres():void 
		{
			conteneur= new Pivot3D();
			signalMouse = new Signal(Pivot3D);
			conteneur.parent = scene;
			//placeLights();
			placeObjects();
			placeProjets();
			
			
		}
		public function moveCubesDown():void {
			for each (var cube:Pivot3D in cubes) {
				TweenLite.to(cube,2,{y:TAILLE_CUBE/2*cube.scaleX,ease:Bounce.easeOut});
			}
			TweenLite.to(workshops3D,1,{y:150});
			TweenLite.to(seminaires3D,1,{y:150});
			TweenLite.to(off3D,1,{y:150});
			trace("moveCubesDown fini");
		}
		private function placeObjects():void {
			workshops3D = this.scene.addChildFromFile(URL_WORKSHOPS3D,conteneur);
			workshops3D.rotateX(-90,true);
			workshops3D.x = -400;
			//workshops3D.z = 400;
			workshops3D.y = 10;
			seminaires3D = this.scene.addChildFromFile(URL_SEMINAIRES3D,conteneur);
			seminaires3D.rotateX(-90,true);
			seminaires3D.x=0;
			seminaires3D.y = 10;
			off3D = this.scene.addChildFromFile(URL_OFF3D,conteneur);
			off3D.rotateX(-90,true);
			off3D.x=400;
			off3D.y = 10;
			trace("coordonnées de l'objet : " + "off3D("+off3D.x+";"+off3D.y+";"+off3D.z+")");
			trace("coordonnées de l'objet : " + "workshops3D("+workshops3D.x+";"+workshops3D.y+";"+workshops3D.z+")");
			trace("coordonnées de l'objet : " + "seminaires3D("+seminaires3D.x+";"+seminaires3D.y+";"+seminaires3D.z+")");
			//ajoute un plan pour le sol
			/*
			var materialBlanc:Shader3D;
			var blanc:Number = 0xFFFFFF;
			materialBlanc = new Shader3D( "colorMaterial1" );
			materialBlanc.filters = [ new ColorFilter(blanc,1)];
			var planSol:Plane = new Plane("sol",3000,3000,1,materialBlanc);
			planSol.rotateX(90);
			planSol.parent = conteneur;
			*/
		}
		private function placeProjets():void
		{
			cubes = new Vector.<Pivot3D>();
			var monCube:Cube = new Cube("",20,20,20,1);
			//conteneur = new Pivot3D();
			//conteneur.parent = scene;
			var materialBlanc:Shader3D;
			var blanc:Number = 0xEEEEEE;
			materialBlanc = new Shader3D( "colorMaterial1" );
			materialBlanc.filters = [ new ColorFilter(blanc,1)];
			var materialRouge:Shader3D;
			var rouge:Number = 0xDD0000;
			materialRouge = new Shader3D( "colorMaterial2" );
			materialRouge.filters = [ new ColorFilter(rouge,1)];
			/*wireframeTexture = scene.addTextureFromFile("wf2wr.png");
			
			
			var material:Shader3D = new Shader3D( "wireframeFake" );
			material.filters.push( new TextureFilter(wireframeTexture) );
			//material.filters.push( new AlphaMaskFilter( 0.2) );
			
			material.build();
			material.twoSided = true;
			*/
			var x:Number;
			var y:Number;
			var z:Number;
			
			var newCube:Pivot3D;
			var total:uint = 20;
			var pasZ:uint = 50;
			var pasX:uint = 50;

			//zone Workshops
			for ( var i:int = 0; i < total; i++ )
			{
				x = workshops3D.x + Math.round(i/5)*pasX - 100;
				y = workshops3D.y + Math.random() * 200;
				z = workshops3D.z + (i%5)*pasZ - 100;
				//z = workshops3D.z + Math.random() * 200 - 100;
				//var z:Number = Math.random() * 1000 - 500;
				
				newCube=  monCube.clone();
				// create a new shader.
				newCube.scaleX = newCube.scaleY = newCube.scaleZ = 1+Math.random()/2;
				newCube.x = x;
				newCube.y = y;
				newCube.z = z;
				newCube.userData = new Object();
				newCube.userData.h = z;
				newCube.userData.num = i;
				
				if (Math.random()>0.3) newCube.setMaterial(materialBlanc) else newCube.setMaterial(materialRouge);
				cubes.push(newCube);
				newCube.parent = conteneur;
				newCube.addEventListener( MouseEvent3D.CLICK,onClick);
				//newCube.addEventListener( MouseEvent3D.MOUSE_OVER,onRollOver);
				//newCube.addEventListener(MouseEvent3D.MOUSE_OUT,onRollOut);
				
				
			}

			
			//zone Seminaires
			for ( var j:int = 0; j < total; j++ )
			{
				x = seminaires3D.x + Math.round(j/5)*pasX - 100;
				y = seminaires3D.y + Math.random() * 200;
				z = seminaires3D.z + (j%5)*pasZ - 100;
				//var z:Number = Math.random() * 1000 - 500;
				
				newCube =  monCube.clone();
				// create a new shader.
				newCube.scaleX = newCube.scaleY = newCube.scaleZ = 1+Math.random()/2;

				newCube.x = x;
				newCube.y = y;
				newCube.z = z;
				newCube.userData = new Object();
				newCube.userData.h = z;
				newCube.userData.num = j;
				if (Math.random()>0.3) newCube.setMaterial(materialBlanc) else newCube.setMaterial(materialRouge);
				cubes.push(newCube);
				newCube.parent = conteneur;
				newCube.addEventListener( MouseEvent3D.CLICK,onClick);
				//newCube.addEventListener( MouseEvent3D.MOUSE_OVER,onRollOver);
				//newCube.addEventListener(MouseEvent3D.MOUSE_OUT,onRollOut);
				
				
			}

			
			//zone Off
			for ( var k:int = 0; k < total; k++ )
			{
				x = off3D.x + Math.round(k/5)*pasX - 100;
				y = off3D.y + Math.random() * 200;
				z = off3D.z + (k%5)*pasZ - 100;
				//var z:Number = Math.random() * 1000 - 500;
				
				newCube =  monCube.clone();
				// create a new shader.
				newCube.scaleX = newCube.scaleY = newCube.scaleZ = 1+Math.random()/2;

				newCube.x = x;
				newCube.y = y;
				newCube.z = z;
				newCube.userData = new Object();
				newCube.userData.h = z;
				newCube.userData.num = k;
				if (Math.random()>0.3) newCube.setMaterial(materialBlanc) else newCube.setMaterial(materialRouge);
				cubes.push(newCube);
				newCube.parent = conteneur;
				newCube.addEventListener( MouseEvent3D.CLICK,onClick);
				//newCube.addEventListener( MouseEvent3D.MOUSE_OVER,onRollOver);
				//newCube.addEventListener(MouseEvent3D.MOUSE_OUT,onRollOut);
				
				
			}

			
			
		}
		private function placeLights():void {
			light1=new Light3D("l1",Light3D.DIRECTIONAL);
			light1.infinite=true;
			light1.color=new Vector3D(0.1,0.1,0.1,1);
			light1.y = 400;
			light1.x = 300;
			light1.z = -200;
			light1.multipler=14;
			light1.lookAt(0,0,0);
			var vecDir:Vector3D=light1.getDir(false);
			scene.defaultLight=light1;
			scene.addChild(light1);
			light2=new Light3D("l2",Light3D.DIRECTIONAL);
			light2.infinite=true;
			light2.color=new Vector3D(0.1,0.1,0.1,1);
			light2.y = 400;
			light2.x = -300;
			light2.z = 200;
			light2.multipler=14;
			light2.lookAt(0,0,0);
			
			scene.addChild(light2);

			
		}
		private function onRollOver(me:MouseEvent3D):void {
			signalMouse.dispatch(Pivot3D(me.target));
		}
		private function onClick(me:MouseEvent3D):void {
			signalMouse.dispatch(Pivot3D(me.target));
		}

	}
}