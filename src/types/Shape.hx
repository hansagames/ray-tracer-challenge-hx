package types;

import utils.MatrixCreator.createIdentityMatrix;
import utils.MaterialsCreator.createMaterial;
import utils.TuplesCreator.createPoint;

class Shape {
	public var transform:Matrix;
	public var material:Material;

	public function new() {
		transform = createIdentityMatrix(4, 4);
		material = createMaterial();
	}

	public function intersects(ray:Ray):Array<Intersection> {
		return [];
	}

	public function normalAt(point:Tuple):Tuple {
		return createPoint(0, 0, 0);
	}
}
