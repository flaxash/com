package com.flaxash.michelperry.model
{
	import com.flaxash.michelperry.model.services.ShoesService;
	import com.flaxash.michelperry.model.vo.ShoeVO;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.xml.XMLNode;
	
	import org.osflash.signals.Signal;

	public class ShoesModel
	{
		private var shoesCollection:Vector.<ShoeVO>;
		private var serviceShoes:ShoesService;
		
		public var signalShoesReady:Signal;
		
		public function ShoesModel()
		{
			shoesCollection = new Vector.<ShoeVO>();
			callService();
			signalShoesReady = new Signal();
		}
		private function callService():void {
			serviceShoes = new ShoesService();
			serviceShoes.signalLoading.add(shoesLoaded);
			serviceShoes.startLoading();
		}
		private function shoesLoaded(myShoesXML:XML):void {
			//trace("shoesModel : " +myShoesXML);
			var myShoe:ShoeVO;
			var compteurShoe:uint=0;
			for each (var monNoeud:XML in myShoesXML..shoe) {
				//trace(monNoeud);
				myShoe = new ShoeVO();
				myShoe.id = compteurShoe;
				
				myShoe.modele = monNoeud.modele;
				myShoe.urlVisuel = monNoeud.visuel;
				myShoe.ref = monNoeud.ref;
				myShoe.descriptionFR = monNoeud.description_fr;
				myShoe.descriptionUK = monNoeud.description_uk;
				myShoe.couleur = monNoeud.couleur;
				shoesCollection.push(myShoe);	
				compteurShoe++;
			}
			MonsterDebugger.trace(this,shoesCollection);
			signalShoesReady.dispatch(shoesCollection);
		}
	}
}