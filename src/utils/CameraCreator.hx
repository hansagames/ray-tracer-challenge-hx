package utils;

import types.Camera;

class CameraCreator {
	public static function createCamera(hSize:Float, vSize:Float, fov:Float):Camera {
		final c = new Camera();
		c.fov = fov;
		c.hSize = hSize;
		c.vSize = vSize;
		return c;
	}
}
