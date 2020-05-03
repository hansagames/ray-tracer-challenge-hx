package utils;

import types.Tuple;

class Tuples {
	public static function isPoint(t:Tuple):Bool {
		return t.w == 1;
	}

	public static function isVector(t:Tuple):Bool {
		return t.w == 0;
	}

	public static function magnitude(t:Tuple):Float {
		return Math.sqrt(t.x * t.x + t.y * t.y + t.z * t.z + t.w * t.w);
	}

	public static function normalize(t:Tuple):Tuple {
		return t / magnitude(t);
	}

	public static function dot(a:Tuple, b:Tuple):Float {
		return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
	}

	public static function cross(a:Tuple, b:Tuple):Tuple {
		return new Tuple(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x, 0);
	}
}
