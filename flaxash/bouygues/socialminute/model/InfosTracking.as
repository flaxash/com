package com.flaxash.bouygues.socialminute.model
{
	import com.flaxash.bouygues.socialminute.model.VO.Sequence;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	
	import flash.display.Sprite;
	
	import org.osflash.signals.Signal;
	
	//classe qui contient les infos sur les sequences
	public class InfosTracking extends Sprite
	{
		private static const XML_PATH:String = "assets/";
		public var sequences:Vector.<Sequence>;
		
		public var sequenceEnCours:Sequence;
		public var signalInfosReady:Signal;
		
		private var queueXML:LoaderMax;
		private var trackingData:Object;
		public function InfosTracking()
		{
			super();
			signalInfosReady = new Signal();
			initLoading();
		}
		
		private function initLoading():void
		{
			trackingData  = new Object();
			// TODO Auto Generated method stub
			queueXML = new LoaderMax({onComplete:XMLCharges });
			queueXML.append(new XMLLoader(XML_PATH+"statut1.xml",{name:"statut1XML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"statut2.xml",{name:"statut2XML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"statut3.xml",{name:"statut3XML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"lien1.xml",{name:"lien1XML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"lien2.xml",{name:"lien2XML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"annivPrenom.xml",{name:"annivPrenomXML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"annivDate.xml",{name:"annivDateXML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"photos.xml",{name:"photosXML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"amiActif.xml",{name:"amiActifXML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"publiStar.xml",{name:"publiStarXML",onComplete:parseData}));
			queueXML.append(new XMLLoader(XML_PATH+"aVenir.xml",{name:"publiStarXML",onComplete:parseData}));

			queueXML.load();
			
		}
		private function XMLCharges(le:LoaderEvent):void {
			signalInfosReady.dispatch();
			trace("les XML sont chargés");
			//parseData();
			
		}
		private function parseData(le:LoaderEvent):void
		{
			var xmlData:XML = new XML(le.target.content);
			var sequenceNode:XML;
			//trace(xmlData.trackedSequence[0]);
			var coordsString:String;
			var coord:Array = new Array();
			var coords:Array;
			var ptCoord:Array;
			var x:int;
			var y:int;
			var fCoord:Array;
			
			
			
			for (var i:uint  = 0; i<xmlData.children().length(); i++)
			{
				sequenceNode = xmlData.trackedSequence[i];
				coords          = new Array();
				
				for (var f:uint = 0; f<sequenceNode.coords.coord.length(); f++)
				{
					coordsString = sequenceNode.coords.coord[f].toString();
					coord = coordsString.split(";");
					ptCoord         = new Array();
					
					for each (var ptCoordS:String in coord)
					{
						fCoord = ptCoordS.split(",");
						//x = Math.round(10*fCoord[0]/2)/10;
						//y = Math.round(10*fCoord[1]/2)/10;
						x = Math.round(Math.floor(fCoord[0])/2.5);
						y = Math.round(Math.floor(fCoord[1])/2.5);
						//x = fCoord[0];
						//y = fCoord[1];
						ptCoord.push([x,y]);
						
					}
					coords.push(ptCoord);
				}
				trackingData[sequenceNode.cuepoint] = coords;
				trace(coords[0]);
			}
		}

		public function getXMLTracking():Object {
			//trace("datas demandés : " + trackingData["statut1"]);
			return trackingData;
		}
	}
}