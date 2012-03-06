package com.flaxash.bouygues.socialminute.view
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.DisplayObject;

	public class Clip3DPhoto1 extends MovieClip
	{
		public var elementsMC:MovieClip;
		public function Clip3DPhoto1()
		{
			super();
			
		}
		public function joue():void {
			elementsMC.play();
		}
		public function majElementsDyn(prenom:String,like:String,comment:String,image:DisplayObject):void {
			(elementsMC.prenomMC.contenuTF as TextField).text =  prenom.charAt(0)+ prenom.slice(1).toLowerCase();
			(elementsMC.likeMC.contenuTF as TextField).text = like;
			(elementsMC.commentMC.contenuTF as TextField).text = comment;
			if (image)
			(elementsMC.imageMC as MovieClip).addChild(image);			
		}
	}
}