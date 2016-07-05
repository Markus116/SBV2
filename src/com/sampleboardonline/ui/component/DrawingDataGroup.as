package com.sampleboardonline.ui.component {
	import com.sampleboardonline.controller.events.BaseEvent;
	import com.sampleboardonline.model.vo.CanvasItemVO;
	import com.sampleboardonline.ui.renderer.canvasRenderer.BaseCanvasRenderer;

	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.containers.Canvas;
	import mx.core.ClassFactory;
	import mx.core.UIComponent;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;

	[Event(name="childAdded",type="com.sampleboardonline.controller.events.BaseEvent")]
	[Event(name="childRemoved",type="com.sampleboardonline.controller.events.BaseEvent")]
	public class DrawingDataGroup extends Canvas {

		public var holder:UIComponent;

		private var loadingQueue:Array = [];
		private var loadingHelpers:Array = [];

		private var itemToRenderer:Dictionary = new Dictionary();

		public function DrawingDataGroup(){
			super();
		}

		private var dataProviderChanged:Boolean;
		private var _dataProvider:IList;
		[Bindable]
		public function get dataProvider():IList {
			return _dataProvider;
		}

		public function set dataProvider(value:IList):void {
			if(_dataProvider != value){
				trace("DataProvider changed");
				removeDataProviderListeners(_dataProvider);
				_dataProvider = value;
				dataProviderChanged = true;
				loadingQueue = [];
				loadingHelpers = [];
				addDataProviderListeners(_dataProvider);
				invalidateProperties();
			}
		}

		public var itemRendererFunction:Function;

		override protected function commitProperties():void {
			super.commitProperties();

			if (!dataProvider) {
				removeAllChildren();
				return;
			} else if(dataProviderChanged){
				dataProviderChanged = false;
				removeAllChildren();
				createRendererItems();
			}
		}

		private function addDataProviderListeners(collection:IList):void{
			if(collection){
				ArrayCollection(collection).addEventListener(CollectionEvent.COLLECTION_CHANGE,onCollectionChanged);
			}
		}

		private function removeDataProviderListeners(collection:IList):void{
			if(collection){
				ArrayCollection(collection).removeEventListener(CollectionEvent.COLLECTION_CHANGE,onCollectionChanged);
			}
		}

		protected function onCollectionChanged(event:CollectionEvent):void {
			if(event.kind != CollectionEventKind.UPDATE	){
				createRendererItems();
			}
		}

		/**
		 * create new renderer (if not created before) for selected item and added to group
		 * @param _selectedItem
		 *
		 */
		private function createRendererForItem(item:Object):void {
			var renderer : DisplayObject = itemToRenderer[item];
			var newRenderer:Boolean = !renderer;
			if (newRenderer) { // create new renderer for item
				var classFactory:ClassFactory = itemRendererFunction(item);
				renderer = classFactory.newInstance();
				BaseCanvasRenderer(renderer).data = item;
				this.addChild(renderer);
				itemToRenderer[item] = renderer;
				dispatchEvent(new BaseEvent("childAdded",renderer));
			} else if(getChildIndex(renderer)!=-1){ // reuse old renderer
				this.addChild(renderer);
			}
		}

		public function removeRendererForItem(item:Object):void{
			var renderer : DisplayObject = itemToRenderer[item];
			if(renderer && getChildIndex(renderer)!=-1){
				delete itemToRenderer[item];
				this.removeChild(renderer);
				dispatchEvent(new BaseEvent("childRemoved",renderer));
			}
		}

		private function createRendererItems():void{
			checkRemovedItems();
			for each (var item:Object in _dataProvider) {
				createRendererForItem(item);
			}
		}

		private function checkRemovedItems() : void {
			for (var i : int = numChildren;i > 0;i--) {
				var child : BaseCanvasRenderer = BaseCanvasRenderer(getChildAt(i-1));
				if (dataProvider.getItemIndex(child.data) < 0) {
					removeRendererForItem(child.data);
				}
			}
		}

		override public function removeAllChildren():void {
			for (var i:int = numChildren-1; i >= 0; i--) {
				var child:BaseCanvasRenderer = getChildAt(i) as BaseCanvasRenderer;
				var item:CanvasItemVO = child.data as CanvasItemVO;
				removeRendererForItem(item);
			}
			super.removeAllChildren();
		}

		override public function addChild(child:DisplayObject):DisplayObject {
			if(child is BaseCanvasRenderer){
				return super.addChild(child);
			}else {
				holder.addChild(child);
				return null;
			}
		}

		override public function removeChild(child:DisplayObject):DisplayObject {
			if(child is BaseCanvasRenderer){
				return super.removeChild(child);
			} else {
				holder.removeChild(child);
				return null;
			}
		}
	}
}

