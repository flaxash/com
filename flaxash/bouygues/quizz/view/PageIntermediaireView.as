package com.flaxash.bouygues.quizz.view
{
	import com.flaxash.bouygues.quizz.view.component.BandeauBas;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import com.demonsters.debugger.MonsterDebugger;
	
	public class PageIntermediaireView extends MovieClip
	{
		//sur la scène
		public var boutonInviteMoreFriends:MovieClip;
		public var bandeauBas:BandeauBas;
		
		public function PageIntermediaireView()
		{
			super();
			visible=false;
			initListeners();
		}
		private function initListeners():void 
		{
			boutonInviteMoreFriends.addEventListener(MouseEvent.CLICK,inviteFriends);
		}
		private function inviteFriends(me:MouseEvent):void {
			MonsterDebugger.trace(this,"inviteFriends function javascript called");
			ExternalInterface.call("invitations");
		}
	}
}