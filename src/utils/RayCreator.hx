package utils;

import types.Tuple;
import types.Ray;

class RayCreator {
	public static function createRay(origin:Tuple, direction:Tuple):Ray {
		return new Ray(origin, direction);
	}
}
