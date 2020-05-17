package utils;

import types.Matrix;
import types.Ray;
import types.Tuple;
import utils.RayCreator.createRay;

class Rays {
	public static function position(ray:Ray, distance:Float):Tuple {
		return ray.origin + ray.direction * distance;
	}

	public static function transform(ray:Ray, m:Matrix):Ray {
		return createRay(m * ray.origin, m * ray.direction);
	}
}
