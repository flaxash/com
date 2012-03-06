package com.flaxash.bouygues.socialminute.view
{
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	public class AmiActif extends MovieClip
	{
		//sur la scene
		public var prenomMC:MovieClip;
		
		//variables locales
		public var trackingWidth:Number		= 380;
		public var trackingHeight:Number	= 200;
		
		public var prenom:String;

		public function AmiActif()
		{
			super();
		}
		public function majInfos(_prenom:String):void {
			prenom = _prenom;
			actualiseElementsDynamiques();
		}
		
		private function actualiseElementsDynamiques():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}