package utils;

import types.Tuple;

using utils.Numbers;

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

	public static function reflect(v:Tuple, n:Tuple):Tuple {
		return v - n * 2 * dot(v, n);
	}

	public static function roundTo(source:Tuple, digitAfterComma:UInt):Tuple {
		return new Tuple(source.x.roundTo(digitAfterComma), source.y.roundTo(digitAfterComma), source.z.roundTo(digitAfterComma),
			source.w.roundTo(digitAfterComma));
	}
}
