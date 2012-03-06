package com.flaxash.bouygues.socialminute.view
{
	import com.flaxash.bouygues.socialminute.utils.*;
	import flash.geom.Rectangle;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class Clip3DLien2 extends MovieClip
	{
		public var elementsMC:MovieClip;
		public function Clip3DLien2()
		{
			super();
		}
		public function joue():void {
			elementsMC.play();
		}
		public function majElementsDyn(legende:String,like:String,comment:String,image:DisplayObject,profileImage:DisplayObject):void {
			//DisplayUtils.fitIntoRect(image,new Rectangle(0,0,107,133),true,Alignment.MIDDLE);
			if (image) {
				image.x = image.y = 3;
				(elementsMC.imageMC as MovieClip).addChild(image);
			}
			(elementsMC.legendeMC.contenuTF as TextField).text = legende;
			(elementsMC.likeMC.contenuTF as TextField).text = like;
			(elementsMC.commentMC.contenuTF as TextField).text = comment;
			//DisplayUtils.fitIntoRect(profileImage,new Rectangle(0,0,25,25),true,Alignment.MIDDLE);
			if (profileImage)
			(elementsMC.ppMC as MovieClip).addChild(profileImage);
			
		}
	}
}