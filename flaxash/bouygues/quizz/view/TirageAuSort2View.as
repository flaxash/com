package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.view.component.BandeauBas;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	
	import com.demonsters.debugger.MonsterDebugger;
	
	public class TirageAuSort2View extends MovieClip
	{
		//sur la scène
		public var boutonInviteFriends:MovieClip;
		public var bandeauBas:BandeauBas;
		
		public function TirageAuSort2View()
		{
			super();
			visible=false;
			initListeners();
		}
		private function initListeners():void 
		{
			boutonInviteFriends.addEventListener(MouseEvent.CLICK,inviteFriends);
		}
		private function inviteFriends(me:MouseEvent):void {
			MonsterDebugger.trace(this,"inviteFriends function javascript called");
			ExternalInterface.call("invitations");
		}
	}
}