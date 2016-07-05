package com.sampleboardonline.model.models {
import com.sampleboardonline.model.vo.ProjectVO;

[Bindable]
public class MainModel {

	public var projectZoom:Number = 1;
	public var projectVO:ProjectVO = new ProjectVO("AAAAA");

	private static var _instance:MainModel;
	public static function get instance():MainModel {
		if (!_instance) {
			_instance = new MainModel(new Blocker());
		}
		return _instance;
	}

	public function MainModel(blocker:Blocker) {
		if (!blocker) {
			throw new Error("MainModel is singleton use MainModel.instance");
		}
	}
}
}
internal class Blocker {
}
;