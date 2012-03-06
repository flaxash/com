package com.flaxash.bouygues.socialminute.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.greensock.loading.display.ContentDisplay;
	
	public class Statut1 extends MovieClip
	{
		public var trackingWidth:Number		= 369;
		public var trackingHeight:Number	= 232;
		
		public var prenom:String;
		public var imagepp:ContentDisplay;
		public var statut:String;
		public var nbLike:String;
		public var nbComment:String;

		public function Statut1()
		{
			super();
			
		}
		
		public function majInfos(_prenom:String,_image:ContentDisplay,_imagepp:ContentDisplay,_statut:String,_nbLike:String,_nbComment:String):void {
			prenom = _prenom;
			imagepp = _imagepp;
			statut = _statut;
			nbComment = _nbComment;
			nbLike = _nbLike;
			actualiseElementsDynamiques();
		}
		
		private function actualiseElementsDynamiques():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}