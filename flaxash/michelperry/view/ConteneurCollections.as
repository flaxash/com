package com.flaxash.michelperry.view
{
	import com.flaxash.michelperry.model.VO.ShoeVO;
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	
	import org.osflash.signals.Signal;
	
	public class ConteneurCollections extends Sprite
	{
		
		//enfants sur la scène
		public var collAH11:Collection;
		public var collPE12:Collection;
		//modif temporaire pour mise à la une de la collection cerise
		//public var choixColl:ChoixCollection;
		public var choixColl:CerisesChoixCollection;
		
		public var couleurFond:Number = 0x81878c;
		public var lastColor:Number;

		public var signalColorFond:Signal = new Signal();
		public var signalChoixCollection:Signal = new Signal();


		private var _shoeCollectionAH2011:Vector.<ShoeVO>;
		private var _shoeCollectionPE2012:Vector.<ShoeVO>;
		private var currentState:String = "choix";
		public function ConteneurCollections()
		{
			super();
			init();
		}
		public function init():void
		{
			choixColl.visible=true;
			collAH11.visible=false;
			collPE12.visible=false;
			collAH11.signalColorFond.add(majLastColor);
			collPE12.signalColorFond.add(majLastColor);
			choixColl.signalChoix.add(changeCollection);
		}
		
		private function majLastColor(newcolor:Number):void
		{
			lastColor=newcolor;
			if (currentState!="choix") 
			{
				signalColorFond.dispatch(newcolor);
			}
		}
		public function changeCollection(param:String):void 
		{
			//navigation entre les collections et la home page
			switch(param) 
			{
			case "AH2011":
				//choixColl.visible=false;
				//collPE12.visible=false;
				//collAH11.visible=true;
		
				TweenLite.to(choixColl,1,{autoAlpha:0});
				TweenLite.to(collPE12,1,{autoAlpha:0});
				TweenLite.to(collAH11,1,{autoAlpha:1});
				currentState = "AH2011";
				//pour mettre à jour le menu
				signalChoixCollection.dispatch(currentState);
				//pour mettre à jour la couleur du fond
				signalColorFond.dispatch(collAH11.lastColor);
				break;
			case "PE2012":
				//choixColl.visible=false;
				//collPE12.visible=true;
				//collAH11.visible=false;
				
				TweenLite.to(choixColl,1,{autoAlpha:0});
				TweenLite.to(collPE12,1,{autoAlpha:1});
				TweenLite.to(collAH11,1,{autoAlpha:0});
				currentState = "PE2012";
				//pour mettre à jour le menu
				signalChoixCollection.dispatch(currentState);
				//pour mettre à jour la couleur du fond
				signalColorFond.dispatch(collPE12.lastColor);
				break;
			case "choix":
				//choixColl.visible=true;				
				//collPE12.visible=false;				
				//collAH11.visible=false;
				
				TweenLite.to(choixColl,1,{autoAlpha:1});
				TweenLite.to(collPE12,1,{autoAlpha:0});
				TweenLite.to(collAH11,1,{autoAlpha:0});
				currentState = "choix";
				//pour mettre à jour la couleur du fond
				signalColorFond.dispatch(0xffffff);
				//modif pour mettre les boutons noirs lorsque visuel cerises
				TweenLite.to(choixColl.pe2012,0,{tint:0x000000});
				TweenLite.to(choixColl.ah2011,0,{tint:0x000000});

				break;
			default:
				break;
			}
			trace("conteneurCollections state :" + currentState);
		}
		
		public function changeLangue(newLangue:String):void
		{
			// TODO Auto Generated method stub
			collPE12.changeLangue(newLangue);
			collAH11.changeLangue(newLangue);
			choixColl.changeLangue(newLangue)
			
		}
		
		public function afficheShoe(numeroShoe:uint):void
		{
			// TODO Auto Generated method stub
			switch (currentState) 
			{
				case "AH2011" :
					collAH11.afficheShoe(numeroShoe);
					break;
				case "PE2012" :
					collPE12.afficheShoe(numeroShoe);
					break;
				default:
					break;
			}
			
		}
		public function comeIn():void {
			switch (currentState)
			{
				case "AH2011" :
					break;
				case "PE2012" :
					break;
				default:
					break;
			}
		}

		public function set shoeCollectionAH2011(value:Vector.<ShoeVO>):void
		{
			_shoeCollectionAH2011 = value;
			collAH11.shoeCollection = value;
		}

		public function set shoeCollectionPE2012(value:Vector.<ShoeVO>):void
		{
			_shoeCollectionPE2012 = value;
			collPE12.shoeCollection = value;
		}


	}
}