package com.sampleboardonline.controller.events {

	import flash.events.Event;

	public class BaseEvent extends Event {

		public var data : Object;

		public function BaseEvent(type : String, data : Object = null, bubbles: Boolean = false) {
			super(type,bubbles);
			this.data = data;
		}
	}
}
