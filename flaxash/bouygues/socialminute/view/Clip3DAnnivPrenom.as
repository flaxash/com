package com.flaxash.bouygues.socialminute.view
{
	import com.flaxash.bouygues.socialminute.utils.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	
	public class Clip3DAnnivPrenom extends MovieClip
	{
		public var elementsMC:MovieClip;
		public function Clip3DAnnivPrenom()
		{
			super();
		}
		public function joue():void {
			elementsMC.play();
		}
		public function majElementsDyn(prenom:String,profileImage:DisplayObject):void {		
			(elementsMC.prenomMC.contenuTF as TextField).text = prenom.toLowerCase();
			//DisplayUtils.fitIntoRect(profileImage,new Rectangle(0,0,60,60),true,Alignment.MIDDLE);
			//trace("dans Clip3DAnnivprenom, profil largeur : " + profileImage.width);
			if (profileImage)
			(elementsMC.ppMC as MovieClip).addChild(profileImage);			
		}
	}
}