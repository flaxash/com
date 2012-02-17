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
	import flash.utils.getDefinitionByName;
	
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
		
		//sur la scène
		public var clipGalleriesThumbs : ConteneurThumbsGalleries;
		public var clipGalleries :ConteneurCollections;
		public var clipAbout :About;
		public var clipMenu :Menu;
		public var clipContactPresse :ContactPresse;
		public var clipShop :Shop;
		
		//elements génériques
		
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
			//clipGalleryVisuels = clipChoixCollection;
			
			clipGalleries.visible=true;
			clipGalleries.signalChoixCollection.add(choixCollection);
			clipGalleriesThumbs.visible=false;
			clipGalleriesThumbs.signalClickShoe.add(stateGalleryWithShoe);
			trace("onAdded effectué");
			clipAbout.visible=false;
			clipAbout.signalClose.add(changeState);
			
			clipContactPresse.visible = false;
			clipContactPresse.signalClose.add(changeState);
			
			clipShop.visible=false;
			clipShop.signalClose.add(changeState);
			
			clipMenu.signalLangue.add(changeLangue);
			clipMenu.signalRetourHome.add(retourHome);
			currentActor = Sprite(clipGalleries);
			//trace("onAdded effectué");
		}
		
		private function choixCollection(param:String):void
		{
			clipMenu.collectionEnCours = param;
			clipGalleriesThumbs.changeCollection(param);
		}
		
		private function retourHome():void
		{
			clipGalleries.changeCollection("choix");
			//clipGalleries.comeIn();
			//clipGalleries.alpha=1;
			//clipGalleries.visible=true;
			changeState(Main.STATE_GALLERY);
		}
		public function changeState(newState:String):void {
			if (newState != currentState) 
			{
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
						if (currentState==Main.STATE_GALLERYTHUMBS) makeTransition(Sprite(clipGalleries));
						else makeTransition(Sprite(clipGalleries),false);
						signalChangeCouleurFond.dispatch(clipGalleries.lastColor);
						signalChangePositionFond.dispatch(0);
						break;
					case Main.STATE_GALLERYTHUMBS :
						trace("gallerythumbs demandé");
						makeTransition(Sprite(clipGalleriesThumbs),false);
						signalChangeCouleurFond.dispatch(clipGalleriesThumbs.couleurFond);
						signalChangePositionFond.dispatch(210);
						break;
				}
			}			
			currentState = newState;
			clipMenu.changeState(newState);
		}
		private function changeLangue(newLangue:String):void {
			clipAbout.changeLangue(newLangue);
			clipShop.changeLangue(newLangue);
			clipGalleries.changeLangue(newLangue);
			clipGalleriesThumbs.changeLangue(newLangue);
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
			clipGalleries.afficheShoe(numeroShoe);
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
/*		public function getFond():MovieClip {
			trace("ok getFond");
			var ClipFond:Class = getDefinitionByName("ClipLogosFond") as Class;
			trace("clipFond : "+ClipFond);
			return (MovieClip(ClipFond));
			//return (new MovieClip());
		}
*/
	}
}