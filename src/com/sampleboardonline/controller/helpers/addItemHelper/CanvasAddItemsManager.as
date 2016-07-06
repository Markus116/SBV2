package com.sampleboardonline.controller.helpers.addItemHelper {
import com.sampleboardonline.model.vo.CanvasItemVO;

import flash.events.Event;

import mx.collections.ArrayCollection;

public class CanvasAddItemsManager {

		/*private static const locator:SampleBoardModelLocater = SampleBoardModelLocater.getInstance();
		private static const appModel:ApplicationModel = ApplicationModel.getInstance();

		private static var boardVO:BoardVO;
		public static function addItems(board:BoardVO):void{
			boardVO = board;
			if(boardVO.layer.hasTextItems()){
				locator.AddEventToArrayCollection(SampleBoardConstants.LOADING_FONTS);
				loadFonts(boardVO.layer.items);
			} else {
				startAdding();
			}
		}

		private static function getTextItemsCollection(layerData:String):Array{
			var resStr:String = layerData.replace(/\\/g,"").replace(/\"{/g,"{").replace(/}\"/g,"}");
			var itemsObj:Object = JSON.decode(resStr);

			var _itemsCollection:Array = [];

			for each (var canvasItemObject:Object in itemsObj){
				var canvasItemVO:CanvasItemVO = objectToCanvasVO(canvasItemObject);
				if(canvasItemVO.itemTypeId == SampleBoardConstants.ITEM_TYPE_TEXT){
					_itemsCollection.push(canvasItemVO);
				}
			}

			_itemsCollection.sortOn("zPosition",Array.NUMERIC);
			return _itemsCollection;
		}

		private static function loadFonts(itemsCollection:ArrayCollection):void{
			var fonts:Array = [];
			for each (var item:CanvasItemVO in itemsCollection) {
				if(item.itemTypeId == SampleBoardConstants.ITEM_TYPE_TEXT){
					if(fonts.indexOf(item.textFont)==-1){
						fonts.push(item.textFont);
					}
				}
			}

			var fontLoadingManager:FontLoadingManager = new FontLoadingManager();
			fontLoadingManager.addEventListener(FontLoadingManager.FONST_LOADED,onFontLoadingFinished);
			fontLoadingManager.loadFonts(fonts);
		}

		private static function onFontLoadingFinished(event:Event):void{
			var fontLoadingManager:FontLoadingManager = event.target as  FontLoadingManager;
			fontLoadingManager.removeEventListener(FontLoadingManager.FONST_LOADED,onFontLoadingFinished);
			locator.RemoveEventFromArrayCollection(SampleBoardConstants.LOADING_FONTS);
			startAdding();
		}

		private static function startAdding():void{
			CanvasOpenUtils.clearSortedImageInfo();
			CanvasOpenUtils.itemsCount = boardVO.layer.items.length;
			appModel.boardIsOpenning = true;
			appModel.selectedBoard = boardVO;
		}

		public static function addItem(item:CanvasItemVO):void{
			if(item){
				item.zPosition = appModel.selectedBoard.layer.items.length;
				appModel.selectedBoard.layer.items.addItem(item);
			}
		}

		public static function addBGImage(item:CanvasItemVO):void{
			locator.AddEventToArrayCollection(SampleBoardConstants.ADDING_ITEM);
			SampleBoardInternalEvents.LOSE_FOCUS.dispatch();

			//TODO
			appModel.selectedBoard.layer.layerBackground = item.imagePath;

			locator.selectedTool = SampleBoardConstants.TOOL_SELECT;
			SampleBoardInternalEvents.TOOL_CHANGED.dispatch(SampleBoardConstants.TOOL_SELECT);
			locator.RemoveEventFromArrayCollection(SampleBoardConstants.ADDING_ITEM);
		}
		public static function removeBGImage():void{
			locator.AddEventToArrayCollection(SampleBoardConstants.ADDING_ITEM);
			SampleBoardInternalEvents.LOSE_FOCUS.dispatch();

			//TODO
			appModel.selectedBoard.layer.layerBackground = "";

			locator.selectedTool = SampleBoardConstants.TOOL_SELECT;
			SampleBoardInternalEvents.TOOL_CHANGED.dispatch(SampleBoardConstants.TOOL_SELECT);
			locator.RemoveEventFromArrayCollection(SampleBoardConstants.ADDING_ITEM);
		}

		private static function objectToCanvasVO(objObject:Object):CanvasItemVO{
			var item:CanvasItemVO;
			if(objObject){
				item                 				= new CanvasItemVO();
				item.itemTypeId 					= objObject.itemTypeId;
				item.labelItemTSId 					= objObject.labelItemTSId;
				item.height							= objObject.height;
				item.width							= objObject.width;
				item.scaleX							= objObject.scaleX;
				item.scaleY							= objObject.scaleY;
				item.xPosition						= objObject.xPosition;
				item.yPosition						= objObject.yPosition;
				item.xImagePosition					= objObject.xImagePosition;
				item.yImagePosition					= objObject.yImagePosition;
				item.zPosition						= objObject.zPosition;
				item.rotateAngle					= objObject.rotateAngle;
				item.canvasHeight					= objObject.canvasHeight;
				item.canvasWidth					= objObject.canvasWidth;

				item.textFont 						= objObject.textFont;
				item.textFontSize 					= objObject.textFontSize;
				item.textIsBold 					= objObject.textIsBold;
				item.textIsItalic 					= objObject.textIsItalic;
				item.textIsUnderline 				= objObject.textIsUnderline;
				item.textAlign						= objObject.textAlign;
				item.textBackgroundFill				= objObject.textBackgroundFill;
				item.textBackgroundColor			= objObject.textBackgroundColor;
				item.textFontColor					= objObject.textFontColor;
				item.textBalloonType				= objObject.textBalloonType;
				item.textBalloonText				= objObject.textBalloonText;

				item.imageId		 				= objObject.imageId;
				item.imageType		 				= objObject.imageType;
				item.imagePath 						= objObject.imagePath;
				//Filters
				item.opacity						= objObject.opacity;

				item.bReflection					= objObject.bReflection;
				item.reflectionFallOff				= objObject.reflectionFallOff;
				item.reflectionOpacity				= objObject.reflectionOpacity;

				item.bDropShadowEnabled				= objObject.bDropShadowEnabled;
				item.dropShadowBlur					= objObject.dropShadowBlur;
				item.dropShadowAngle				= objObject.dropShadowAngle;
				item.dropShadowDistance				= objObject.dropShadowDistance;
				item.dropShadowOpacity				= objObject.dropShadowOpacity;
				item.dropShadowColor				= objObject.dropShadowColor;

				item.bBlurEnabled					= objObject.bBlurEnabled;
				item.blur							= objObject.blur;
				item.blurQuality					= objObject.blurQuality;

				item.bBlackAndWhite					= objObject.bBlackAndWhite;
				item.bFlipped						= objObject.bFlipped;
				item.bFlopped						= objObject.bFlopped;
				item.bSepia							= objObject.bSepia;
				item.bInfrared						= objObject.bInfrared;
				item.bEmbossed						= objObject.bEmbossed;
				item.bTile							= objObject.bTile;
				item.bNoise							= objObject.bNoise;
				item.bInvert						= objObject.bInvert;
				item.bPixelate						= objObject.bPixelate;
				item.pixelateValue					= objObject.pixelateValue;

				item.hue							= objObject.hue;
				item.saturation						= objObject.saturation;
				item.brightness						= objObject.brightness;
				item.contrast						= objObject.contrast;

				item.bCrooped						= objObject.bCrooped;
				item.cropX1							= objObject.cropX1;
				item.cropY1							= objObject.cropY1;
				item.cropX2							= objObject.cropX2;
				item.cropY2							= objObject.cropY2;

				//Shape Properties
				item.shapeType						= objObject.shapeType;
				item.shapeStrokeSize 				= objObject.shapeStrokeSize;
				item.shapeStrokeColor 				= objObject.shapeStrokeColor;
				item.shapeGradientType 				= objObject.shapeGradientType;
				item.shapeGradientColor1 			= objObject.shapeGradientColor1;
				item.shapeGradientColor2 			= objObject.shapeGradientColor2;
			}
			return item;
		}*/
	}
}
