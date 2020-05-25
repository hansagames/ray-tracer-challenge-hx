package types;

import haxe.ds.Vector;

abstract Tuple(Vector<Float>) from Vector<Float> to Vector<Float> {
	private static final Epsilon = Consts.Epsilon;

	inline public function new(x:Float, y:Float, z:Float, w:Float) {
		this = new Vector<Float>(4);
		this[0] = x;
		this[1] = y;
		this[2] = z;
		this[3] = w;
	}

	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var w(get, set):Float;

	@:op(A == B)
	public static function equals(a:Tuple, b:Tuple):Bool {
		return Math.abs(a.x - b.x) <= Epsilon && Math.abs(a.y - b.y) <= Epsilon && Math.abs(a.z - b.z) <= Epsilon && Math.abs(a.w - b.w) <= Epsilon;
	}

	@:op(A != B)
	public static function notEquals(a:Tuple, b:Tuple):Bool {
		return Math.abs(a.x - b.x) > Epsilon || Math.abs(a.y - b.y) > Epsilon || Math.abs(a.z - b.z) > Epsilon || Math.abs(a.w - b.w) > Epsilon;
	}

	@:op(A + B)
	public static function add(a:Tuple, b:Tuple):Tuple {
		return new Tuple(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w);
	}

	@:op(A - B)
	public static function substract(a:Tuple, b:Tuple):Tuple {
		return new Tuple(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w);
	}

	@:op(A * B)
	public static function multiplayByScalar(a:Tuple, b:Float):Tuple {
		return new Tuple(a.x * b, a.y * b, a.z * b, a.w * b);
	}

	@:op(A * B)
	public static function multiplayByTuple(a:Tuple, b:Tuple):Tuple {
		return new Tuple(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w);
	}

	@:op(A / B)
	public static function divideByScalar(a:Tuple, b:Float):Tuple {
		return new Tuple(a.x / b, a.y / b, a.z / b, a.w / b);
	}

	@:op(-A)
	public static function negate(a:Tuple):Tuple {
		return new Tuple(a.x * -1, a.y * -1, a.z * -1, a.w * -1);
	}

	@:arrayAccess
	public inline function arrayWrite(k:Int, v:Float):Float {
		this.set(k, v);
		return v;
	}

	private inline function get_x():Float {
		return this[0];
	}

	private inline function set_x(x:Float):Float {
		return this[0] = x;
	}

	private inline function get_y():Float {
		return this[1];
	}

	private inline function set_y(y:Float):Float {
		return this[1] = y;
	}

	private inline function get_z():Float {
		return this[2];
	}

	private inline function set_z(z:Float):Float {
		return this[2] = z;
	}

	private inline function get_w():Float {
		return this[3];
	}

	private inline function set_w(w:Float):Float {
		return this[3] = w;
	}
}
