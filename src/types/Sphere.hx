package types;

import utils.MatrixCreator.createIdentityMatrix;
import utils.MaterialsCreator.createMaterial;

class Sphere {
	public var transform:Matrix;
	public var material:Material;

	public function new() {
		transform = createIdentityMatrix(4, 4);
		material = createMaterial();
	}
}
