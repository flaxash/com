package com.flaxash.michelperry.view
{
	import com.flaxash.michelperry.Main;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.plugins.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.tlf_internal;
	
	import org.osflash.signals.Signal;
	
	TweenPlugin.activate([AutoAlphaPlugin]);
	TweenPlugin.activate([TintPlugin]);
	
	public class Menu extends MovieClip
	{
		public var signalState:Signal = new Signal();
		public var signalLangue:Signal = new Signal();
		public var signalRetourHome:Signal = new Signal();
		
		//sur la scène
		public var shopBtn:SimpleButton;
		public var aboutBtn:SimpleButton;
		public var contactBtn:SimpleButton;
		public var collectionBtn:SimpleButton;
		public var logoMC:MovieClip;
		public var saisonAH11MC:MovieClip;
		public var saisonPE12MC:MovieClip;
		public var collectionMC:MovieClip;
		
		public var shopMC:MovieClip;
		public var aboutMC:MovieClip;
		public var contactMC:MovieClip;
		
		public var frBtn:SimpleButton;
		public var ukBtn:SimpleButton;
		
		private var _collectionEnCours:String = "choix";
		private var currentState:String;
		private var currentLangue:String="fr";
		
		public function Menu()
		{
			super();
			trace("Menu construit");
			//init();
			//this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			initListeners();
			frBtn.addEventListener(MouseEvent.CLICK,onChgtLangue);
			ukBtn.addEventListener(MouseEvent.CLICK,onChgtLangue);
			frBtn.alpha=0.9;
			ukBtn.alpha=0.5;
			changeState(Main.STATE_GALLERY);
		}
		public function comeIn():void {
			trace("transition in for Menu");
			for (var i:uint=0;i<this.numChildren;i++) {
				var monDO:DisplayObject = DisplayObject(this.getChildAt(i));
				TweenLite.from(monDO,1,{alpha:0,delay:i*0.2});
			}
		}
		
		private function initListeners():void {
			//listeners
			shopBtn.addEventListener(MouseEvent.CLICK,onClick);
			aboutBtn.addEventListener(MouseEvent.CLICK,onClick);
			contactBtn.addEventListener(MouseEvent.CLICK,onClick);
			collectionBtn.addEventListener(MouseEvent.CLICK,onClick);
			logoMC.addEventListener(MouseEvent.CLICK,onClickLogo);
			shopBtn.addEventListener(MouseEvent.ROLL_OVER,onOver);
			aboutBtn.addEventListener(MouseEvent.ROLL_OVER,onOver);
			contactBtn.addEventListener(MouseEvent.ROLL_OVER,onOver);
			collectionBtn.addEventListener(MouseEvent.ROLL_OVER,onOver);
			shopBtn.addEventListener(MouseEvent.ROLL_OUT,onOut);
			aboutBtn.addEventListener(MouseEvent.ROLL_OUT,onOut);
			contactBtn.addEventListener(MouseEvent.ROLL_OUT,onOut);
			collectionBtn.addEventListener(MouseEvent.ROLL_OUT,onOut);
			
			//cas du bouton collection
			collectionMC.visible=true;			
		}
		private function removeListeners():void {
			//listeners
			shopBtn.removeEventListener(MouseEvent.CLICK,onClick);
			aboutBtn.removeEventListener(MouseEvent.CLICK,onClick);
			contactBtn.removeEventListener(MouseEvent.CLICK,onClick);
			collectionBtn.removeEventListener(MouseEvent.CLICK,onClick);
			logoMC.removeEventListener(MouseEvent.CLICK,onClickLogo);
			shopBtn.removeEventListener(MouseEvent.ROLL_OVER,onOver);
			aboutBtn.removeEventListener(MouseEvent.ROLL_OVER,onOver);
			contactBtn.removeEventListener(MouseEvent.ROLL_OVER,onOver);
			collectionBtn.removeEventListener(MouseEvent.ROLL_OVER,onOver);
			shopBtn.removeEventListener(MouseEvent.ROLL_OUT,onOut);
			aboutBtn.removeEventListener(MouseEvent.ROLL_OUT,onOut);
			contactBtn.removeEventListener(MouseEvent.ROLL_OUT,onOut);
			collectionBtn.removeEventListener(MouseEvent.ROLL_OUT,onOut);	
			//éteint tous les boutons
			shopMC.alpha = aboutMC.alpha = contactMC.alpha = 0.5;
		}
		private function onChgtLangue(me:MouseEvent):void {
			switch(me.target.name) {
				case "frBtn":
					if (currentLangue=="uk") signalLangue.dispatch("fr");
					currentLangue = "fr";
					//frBtn.alpha = 0.5;
					break;
				case "ukBtn":
					if (currentLangue=="fr") signalLangue.dispatch("uk");
					currentLangue = "uk";
					//ukBtn.alpha = 0.5;
					break;
			}
			changeLangue(currentLangue);
		}
		private function onClick(me:MouseEvent):void {
			trace(me.target.name);
			removeListeners();
			initListeners();
			switch (me.target.name) {
				case "shopBtn":
					signalState.dispatch(Main.STATE_SHOP);
					currentState = Main.STATE_SHOP;
					shopMC.alpha = 0.9;
					break;
				case "aboutBtn" :
					signalState.dispatch(Main.STATE_ABOUT);
					currentState = Main.STATE_ABOUT;
					aboutMC.alpha = 0.9;
					break;
				case "contactBtn" :
					signalState.dispatch(Main.STATE_CONTACTPRESSE);
					currentState = Main.STATE_CONTACTPRESSE;
					contactMC.alpha = 0.9;
					break;
				case "collectionBtn" :
					signalState.dispatch(Main.STATE_GALLERYTHUMBS);
					currentState = Main.STATE_GALLERYTHUMBS;
					collectionMC.visible = false;
					break;
				
			}
			(me.target as SimpleButton).removeEventListener(MouseEvent.CLICK,onClick);
			(me.target as SimpleButton).removeEventListener(MouseEvent.ROLL_OVER,onOver);
			(me.target as SimpleButton).removeEventListener(MouseEvent.ROLL_OUT,onOut);
			
		}
		private function onClickLogo(me:MouseEvent):void {
			trace("click logo MP");
			signalRetourHome.dispatch();
			currentState = Main.STATE_GALLERY;
			//signalState.dispatch(currentState);
			collectionEnCours = "choix";
		}
		public function changeState(newState:String):void {
			//currentActor.visible=false;
			removeListeners();
			initListeners();
			switch (newState) {
				case Main.STATE_ABOUT:
					currentState = Main.STATE_ABOUT;
					aboutBtn.removeEventListener(MouseEvent.CLICK,onClick);
					break;
				case Main.STATE_CONTACTPRESSE :
					currentState = Main.STATE_CONTACTPRESSE;
					contactBtn.removeEventListener(MouseEvent.CLICK,onClick);
					break;
				case Main.STATE_SHOP :
					currentState = Main.STATE_SHOP;
					shopBtn.removeEventListener(MouseEvent.CLICK,onClick);
					break;
				case Main.STATE_GALLERY :
					currentState = Main.STATE_GALLERY;
					majInfosVisibles();
					//pas de bouton à désactiver
					break;
				case Main.STATE_GALLERYTHUMBS :
					currentState = Main.STATE_GALLERYTHUMBS;
					collectionBtn.removeEventListener(MouseEvent.CLICK,onClick);
					break;
			}
			majInfosVisibles();
		}
		
		public function changeLangue(langue:String):void {
			switch(langue) {
				case "fr" :
					frBtn.alpha=0.9;
					ukBtn.alpha=0.5;
					saisonAH11MC.gotoAndStop(1);
					saisonPE12MC.gotoAndStop(1);
					shopMC.gotoAndStop(1);
					aboutMC.gotoAndStop(1);
					contactMC.gotoAndStop(1);
					collectionMC.gotoAndStop(1);
					trace("fr");
					break;
				case "uk" :
					frBtn.alpha=0.5;
					ukBtn.alpha=0.9;
					saisonAH11MC.gotoAndStop(2);
					saisonPE12MC.gotoAndStop(2);
					shopMC.gotoAndStop(2);
					aboutMC.gotoAndStop(2);
					contactMC.gotoAndStop(2);
					collectionMC.gotoAndStop(2);
					trace("uk");
					break;
			}
		}
		private function majInfosVisibles():void {
			switch(_collectionEnCours) 
			{
				case "choix":
					saisonAH11MC.visible=false;
					saisonPE12MC.visible=false;
					collectionMC.visible=false;
					collectionBtn.enabled=false;
					collectionBtn.visible=false;
					if (currentState==Main.STATE_GALLERY) 
					{
						TweenLite.to(shopMC,0.5,{tint:0x000000});
						TweenLite.to(aboutMC,0.5,{tint:0x000000});
						TweenLite.to(contactMC,0.5,{tint:0x000000});
					} else {
						TweenLite.to(shopMC,0.5,{tint:0xFFFFFF});
						TweenLite.to(aboutMC,0.5,{tint:0xFFFFFF});
						TweenLite.to(contactMC,0.5,{tint:0xFFFFFF});
					}
					break;
				case "AH2011":
					saisonAH11MC.visible=true;
					saisonPE12MC.visible=false;
					collectionMC.visible=true;
					collectionBtn.enabled=true;
					collectionBtn.visible=true;
					TweenLite.to(shopMC,0.5,{tint:0xFFFFFF});
					TweenLite.to(aboutMC,0.5,{tint:0xFFFFFF});
					TweenLite.to(contactMC,0.5,{tint:0xFFFFFF});
					break;
				case "PE2012":
					saisonAH11MC.visible=false;
					saisonPE12MC.visible=true;
					collectionMC.visible=true;
					collectionBtn.enabled=true;
					collectionBtn.visible=true;
					TweenLite.to(shopMC,0.5,{tint:0xFFFFFF});
					TweenLite.to(aboutMC,0.5,{tint:0xFFFFFF});
					TweenLite.to(contactMC,0.5,{tint:0xFFFFFF});
					break;
				default:
					break;
			}
			trace("maj infos effectuées pour "+_collectionEnCours);
			
		}
		private function onOver(me:MouseEvent):void {
			var nameMC:String = (me.target.name as String).replace("Btn","MC");
			var boutonMC:Sprite = Sprite(this.getChildByName(nameMC));
			boutonMC.alpha = 0.9;
		}
		private function onOut(me:MouseEvent):void {
			var nameMC:String = (me.target.name as String).replace("Btn","MC");
			var boutonMC:Sprite = Sprite(this.getChildByName(nameMC));
			boutonMC.alpha = 0.5;
		}
		
		public function set collectionEnCours(value:String):void
		{
			_collectionEnCours = value;
			majInfosVisibles();
		}
		
		
	}
}