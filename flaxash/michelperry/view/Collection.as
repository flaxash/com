package com.flaxash.michelperry.view
{
	import com.flaxash.michelperry.model.VO.ShoeVO;
	import com.flaxash.michelperry.Main;
	
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.plugins.BlurFilterPlugin;
	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	TweenPlugin.activate([TransformAroundPointPlugin]); 
	TweenPlugin.activate([BlurFilterPlugin]);
	
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.geom.Point;
	import com.greensock.TweenLite;
	import com.greensock.loading.ImageLoader;
	import org.osflash.signals.Signal;
	import flash.text.TextField;
	import com.greensock.loading.LoaderMax;
	import flash.display.SimpleButton;
	import flash.display.DisplayObject;
	import com.greensock.loading.display.ContentDisplay;
	
	public class Collection extends Sprite
	{
		private var _shoeCollection:Vector.<ShoeVO>;
		public var langue:String = "fr";
		
		//sur la scène		
		public var cibleShoes:MovieClip;
		public var nomShoe:TextField;
		public var refShoe:TextField;
		public var descriptionShoe:TextField;		
		public var next_btn:SimpleButton;
		public var previous_btn:SimpleButton;
		
		private var enMvt:Boolean=false;
		
		private var nbShoes:uint;
		private var numShoe:int = 0;
		private var mesLoaders:LoaderMax = new LoaderMax({name:"queue"});
		
		public var signalColorFond:Signal = new Signal();
		public var lastColor:Number;
		
		public function Collection()
		{
			super();
			//this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			//init();
		}
		protected function init():void {
			this.visible=false;
			this.alpha=0;
			trace("gallerie construite");
		}
		public function set shoeCollection(value:Vector.<ShoeVO>):void
		{
			_shoeCollection = value;
			makeGallerie();
		}
		
		public function makeGallerie():void {
			if (_shoeCollection.length>0) 
			{				
				nbShoes = _shoeCollection.length;
				trace("nombre de shoes : " + nbShoes);
				//création d'un loader par shoe
				for each (var myShoe:ShoeVO in _shoeCollection) {
					mesLoaders.append(new ImageLoader(myShoe.urlVisuel,{name:"shoe"+myShoe.id,onComplete:shoeLoaded}));
					trace("shoe"+myShoe.id);
				}
				var numAleat:uint = Math.floor(Math.random()*_shoeCollection.length);
				selectShoe(numAleat,true);
				majInfos(numAleat);
				signalColorFond.dispatch(_shoeCollection[numAleat].couleur);
				lastColor = _shoeCollection[numAleat].couleur;
			}
		}
		private function onAdded(e:Event):void {
			//TweenLite.from(this,1,{alpha:0});
			next_btn.addEventListener(MouseEvent.CLICK,onClickNext);
			previous_btn.addEventListener(MouseEvent.CLICK,onClickPrevious);
		}
		public function comeIn():void {
			trace("transition in for Menu");
			for (var i:uint=0;i<this.numChildren;i++) {
				var monDO:DisplayObject = DisplayObject(this.getChildAt(i));
				TweenLite.from(monDO,1,{alpha:0,delay:i*0.2});
			}
		}
		
		private function shoeLoaded(le:LoaderEvent):void {
			trace("hauteur : " +le.target.content.height);
			le.target.content.y = - le.target.content.height/2;
			le.target.content.x = - le.target.content.width/2;
		}
		public function selectShoe(n:uint,avance:Boolean):void {
			next_btn.removeEventListener(MouseEvent.CLICK,onClickNext);
			previous_btn.removeEventListener(MouseEvent.CLICK,onClickPrevious);
			var beforeN : int = (n-1)>0?(n-1)%nbShoes:(n-1+nbShoes)%nbShoes;
			var afterN : int = (n+1)%nbShoes;
			numShoe = n;
			trace( "before : "+beforeN + " _ after : "+afterN);
			//affiche la shoes n et prépare les shoes n-1 et n+1
			/*
			loaderNameStr = _imageDictionary[imgStr];
			var loader:LoaderCore = LoaderMax.getLoader(loaderNameStr); 
			loader.addEventListener(LoaderEvent.COMPLETE, handleImageLoaded);
			*/
			//désactive les boutons en attendant la fin du chargement
			previous_btn.alpha = 0.5;
			next_btn.alpha = 0.5;
			
			enMvt=true;
			(mesLoaders.getLoader("shoe"+beforeN) as ImageLoader).addEventListener(LoaderEvent.COMPLETE,gaucheChargee);
			(mesLoaders.getLoader("shoe"+afterN) as ImageLoader).addEventListener(LoaderEvent.COMPLETE,droiteChargee);		
			(mesLoaders.getLoader("shoe"+n) as ImageLoader).load();
			(mesLoaders.getLoader("shoe"+afterN) as ImageLoader).load();
			(mesLoaders.getLoader("shoe"+beforeN) as ImageLoader).load();
			if (cibleShoes.numChildren>0) {
				makeTransition((mesLoaders.getLoader("shoe"+n) as ImageLoader).content,avance);
			} else {
				//première fois
				cibleShoes.addChild((mesLoaders.getLoader("shoe"+n) as ImageLoader).content);
				TweenLite.from((mesLoaders.getLoader("shoe"+n) as ImageLoader).content,1,{alpha:0,onComplete:mvtFini})
			}
			signalColorFond.dispatch(_shoeCollection[numShoe].couleur);
			lastColor = _shoeCollection[numShoe].couleur;
			//removeChildren(cibleShoes);
			//cibleShoes.addChild((mesLoaders.getLoader("shoe"+n) as ImageLoader).content);
			
		}
		public function afficheShoe(n:uint):void {
			var beforeN : int = (n-1)>0?(n-1)%nbShoes:(n-1+nbShoes)%nbShoes;
			var afterN : int = (n+1)%nbShoes;
			numShoe = n;
			trace( "before : "+beforeN + " _ after : "+afterN);
			//desactive les boutons en atendant la fin du chargement
			previous_btn.alpha = 0.5;
			next_btn.alpha = 0.5;
			next_btn.removeEventListener(MouseEvent.CLICK,onClickNext);
			previous_btn.removeEventListener(MouseEvent.CLICK,onClickPrevious);
			
			//affiche la shoes n et prépare les shoes n-1 et n+1
			(mesLoaders.getLoader("shoe"+n) as ImageLoader).load();
			(mesLoaders.getLoader("shoe"+beforeN) as ImageLoader).addEventListener(LoaderEvent.COMPLETE,gaucheChargee);
			(mesLoaders.getLoader("shoe"+afterN) as ImageLoader).addEventListener(LoaderEvent.COMPLETE,droiteChargee);			
			(mesLoaders.getLoader("shoe"+afterN) as ImageLoader).load();
			(mesLoaders.getLoader("shoe"+beforeN) as ImageLoader).load();
			if (cibleShoes.numChildren>0) {
				removeLastShoe(DisplayObject(cibleShoes.getChildAt(0)));			
			} 
			(mesLoaders.getLoader("shoe"+n) as ImageLoader).content.alpha = 1;
			cibleShoes.addChild((mesLoaders.getLoader("shoe"+n) as ImageLoader).content);
			
			signalColorFond.dispatch(_shoeCollection[n].couleur);
			lastColor = _shoeCollection[n].couleur;
			
			
		}
		public function changeLangue(newLangue:String):void {
			langue=newLangue;
			majInfos(numShoe);
		}
		private function makeTransition(cible:ContentDisplay,avance:Boolean):void {
			enMvt=true;
			if (cibleShoes.numChildren>0) {
				var ancienCD:DisplayObject = DisplayObject(cibleShoes.getChildAt(0));
				var maTimelineDepart:TimelineLite = new TimelineLite();
				maTimelineDepart.append(TweenLite.to(ancienCD,2,{
					x:avance?"-1000":"1000",
					ease:Quint.easeOut}));
				maTimelineDepart.insert(TweenLite.to(ancienCD,0.2,{
					alpha:0,ease:Quint.easeOut,
					onComplete:removeLastShoe,
					onCompleteParams:[ancienCD]
				}),0.3);
				maTimelineDepart.play();
				
				//TweenLite.to(ancienCD,0.5,{alpha:0,x:avance?"-200":"200",onComplete:removeLastShoe,onCompleteParams:[ancienCD],ease:Quad.easeOut});
				//TweenLite.to(refShoe,0.5,{blurFilter:{blurX:20,blurY:5}});
				//TweenLite.to(nomShoe,0.5,{blurFilter:{blurX:20,blurY:5}});
			}
			cibleShoes.addChild(cible);
			cible.alpha = 1;
			//cible.x = 250;
			var maTimelineArrivee:TimelineLite = new TimelineLite({delay:1});
			maTimelineArrivee.append(TweenLite.from(cible,2,{
				x:avance?"1000":"-1000",
				ease:Quint.easeOut}));
			maTimelineArrivee.insert(TweenLite.from(cible,0.4,{
				alpha:0,ease:Quint.easeOut,onComplete:mvtFini}),0.2);
			maTimelineArrivee.play();
			
			//TweenLite.from(cible,0.5,{alpha:0, x:avance?"200":"-200",delay:1,ease:Quad.easeOut});
		}
		private function removeLastShoe(ancienCD:DisplayObject):void {
			cibleShoes.removeChild(ancienCD);
			
			majInfos(numShoe);
			
			//TweenLite.to(refShoe,0.5,{blurFilter:{blurX:0,blurY:0}});
			//TweenLite.to(nomShoe,0.5,{blurFilter:{blurX:0,blurY:0}});
		}
		private function majInfos(n:uint):void {
			refShoe.text = (_shoeCollection[n] as ShoeVO).ref;
			nomShoe.text = (_shoeCollection[n] as ShoeVO).modele;
			descriptionShoe.text = langue=="fr"?(_shoeCollection[n] as ShoeVO).descriptionFR:(_shoeCollection[n] as ShoeVO).descriptionUK;
		}
		private function onClickNext(me:MouseEvent):void {
			if (!enMvt) selectShoe((numShoe +1)%nbShoes,true);
		}
		private function onClickPrevious(me:MouseEvent):void {
			if (!enMvt) selectShoe((numShoe -1)>0?(numShoe -1)%nbShoes:(numShoe -1+nbShoes)%nbShoes,false);
		}
		private function gaucheChargee(le:LoaderEvent):void {
			trace("image à gauche chargée");
			//activeBoutonPrevious
			previous_btn.alpha=1;
			previous_btn.addEventListener(MouseEvent.CLICK,onClickPrevious);
			
		}
		private function droiteChargee(le:LoaderEvent):void {
			trace("image à droite chargée");
			//activeBoutonNext
			next_btn.alpha=1;
			next_btn.addEventListener(MouseEvent.CLICK,onClickNext);
		}
		private function mvtFini():void {
			enMvt = false;;
		}
	}
}