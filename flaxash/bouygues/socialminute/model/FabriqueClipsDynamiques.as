package com.flaxash.bouygues.socialminute.model
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.flaxash.bouygues.socialminute.view.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import org.osflash.signals.Signal;
	
	public class FabriqueClipsDynamiques
	{
		public var signalClipsPrets:Signal;
		public var loaderImages : LoaderMax;
		
		private var xmlFacebook:XML;
		private var clips:Object;
		
		public function FabriqueClipsDynamiques()
		{
			signalClipsPrets = new Signal();
			
		}
		public function initClips(_xmlFacebook:XML,_clips:Object):void {
			
			trace("initClips dans FabriqueClipsDynamiques");
			//trace(_xmlFacebook);
			//actions
			xmlFacebook = _xmlFacebook;
			clips = _clips;
			var compteur:uint=0;
			//chargement des images profiles et posts
			loaderImages = new LoaderMax({auditSize:false, onComplete:chargementImagesFini});
			
			if (xmlFacebook.sequence.(@id=="statut1").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="statut1").photo,{name:"statut1",width:26,height:26,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="statut1").photo.toString().length);
			
			if (xmlFacebook.sequence.(@id=="statut2").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="statut2").photo,{name:"statut2",width:30,height:30,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="statut2").photo.toString().length);
			
			if (xmlFacebook.sequence.(@id=="statut3").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="statut3").photo,{name:"statut3",width:27,height:27,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="statut3").photo.toString().length);
			
			if (xmlFacebook.sequence.(@id=="lien").thumbnail.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="lien").thumbnail,{name:"lien_image",width:101,height:127,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="lien").thumbnail.toString().length);
			
			if (xmlFacebook.sequence.(@id=="lien").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="lien").photo,{name:"lien_pp",width:25,height:25,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="lien").photo.toString().length);
			
			if (xmlFacebook.sequence.(@id=="anniv").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="anniv").photo,{name:"anniv",width:60,height:60,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="anniv").photo.toString().length);
			
			if (xmlFacebook.sequence.(@id=="photo1").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="photo1").photo,{name:"photo1",width:245,height:162,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="photo1").photo.toString().length);
			
			if (xmlFacebook.sequence.(@id=="photo2").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="photo2").photo,{name:"photo2",width:245,height:162,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="photo2").photo.toString().length);
			
			if (xmlFacebook.sequence.(@id=="photo3").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="photo3").photo,{name:"photo3",width:245,height:162,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}  
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="photo3").photo.toString().length);
			
			if (xmlFacebook.sequence.(@id=="publistar").photo.toString().length>0) {
				loaderImages.append(new ImageLoader(xmlFacebook.sequence.(@id=="publistar").photo,{name:"publistar",width:160,height:200,
					scaleMode:"proportionalOutside",crop:true,hAlign:"center",vAlign:"center",onError:pbLoading,onComplete:checkImage}));
			}
			MonsterDebugger.trace(this,xmlFacebook.sequence.(@id=="publistar").photo.toString().length);
			
			loaderImages.load(true);
			MonsterDebugger.trace(this,"on a "+loaderImages.numChildren+" images à charger");
		}
		
		private function chargementImagesFini(le:LoaderEvent):void {
			MonsterDebugger.trace(this,"chargement des images fini, maj des infos now");
			// appel à des fonctions de mise à jour des clips dynamiques
			(clips["statut1"].asset as Clip3DStatut1).majElementsDyn(xmlFacebook.sequence.(@id=="statut1").prenom,
				xmlFacebook.sequence.(@id=="statut1").nblike,xmlFacebook.sequence.(@id=="statut1").nbcomment,
				xmlFacebook.sequence.(@id=="statut1").statut,loaderImages.getContent("statut1"));
			
			(clips["statut2"].asset as Clip3DStatut2).majElementsDyn(xmlFacebook.sequence.(@id=="statut2").prenom,
				xmlFacebook.sequence.(@id=="statut2").nblike,xmlFacebook.sequence.(@id=="statut2").nbcomment,
				xmlFacebook.sequence.(@id=="statut2").statut,loaderImages.getContent("statut2"));
			
			(clips["statut3"].asset as Clip3DStatut3).majElementsDyn(xmlFacebook.sequence.(@id=="statut3").prenom,
				xmlFacebook.sequence.(@id=="statut3").nblike,xmlFacebook.sequence.(@id=="statut3").nbcomment,
				xmlFacebook.sequence.(@id=="statut3").statut,loaderImages.getContent("statut3"));
			
			(clips["lien1"].asset as Clip3DLien1).majElementsDyn(xmlFacebook.sequence.(@id=="lien").prenom);
			
			(clips["lien2"].asset as Clip3DLien2).majElementsDyn(xmlFacebook.sequence.(@id=="lien").titre,
				xmlFacebook.sequence.(@id=="lien").nblike,xmlFacebook.sequence.(@id=="lien").nbcomment,
				loaderImages.getContent("lien_image"),loaderImages.getContent("lien_pp"));
			
			(clips["annivPrenom"].asset as Clip3DAnnivPrenom).majElementsDyn(xmlFacebook.sequence.(@id=="anniv").prenom,
				loaderImages.getContent("anniv"));
			
			(clips["annivDate"].asset as Clip3DAnnivDate).majElementsDyn(xmlFacebook.sequence.(@id=="anniv").jour,
				xmlFacebook.sequence.(@id=="anniv").mois);
			
			(clips["photo1"].asset as Clip3DPhoto1).majElementsDyn(xmlFacebook.sequence.(@id=="photo1").prenom,
				xmlFacebook.sequence.(@id=="photo1").nblike,xmlFacebook.sequence.(@id=="photo1").nbcomment,
				loaderImages.getContent("photo1"));
			
			(clips["photo2"].asset as Clip3DPhoto2).majElementsDyn(xmlFacebook.sequence.(@id=="photo2").prenom,
				xmlFacebook.sequence.(@id=="photo2").nblike,xmlFacebook.sequence.(@id=="photo2").nbcomment,
				loaderImages.getContent("photo2"));
			
			(clips["photo3"].asset as Clip3DPhoto3).majElementsDyn(xmlFacebook.sequence.(@id=="photo3").prenom,
				xmlFacebook.sequence.(@id=="photo3").nblike,xmlFacebook.sequence.(@id=="photo3").nbcomment,
				loaderImages.getContent("photo3"));
			
			(clips["aVenir"].asset as Clip3DAVenir).majElementsDyn(xmlFacebook.sequence.(@id=="avenir").jour,
				xmlFacebook.sequence.(@id=="avenir").mois,xmlFacebook.sequence.(@id=="avenir").evenement);
			
			(clips["amiActif"].asset as Clip3DAmiActif).majElementsDyn(xmlFacebook.sequence.(@id=="amiactif").prenom);
			
			(clips["publiStar"].asset as Clip3DPubliStar).majElementsDyn(xmlFacebook.sequence.(@id=="publistar").nblike,
				xmlFacebook.sequence.(@id=="publistar").nbcomment,xmlFacebook.sequence.(@id=="publistar").statut,
				loaderImages.getContent("publistar"));
			
			//signal pret
			signalClipsPrets.dispatch();
		}
		private function pbLoading(le:LoaderEvent):void {
			trace("erreur pendant le chargement d'une image : " + le.target.name);
			MonsterDebugger.trace(this,le.toString());
		}
		private function checkImage(le:LoaderEvent):void {
			MonsterDebugger.trace(this,"image " + le.target.name + " chargée");
			trace("image chargée : " +le.target.name +  " de largeur " + (loaderImages.getContent(le.target.name) as DisplayObject).width);
			trace("type de l'objet " + loaderImages.getContent(le.target.name));
		}
	}
	
}
