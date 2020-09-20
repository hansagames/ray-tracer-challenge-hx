package types;

import utils.MatrixCreator.createIdentityMatrix;
import utils.MaterialsCreator.createMaterial;
import utils.TuplesCreator.createPoint;

using utils.Matrices;
using utils.Tuples;

class Shape {
	public var transform:Matrix;
	public var material:Material;
	public var parent:Null<Group>;

	public function new() {
		parent = null;
		transform = createIdentityMatrix(4, 4);
		material = createMaterial();
	}

	public function intersects(ray:Ray):Array<Intersection> {
		return [];
	}

	public function normalAt(point:Tuple):Tuple {
		return createPoint(0, 0, 0);
	}

	public function worldToObject(point:Tuple):Tuple {
		var p:Tuple = point;
		if (parent != null) {
			p = parent.worldToObject(point);
		}
		return transform.inverse() * p;
	}

	public function normalToWorld(normal:Tuple):Tuple {
		var n:Tuple;
		n = transform.inverse().transpose() * normal;
		n.w = 0;
		n = n.normalize();
		if (parent != null) {
			n = parent.normalToWorld(n);
		}
		return n;
	}
}
