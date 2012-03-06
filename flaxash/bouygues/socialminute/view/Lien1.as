package com.flaxash.bouygues.socialminute.view
{
	import flash.display.MovieClip;
	import com.greensock.loading.display.ContentDisplay;
	
	public class Lien1 extends MovieClip
	{
		//sur la scene
		
		
		//variables locales
		public var trackingWidth:Number		= 360;
		public var trackingHeight:Number	= 52;
		
		public var prenom:String;
		public var image:ContentDisplay;
		public var titre:String;
		public var nbLike:String;
		public var nbComment:String;

		public function Lien1()
		{
			super();
		}
		public function majInfos(_prenom:String,_image:ContentDisplay,_imagepp:ContentDisplay,_titre:String,_nbLike:String,_nbComment:String):void {
			prenom = _prenom;
			image = _image;
			titre = _titre;
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