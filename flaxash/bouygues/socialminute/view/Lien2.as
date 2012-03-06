package com.flaxash.bouygues.socialminute.view
{
	import flash.display.MovieClip;
	import com.greensock.loading.display.ContentDisplay;

	
	public class Lien2 extends MovieClip
	{
		public var trackingWidth:Number		= 320;
		public var trackingHeight:Number	= 160;
		
		public var prenom:String;
		public var image:ContentDisplay;
		public var imagepp:ContentDisplay;
		public var titre:String;
		public var nbLike:String;
		public var nbComment:String;


		public function Lien2()
		{
			super();
		}
		public function majInfos(_prenom:String,_image:ContentDisplay,_imagepp:ContentDisplay,_titre:String,_nbLike:String,_nbComment:String):void {
			prenom = _prenom;
			image = _image;
			imagepp = _imagepp;
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