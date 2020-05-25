package types;

import utils.MatrixCreator.createIdentityMatrix;
import utils.MaterialsCreator.createMaterial;
import utils.Transformation.translation;

class ShapeTest extends BuddySuite {
	public function new() {
		describe("ShapeTest", {
			describe("transform", {
				it("should have default identity matrix as transform", {
					final sphere = createShape();
					final identity = createIdentityMatrix(4, 4);
					sphere.transform.should.equal(identity);
				});
				it("should set sphere transform", {
					final sphere = createShape();
					final m = translation(2, 3, 4);
					sphere.transform = m;
					sphere.transform.should.equal(m);
				});
			});
			describe("material", {
				it("should have default material", {
					final sphere = createShape();
					final m = createMaterial();
					sphere.material.should.equal(m);
				});
				it("should update material", {
					final sphere = createShape();
					final m = createMaterial();
					m.ambient = 1;
					sphere.material = m;
					sphere.material.should.equal(m);
				});
			});
		});
	}

	private function createShape():Shape {
		return new Shape();
	}
}
