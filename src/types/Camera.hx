package types;

import utils.MatrixCreator.createIdentityMatrix;

class Camera {
	public var vSize(default, set):Float;
	public var hSize(default, set):Float;
	public var fov(default, set):Float;
	public var transform:Matrix;
	public var pixelSize(default, null):Float;
	public var halfWidth(default, null):Float;
	public var halfHeight(default, null):Float;

	public function new() {
		vSize = 1;
		hSize = 1;
		fov = 1;
		transform = createIdentityMatrix(4, 4);
	}

	function set_vSize(value:Float):Float {
		vSize = value;
		calculatePixelSize();
		return value;
	}

	function set_hSize(value:Float):Float {
		hSize = value;
		calculatePixelSize();
		return value;
	}

	function set_fov(value:Float):Float {
		fov = value;
		calculatePixelSize();
		return value;
	}

	function calculatePixelSize() {
		final halfView = Math.tan(fov * 0.5);
		final aspect = hSize / vSize;

		if (aspect >= 1) {
			halfWidth = halfView;
			halfHeight = halfView / aspect;
		} else {
			halfWidth = halfView * aspect;
			halfHeight = halfView;
		}

		pixelSize = (halfWidth * 2) / hSize;
	}
}
