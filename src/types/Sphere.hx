package types;

import utils.MatrixCreator.createIdentityMatrix;

class Sphere {
	public var transform(default, default):Matrix;

	public function new() {
		transform = createIdentityMatrix(4, 4);
	}
}
