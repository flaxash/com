package com.flaxash.bouygues.socialminute.view
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	public class Clip3DLien1 extends MovieClip
	{
		public var elementsMC:MovieClip;
		public function Clip3DLien1()
		{
			super();
		}
		public function joue():void {
			elementsMC.play();
		}
		public function majElementsDyn(prenom:String):void {
			(elementsMC.prenomMC.contenuTF as TextField).text = prenom.charAt(0)+ prenom.slice(1).toLowerCase();		
			
		}
	}
}
