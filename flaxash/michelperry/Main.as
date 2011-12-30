package com.flaxash.michelperry
{
	//import com.demonsters.debugger.MonsterDebugger;
	
	import com.greensock.TweenLite;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TweenPlugin; 
	TweenPlugin.activate([TransformAroundCenterPlugin]);
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flashx.textLayout.elements.BreakElement;
	
	import com.flaxash.michelperry.view.*;
	import org.osflash.signals.Signal;
	
	public class Main extends MovieClip
	{
		//gestion des view states dans cette classe
		public static const STATE_SHOP:String = "stateShop";
		public static const STATE_GALLERY:String = "stateGallery";
		public static const STATE_GALLERYTHUMBS:String = "stateGalleryThumbs";
		public static const STATE_ABOUT:String = "stateAbout";
		public static const STATE_CONTACTPRESSE:String="stateContactPresse";
		
		public var clipGalleryVisuels :Gallerie;
		public var clipAbout :About;
		public var clipMenu :Menu;
		public var clipContactPresse :ContactPresse;
		public var clipShop :Shop;
		public var clipGalleryThumbs :GallerieThumbs;
		
		private var currentState:String = STATE_GALLERY;
		private var currentActor:Sprite;
		
		public var signalChangeCouleurFond:Signal = new Signal();
		public var signalChangePositionFond:Signal = new Signal();
		
		public function Main()
		{
			super();
			
			//MonsterDebugger.initialize(this);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
		}
		private function onAdded(e:Event):void {
			//initState = "stateGallery"
			clipGalleryVisuels.visible=true;
			
			clipGalleryThumbs.visible=false;
			clipGalleryThumbs.signalClickShoe.add(stateGalleryWithShoe);
			
			clipAbout.visible=false;
			clipAbout.signalClose.add(changeState);
			
			clipContactPresse.visible = false;
			clipContactPresse.signalClose.add(changeState);
			
			clipShop.visible=false;
			clipShop.signalClose.add(changeState);
			
			clipMenu.signalLangue.add(changeLangue);
			currentActor = Sprite(clipGalleryVisuels);
			//trace("onAdded effectué");
		}
		public function changeState(newState:String):void {
			//fais disparaitre l'ancien clip
			TweenLite.to(currentActor,1,{alpha:0,onComplete:disparitionFinie,onCompleteParams:[Sprite(currentActor)]});
			//currentActor.visible=false;
			switch (newState) {
				case Main.STATE_ABOUT:
					trace("about demandé");
					makeTransition(Sprite(clipAbout));
					signalChangeCouleurFond.dispatch(clipAbout.couleurFond);
					signalChangePositionFond.dispatch(0);
					break;
				case Main.STATE_CONTACTPRESSE :
					trace("contact demandé");
					makeTransition(Sprite(clipContactPresse));
					//signalChangeCouleurFond.dispatch(clipContactPresse.couleurFond);
					signalChangeCouleurFond.dispatch(clipContactPresse.couleurFond);
					signalChangePositionFond.dispatch(0);
					break;
				case Main.STATE_SHOP :
					trace("shop demandé");
					makeTransition(Sprite(clipShop));
					signalChangeCouleurFond.dispatch(clipShop.couleurFond);
					signalChangePositionFond.dispatch(0);
					break;
				case Main.STATE_GALLERY :
					trace("gallery demandé");
					if (currentState==Main.STATE_GALLERYTHUMBS) makeTransition(Sprite(clipGalleryVisuels));
					else makeTransition(Sprite(clipGalleryVisuels),false);
					signalChangeCouleurFond.dispatch(clipGalleryVisuels.lastColor);
					signalChangePositionFond.dispatch(0);
					break;
				case Main.STATE_GALLERYTHUMBS :
					trace("gallerythumbs demandé");
					makeTransition(Sprite(clipGalleryThumbs),false);
					signalChangeCouleurFond.dispatch(clipGalleryThumbs.couleurFond);
					signalChangePositionFond.dispatch(210);
					break;
			}
			currentState = newState;
			clipMenu.changeState(newState);
		}
		private function changeLangue(newLangue:String):void {
				clipAbout.changeLangue(newLangue);
				clipShop.changeLangue(newLangue);
				clipGalleryVisuels.changeLangue(newLangue);
				clipGalleryThumbs.changeLangue(newLangue);
				trace("chgtLangue :" + newLangue);
			
		}
		private function disparitionFinie(monSprite:Sprite):void {
			monSprite.visible = false;
			TweenLite.to(monSprite,0,{alpha:1,transformAroundCenter:{scale:1}});
			//monSprite.scaleX = monSprite.scaleY = 1;
			//monSprite.alpha = 1;
		}
		private function stateGalleryWithShoe(nomShoe:String):void  {
			var numeroShoe:uint = uint(nomShoe.substring(4));
			trace("shoe choisie numero " +numeroShoe);
			clipGalleryVisuels.afficheShoe(numeroShoe);
			changeState(Main.STATE_GALLERY);
			clipMenu.changeState(Main.STATE_GALLERY);
		}
		private function makeTransition(cible:Sprite,zoom:Boolean=true):void {
			trace("transition entrante sur " + cible.name);
			//this.setChildIndex(cible,this.numChildren - 1);
			//cible.alpha=0;
			var ancienClip:Sprite = currentActor;
			if (zoom) TweenLite.to(ancienClip,0.5,{alpha:0,transformAroundCenter:{scale:0.5},onComplete:disparitionFinie,onCompleteParams:[ancienClip]});
			else TweenLite.to(ancienClip,0.5,{alpha:0,transformAroundCenter:{scale:2},onComplete:disparitionFinie,onCompleteParams:[ancienClip]});
			cible.visible=true;
			cible.alpha=1;
			cible.cacheAsBitmap = true;
			//cible.scaleX = cible.scaleY = 4;
			if (zoom) TweenLite.from(cible,1,{alpha:0,transformAroundCenter:{scale:2}});
			else TweenLite.from(cible,1,{alpha:0,transformAroundCenter:{scale:0.5}});
			//cible.visible=true;
			currentActor = Sprite(cible);
		}
	}
}