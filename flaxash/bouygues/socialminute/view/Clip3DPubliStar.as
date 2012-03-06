package com.flaxash.bouygues.socialminute.view
{
	import com.flaxash.bouygues.socialminute.utils.*;
	import flash.geom.Rectangle;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class Clip3DPubliStar extends MovieClip
	{
		public var elementsMC:MovieClip;
		
		public function Clip3DPubliStar()
		{
			super();
		}
		public function joue():void {
			elementsMC.play();
		}
		public function majElementsDyn(like:String,comment:String,statut:String,image:DisplayObject):void {
			var message:String = statut;
			if (statut.length>100) {
				message = statut.slice(0,99);
				message +=" ...";
			}
			(elementsMC.messageMC.contenuTF as TextField).text = message;
			
			(elementsMC.likeMC.contenuTF as TextField).text = like;
			(elementsMC.commentMC.contenuTF as TextField).text = comment;
			//DisplayUtils.fitIntoRect(image,new Rectangle(0,0,160,200),true,Alignment.MIDDLE);
			
			
			//image.x = image.y = 0;
			if (image) {
				image.rotation = 6;
				image.x = 21;
				(elementsMC.imageMC as MovieClip).addChild(image);
				
			}
		}
		
	}
}