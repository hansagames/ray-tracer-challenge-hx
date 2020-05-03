package utils;

import types.Tuple;

class TuplesCreator {
	public static function create(x:Float, y:Float, z:Float, w:Float):Tuple {
		return new Tuple(x, y, z, w);
	}

	public static function createVector(x:Float, y:Float, z:Float):Tuple {
		return new Tuple(x, y, z, 0);
	}

	public static function createPoint(x:Float, y:Float, z:Float):Tuple {
		return new Tuple(x, y, z, 1);
	}
}
