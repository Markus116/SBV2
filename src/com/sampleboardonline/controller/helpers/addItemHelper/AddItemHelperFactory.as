package com.sampleboardonline.controller.helpers.addItemHelper {
import com.sampleboardonline.model.enum.ItemTypeEnum;

public class AddItemHelperFactory {
		public function AddItemHelperFactory() {
			throw new Error("You can't create factory method instance.");
		}

		public static function newInstance(type:int):BaseAddItemHelper {
			var res:BaseAddItemHelper;
			switch (type){
				case ItemTypeEnum.TEXT:
					res = new AddTextHelper();
					break;
				case ItemTypeEnum.IMAGE:
					res = new AddImageHelper();
					break;
				case ItemTypeEnum.SHAPE:
					res = new AddShapeHelper();
					break;
			}
			return res;
		}
	}
}
