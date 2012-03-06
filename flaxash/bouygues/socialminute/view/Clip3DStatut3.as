package com.flaxash.bouygues.socialminute.view
{
	import com.flaxash.bouygues.socialminute.utils.*;
	import flash.geom.Rectangle;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import flash.text.TextField;
	
	public class Clip3DStatut3 extends MovieClip
	{
		public var elementsMC:MovieClip;
		public function Clip3DStatut3()
		{
			super();
		}
		public function joue():void {
			elementsMC.play();
		}
		public function majElementsDyn(prenom:String,like:String,comment:String,statut:String,profileImage:DisplayObject):void {
			trace("statut 1 : " +statut.length);
			var message:String = statut;
			if (statut.length>140) {
				message = statut.slice(0,139);
				message +=" ...";
			}
			(elementsMC.messageMC.contenuTF as TextField).text = message;
			(elementsMC.prenomMC.contenuTF as TextField).text = prenom.toUpperCase();
			(elementsMC.likeMC.contenuTF as TextField).text = like;
			(elementsMC.commentMC.contenuTF as TextField).text = comment;
			//DisplayUtils.fitIntoRect(profileImage,new Rectangle(0,0,28,28),true,Alignment.MIDDLE);
			if (profileImage) {
				profileImage.rotation = -6;
				(elementsMC.ppMC as MovieClip).addChild(profileImage);
			}
		}
	}
}