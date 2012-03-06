package com.flaxash.bouygues.socialminute.view
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	public class Clip3DAVenir extends MovieClip
	{
		public var elementsMC:MovieClip;
		
		public function Clip3DAVenir()
		{
			super();
		}
		public function joue():void {
			elementsMC.play();
		}
		public function majElementsDyn(jour:String,mois:String,statut:String):void {
			
			trace("statut : "+statut.length);
			
			var message:String = ""+statut;
			if (statut.length>32) {
				message = statut.slice(0,31);
				message +=" ...";
			}
			if (statut.length<1) {
				
				message = "Et si vous prévoyiez une soirée entre amis ?"
				//(elementsMC.jourMC.contenuTF as TextField).text = "";
				//(elementsMC.moisMC.contenuTF as TextField).text = "";
				
				trace("evenement vide");
			}
			(elementsMC.messageMC.contenuTF as TextField).text = message;
			(elementsMC.moisMC.contenuTF as TextField).text = mois.toLowerCase();
			(elementsMC.jourMC.contenuTF as TextField).text = jour.length>0?"le "+jour:jour;
	
		}
	}
}