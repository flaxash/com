package com.flaxash.michelperry.model
{
	import com.flaxash.michelperry.model.Services.ShoesService;
	import com.flaxash.michelperry.model.VO.ShoeVO;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.xml.XMLNode;
	
	import org.osflash.signals.Signal;

	public class ShoesModel
	{
		private var shoesCollectionAH11:Vector.<ShoeVO>;
		private var shoesCollectionPE12:Vector.<ShoeVO>;

		private var serviceShoes:ShoesService;
		
		public var signalShoesReady:Signal;
		
		public function ShoesModel()
		{
			shoesCollectionAH11 = new Vector.<ShoeVO>();
			shoesCollectionPE12 = new Vector.<ShoeVO>();
			
			callService();
			signalShoesReady = new Signal();
		}
		private function callService():void {
			serviceShoes = new ShoesService();
			serviceShoes.signalLoading.add(shoesLoaded);
			serviceShoes.startLoading();
		}
		private function shoesLoaded(myShoesXML1:XML,myShoesXML2:XML):void {
			//trace("shoesModel : " +myShoesXML);
			var myShoe:ShoeVO;
			var compteurShoe:uint=0;
			for each (var monNoeud:XML in myShoesXML1..shoe) {
				//trace(monNoeud);
				myShoe = new ShoeVO();
				myShoe.id = compteurShoe;
				
				myShoe.modele = monNoeud.modele;
				myShoe.urlVisuel = monNoeud.visuel;
				myShoe.ref = monNoeud.ref;
				myShoe.descriptionFR = monNoeud.description_fr;
				myShoe.descriptionUK = monNoeud.description_uk;
				myShoe.couleur = monNoeud.couleur;
				shoesCollectionAH11.push(myShoe);	
				compteurShoe++;
			}
			compteurShoe = 0;
			for each (var _monNoeud:XML in myShoesXML2..shoe) {
				//trace(monNoeud);
				myShoe = new ShoeVO();
				myShoe.id = compteurShoe;
				
				myShoe.modele = _monNoeud.modele;
				myShoe.urlVisuel = _monNoeud.visuel;
				myShoe.ref = _monNoeud.ref;
				myShoe.descriptionFR = _monNoeud.description_fr;
				myShoe.descriptionUK = _monNoeud.description_uk;
				myShoe.couleur = _monNoeud.couleur;
				shoesCollectionPE12.push(myShoe);	
				compteurShoe++;
			}

			MonsterDebugger.trace(this,shoesCollectionAH11);
			signalShoesReady.dispatch(shoesCollectionAH11,shoesCollectionPE12);
		}
	}
}