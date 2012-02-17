package com.flaxash.michelperry.view
{
	import com.greensock.TweenMax;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Fond extends MovieClip
	{
		//classe qui utilise greensock TweenLite ou PixelBender pour teinter 2 clips avec des couleurs différentes
		
		public var clipFond:MovieClip;
		public var clipBandeNoire:MovieClip;
		public var clipLogosFond:MovieClip;
		
		public var loadingMC:MovieClip;
		
		private var xBandeInit:Number;
		

		public function Fond()
		{
			super();
			TweenPlugin.activate([ColorTransformPlugin]);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			xBandeInit = clipBandeNoire.x;
			clipFond.alpha=0;
			clipBandeNoire.alpha=0;
			TweenMax.to(clipFond, 0.1,{tint:0xFFFFFF});
			TweenMax.to(clipBandeNoire, 0.1,{tint:0xFFFFFF});

			//changeTeinte(0xFFFFFF);
			//clipBandeNoire.x +=2000;
			//changeTeinte(0x1232AA,0x1A22EFF);
		}
		
		public function changeTeinte(couleur:Number):void {
			//applique un tween sur la teinte des clips clipGauche et clipDroite
			//OK
			TweenMax.to(clipFond, 2,{tint:couleur});
			TweenMax.to(clipBandeNoire, 2,{colorTransform:{tint:couleur,tintAmount:0.8,brightness:0.8},alpha:1});
			
		}
		public function intro():void {
			//TweenMax.from(clipBandeNoire,1,{x:2000});
			//clipBandeNoire.alpha=0.2;
		}
		public function decaleFond(decalage:Number):void {
			TweenMax.to(clipBandeNoire,1,{x:xBandeInit+decalage});
			//clipBandeNoire.x +=decalage;
		}
		public function reinitPosition():void {
			TweenMax.to(clipBandeNoire,1,{x:xBandeInit});
			//clipBandeNoire.x = xBandeInit;
		}
		private function onAdded(e:Event):void {
			//TweenMax.from(this,1,{alpha:0});
			//clipBandeNoire.alpha = 0;
		}
		public function setLoading(p:Number):void {
			loadingMC.visible=true;
			loadingMC.gotoAndStop(Math.ceil(p*50));
		}
		public function finLoading():void {
			loadingMC.visible=false;
			
			TweenMax.to(clipFond, 1,{alpha:1});
			TweenMax.to(clipBandeNoire, 1,{alpha:1});

		}
	}
}