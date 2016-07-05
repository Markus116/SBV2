package com.sampleboardonline.model.models {

[Bindable]
public class LeftPanelModel {

	public var selectedIndex:int = 0;

	private static var _instance:LeftPanelModel;
	public static function get instance():LeftPanelModel {
		if (!_instance) {
			_instance = new LeftPanelModel(new Blocker());
		}
		return _instance;
	}

	public function LeftPanelModel(blocker:Blocker) {
		if (!blocker) {
			throw new Error("LeftPanelModel is singleton use LeftPanelModel.instance");
		}
	}
}
}
internal class Blocker {};