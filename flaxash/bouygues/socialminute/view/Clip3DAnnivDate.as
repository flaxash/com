package com.flaxash.bouygues.socialminute.view
{
	import flash.display.MovieClip;
	import flash.text.TextField;

	
	public class Clip3DAnnivDate extends MovieClip
	{
		public var elementsMC:MovieClip;
		public function Clip3DAnnivDate()
		{
			super();
		}
		public function joue():void {
			elementsMC.play();
		}
		public function majElementsDyn(jour:String,mois:String):void {		
			(elementsMC.moisMC.contenuTF as TextField).text = mois.toLowerCase();
			(elementsMC.jourMC.contenuTF as TextField).text = jour;
		}
	}
}