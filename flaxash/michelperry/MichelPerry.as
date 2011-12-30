package
{
	import com.flaxash.michelperry.model.ShoesModel;
	import com.flaxash.michelperry.model.VO.ShoeVO;
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.SWFLoader;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import com.flaxash.michelperry.view.Fond;
	import com.flaxash.michelperry.view.Gallerie;
	import com.flaxash.michelperry.view.Menu;
	
	public class MichelPerry extends Sprite
	
	{
		[SWF(width='1024',height='768',backgroundColor='#ffffff',bgcolor='#ffffff',frameRate='25')]
		private static const LARGEUR_ANIM:uint = 1024;
		private static const HAUTEUR_ANIM:uint = 768;
		private var mainLoader:SWFLoader;
		private var fondLoader:SWFLoader;
		private var modelShoes:ShoesModel;
		private var main:Main;
		private var fond:Fond;
		private var menu:Menu;
		private var gallerie_visuels : Gallerie;
		private var gallerie_thumbs : MovieClip;
		
		public function MichelPerry()
		{		
			
			this.addEventListener(Event.ADDED_TO_STAGE,onStageReady);
			MonsterDebugger.initialize(this);
			
		}
		private function onStageReady(e:Event):void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			
			stage.addEventListener(Event.RESIZE, onStageResize);
			
			fondLoader = new SWFLoader("fond.swf",
				{container:this,width:2500,height:1500,scaleMode:"none",
				hAlign:"center",onComplete:fondComplete});
			fondLoader.load();
			mainLoader = new SWFLoader("main.swf",
				{container:this,scaleMode:"none"
					,onComplete:mainComplete,onProgress:showLoading});
			mainLoader.load();
			
			//mainLoader.content.addChild(mesChaussures);
			//stage.dispatchEvent(new Event(Event.RESIZE,false,true));
			//MonsterDebugger.trace(this,mainLoader.content.x);

		}
		private function mainComplete(le:LoaderEvent):void {
			MonsterDebugger.trace(this,"main.swf loading complete");
			/*
			var mc:MovieClip = mainLoader.rawContent; //the root of the child swf
			mc.init();
			MonsterDebugger.trace(this,"cible : " + mc.getChildByName("cibleShoes"));
			var cible:MovieClip = MovieClip(mc.getChildByName("cibleShoes"));
			//mainLoader.rawContent.cibleShoes.addChild(mesChaussures);	
			mainLoader.content.x = stage.stageWidth/2 - mainLoader.content.width/2;;
			*/
			stage.dispatchEvent(new Event(Event.RESIZE,false,true));
			modelShoes = new ShoesModel();
			
			main = Main(mainLoader.rawContent); //the root of the child swf
			trace (main + ":" +mainLoader.content.width);
			main.clipGalleryVisuels.signalColorFond.add(changeCouleurFond);
			//var menu:MovieClip = MovieClip(mcMain.getChildByName("clipMenu"));
			//menu = Menu(main.getChildByName("clipMenu"));
			main.signalChangeCouleurFond.add(changeCouleurFond);
			main.signalChangePositionFond.add(actualiseFond);
			menu = main.clipMenu;
			initStateListeners();
			//gallerie_visuels = Gallerie(main.getChildByName("clipGalleryVisuels"));
			gallerie_visuels = main.clipGalleryVisuels;
			modelShoes.signalShoesReady.add(injectShoes);
			//menu.animateIn();
			trace(menu);
			trace(gallerie_visuels);
			fond.finLoading();
			//menu.animateIn();
			//mcMain.addChild(new Gallerie());
			
		}
		private function fondComplete(le:LoaderEvent):void {
			MonsterDebugger.trace(this,"fond.swf loading complete");
			this.setChildIndex(fondLoader.content,0);
			stage.dispatchEvent(new Event(Event.RESIZE,false,true));
			fond = Fond(le.target.rawContent);
			
		}
		private function showLoading(e:LoaderEvent):void {
			trace(e.target.progress)
			if (fond) fond.setLoading(e.target.progress);
		}
		private function injectShoes(params:Vector.<ShoeVO>):void {
			gallerie_visuels.shoeCollection = params;
			//effet visuel d'intro
			fond.intro();
			main.clipMenu.comeIn();
			main.clipGalleryVisuels.comeIn();
		}
		private function initStateListeners():void {
			menu.signalState.add(changeMainState);
		}
		private function changeMainState(state:String):void {
			switch (state) {
				case Main.STATE_SHOP :
					main.changeState(Main.STATE_SHOP);
					break;
				case Main.STATE_GALLERY :
					main.changeState(Main.STATE_GALLERY);
					break;
				case Main.STATE_GALLERYTHUMBS :
					main.changeState(Main.STATE_GALLERYTHUMBS);
					break;
				case Main.STATE_CONTACTPRESSE :
					main.changeState(Main.STATE_CONTACTPRESSE);
					break;
				case Main.STATE_ABOUT :
					main.changeState(Main.STATE_ABOUT);
					break;				
			}
		}
		private function changeCouleurFond(couleur:Number):void {
			fond.changeTeinte(couleur);
		}
		private function actualiseFond(delta:Number):void {
			trace("decaleFond : " +delta);
			fond.reinitPosition();
			fond.decaleFond(delta);
		}
		private function onStageResize(e:Event):void {
			trace("stage : "+this.stage.stageWidth);
			trace("main :" + mainLoader.content.width);
			//TweenLite.to(mainLoader.content,0.5,{x: stage.stageWidth/2 - LARGEUR_ANIM/2,y:stage.stageHeight/2 - HAUTEUR_ANIM/2});
			mainLoader.content.x = stage.stageWidth/2 - LARGEUR_ANIM/2;
			mainLoader.content.y = stage.stageHeight/2 - HAUTEUR_ANIM/2;
			trace("main content.x :" + mainLoader.content.x);
			//mainLoader.content.y = stage.stageHeight/2 - mainLoader.content.height/2;
			
			fondLoader.content.x = stage.stageWidth/2 - fondLoader.content.width/2;;
			fondLoader.content.y = stage.stageHeight/2 - fondLoader.content.height/2;
			

		}
	}
}