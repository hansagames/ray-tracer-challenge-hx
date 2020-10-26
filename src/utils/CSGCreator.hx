package utils;

import types.Shape;
import types.CSG;

class CSGCreator {
	public static function csg(operation: Operation, left: Shape, right: Shape):CSG {
		return new CSG(operation, left, right);
	}
}
