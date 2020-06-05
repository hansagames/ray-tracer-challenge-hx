package types;

import utils.MatrixCreator.createIdentityMatrix;
import utils.TuplesCreator.createColor;

class Pattern {
	public var transform:Matrix;

	public function new() {
		transform = createIdentityMatrix(4, 4);
	}

	public function patternAt(point:Tuple):Tuple {
		return createColor(point.x, point.y, point.z);
	}
}
