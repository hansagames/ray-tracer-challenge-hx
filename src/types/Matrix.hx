package types;

import haxe.ds.Vector;

abstract Matrix(Vector<Float>) from Vector<Float> to Vector<Float> {
	inline public function new(rows:UInt, columns:UInt) {
		this = new Vector<Float>(rows * columns + 2);
		for (i in 0...this.length) {
			this[i] = 0;
		}
		this[this.length - 2] = rows;
		this[this.length - 1] = columns;
	}

	inline public function get(row:UInt, column:UInt):Float {
		return this[row * columns + column];
	}

	inline public function set(row:UInt, column:UInt, value:Float):Matrix {
		this[row * rows + column] = value;
		return this;
	}

	public var length(get, never):Int;

	inline function get_length():Int {
		return this.length - 2;
	}

	public var columns(get, never):UInt;

	inline function get_columns():UInt {
		return Std.int(this[this.length - 1]);
	}

	public var rows(get, never):UInt;

	inline function get_rows():UInt {
		return Std.int(this[this.length - 2]);
	}

	@:arrayAccess
	public inline function arrayRead(k:Int):Float {
		return this[k];
	}

	@:arrayAccess
	public inline function arrayWrite(k:Int, v:Float):Float {
		this.set(k, v);
		return v;
	}

	@:op(A == B)
	public static function equals(a:Matrix, b:Matrix):Bool {
		if (a.length != b.length) {
			return false;
		} else {
			for (i in 0...a.length) {
				if (a[i] != b[i]) {
					return false;
				}
			}
		}
		return true;
	}

	@:op(A != B)
	public static function notEquals(a:Matrix, b:Matrix):Bool {
		if (a.length == b.length) {
			return false;
		} else {
			for (i in 0...a.length) {
				if (a[i] == b[i]) {
					return true;
				}
			}
		}
		return false;
	}

	@:op(A * B)
	public static function multiplayByMatrix(a:Matrix, b:Matrix):Matrix {
		final m = new Matrix(a.rows, a.columns);
		for (row in 0...a.rows) {
			for (column in 0...a.columns) {
				m.set(row, column,
					a.get(row, 0) * b.get(0, column)
					+ a.get(row, 1) * b.get(1, column)
					+ a.get(row, 2) * b.get(2, column)
					+ a.get(row, 3) * b.get(3, column));
			}
		}
		return m;
	}

	@:op(A * B)
	public static function multiplayByTuple(a:Matrix, b:Tuple):Tuple {
		final t = new Tuple(0, 0, 0, 0);
		for (row in 0...a.rows) {
			t[row] = a.get(row, 0) * b.x + a.get(row, 1) * b.y + a.get(row, 2) * b.z + a.get(row, 3) * b.w;
		}
		return t;
	}
}
