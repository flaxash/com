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
	
	public class Menu extends MovieClip
	{
		public var signalState:Signal = new Signal();
		public var signalLangue:Signal = new Signal();

		//sur la scène
		public var shopBtn:SimpleButton;
		public var aboutBtn:SimpleButton;
		public var contactBtn:SimpleButton;
		public var collectionBtn:SimpleButton;
		
		public var saisonMC:MovieClip;
		public var collectionMC:MovieClip;
		
		public var shopMC:MovieClip;
		public var aboutMC:MovieClip;
		public var contactMC:MovieClip;
		
		public var frBtn:SimpleButton;
		public var ukBtn:SimpleButton;
		
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
			shopBtn.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			aboutBtn.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			contactBtn.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			collectionBtn.addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			shopBtn.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			aboutBtn.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			contactBtn.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			collectionBtn.addEventListener(MouseEvent.ROLL_OUT,onRollOut);
			//cas du bouton collection
			collectionMC.visible=true;			
		}
		private function removeListeners():void {
			//listeners
			shopBtn.removeEventListener(MouseEvent.CLICK,onClick);
			aboutBtn.removeEventListener(MouseEvent.CLICK,onClick);
			contactBtn.removeEventListener(MouseEvent.CLICK,onClick);
			collectionBtn.removeEventListener(MouseEvent.CLICK,onClick);
			shopBtn.removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
			aboutBtn.removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
			contactBtn.removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
			collectionBtn.removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
			shopBtn.removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
			aboutBtn.removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
			contactBtn.removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
			collectionBtn.removeEventListener(MouseEvent.ROLL_OUT,onRollOut);	
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
			(me.target as SimpleButton).removeEventListener(MouseEvent.ROLL_OVER,onRollOver);
			(me.target as SimpleButton).removeEventListener(MouseEvent.ROLL_OUT,onRollOut);
			
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
					//pas de bouton à désactiver
					break;
				case Main.STATE_GALLERYTHUMBS :
					currentState = Main.STATE_GALLERYTHUMBS;
					collectionBtn.removeEventListener(MouseEvent.CLICK,onClick);
					break;
			}
		}

		public function changeLangue(langue:String):void {
			switch(langue) {
				case "fr" :
					frBtn.alpha=0.9;
					ukBtn.alpha=0.5;
					saisonMC.gotoAndStop(1);
					shopMC.gotoAndStop(1);
					aboutMC.gotoAndStop(1);
					contactMC.gotoAndStop(1);
					collectionMC.gotoAndStop(1);
					trace("fr");
					break;
				case "uk" :
					frBtn.alpha=0.5;
					ukBtn.alpha=0.9;
					saisonMC.gotoAndStop(2);
					shopMC.gotoAndStop(2);
					aboutMC.gotoAndStop(2);
					contactMC.gotoAndStop(2);
					collectionMC.gotoAndStop(2);
					trace("uk");
					break;
			}
		}
		private function onRollOver(me:MouseEvent):void {
			var nameMC:String = (me.target.name as String).replace("Btn","MC");
			var boutonMC:Sprite = Sprite(this.getChildByName(nameMC));
			boutonMC.alpha = 0.9;
		}
		private function onRollOut(me:MouseEvent):void {
			var nameMC:String = (me.target.name as String).replace("Btn","MC");
			var boutonMC:Sprite = Sprite(this.getChildByName(nameMC));
			boutonMC.alpha = 0.5;
		}

	}
}