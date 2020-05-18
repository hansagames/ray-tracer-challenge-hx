package utils;

import types.Tuple;
import types.PointLight;

class PointLightCreator {
	public static function createPointLight(position:Tuple, intensity:Tuple):PointLight {
		return new PointLight(position, intensity);
	}
}
