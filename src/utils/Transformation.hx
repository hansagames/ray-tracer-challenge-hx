package utils;

import types.Angle.Radians;
import types.Matrix;
import utils.MatrixCreator.createIdentityMatrix;

class Transformation {
	public static function translation(x:Float, y:Float, z:Float):Matrix {
		final m = createIdentityMatrix(4, 4);
		m.set(0, 3, x);
		m.set(1, 3, y);
		m.set(2, 3, z);
		return m;
	}

	public static function scaling(x:Float, y:Float, z:Float):Matrix {
		final m = createIdentityMatrix(4, 4);
		m.set(0, 0, x);
		m.set(1, 1, y);
		m.set(2, 2, z);
		return m;
	}

	public static function rotationX(radians:Radians):Matrix {
		final m = createIdentityMatrix(4, 4);
		m.set(1, 1, Math.cos(radians));
		m.set(1, 2, -Math.sin(radians));
		m.set(2, 1, Math.sin(radians));
		m.set(2, 2, Math.cos(radians));
		return m;
	}

	public static function rotationY(radians:Radians):Matrix {
		final m = createIdentityMatrix(4, 4);
		m.set(0, 0, Math.cos(radians));
		m.set(0, 2, Math.sin(radians));
		m.set(2, 0, -Math.sin(radians));
		m.set(2, 2, Math.cos(radians));
		return m;
	}

	public static function rotationZ(radians:Radians):Matrix {
		final m = createIdentityMatrix(4, 4);
		m.set(0, 0, Math.cos(radians));
		m.set(0, 1, -Math.sin(radians));
		m.set(1, 0, Math.sin(radians));
		m.set(1, 1, Math.cos(radians));
		return m;
	}

	public static function shearing(xy:Float, xz:Float, yx:Float, yz:Float, zx:Float, zy:Float):Matrix {
		return createIdentityMatrix(4, 4).set(0, 1, xy).set(0, 2, xz).set(1, 0, yx).set(1, 2, yz).set(2, 0, zx).set(2, 1, zy);
	}
}
