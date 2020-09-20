package types;

import utils.MatrixCreator.createIdentityMatrix;
import utils.MaterialsCreator.createMaterial;
import utils.Transformation.translation;
import utils.Transformation.scaling;
import utils.Transformation.rotationY;
import utils.GroupCreator.createGroup;
import utils.SphereCreator.createSphere;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;

using utils.Tuples;

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
			it("should have parent attribute", {
				final s = createShape();
				s.parent.should.be(null);
			});
			it("should convert point from world to object space", {
				final g1 = createGroup();
				g1.transform = rotationY(Math.PI * 0.5);
				final g2 = createGroup();
				g2.transform = scaling(2, 2, 2);
				g1.addChild(g2);
				final sphere = createSphere();
				sphere.transform = translation(5, 0, 0);
				g2.addChild(sphere);
				final p = sphere.worldToObject(createPoint(-2, 0, -10));
				p.should.equal(createPoint(0, 0, -1));
			});
			it("should convert normal from object to world space", {
				final g1 = createGroup();
				g1.transform = rotationY(Math.PI * 0.5);
				final g2 = createGroup();
				g2.transform = scaling(1, 2, 3);
				g1.addChild(g2);
				final sphere = createSphere();
				sphere.transform = translation(5, 0, 0);
				g2.addChild(sphere);
				final p = sphere.normalToWorld(createVector(Math.sqrt(3) / 3, Math.sqrt(3) / 3, Math.sqrt(3) / 3));
				p.should.equal(createVector(0.2857, 0.4286, -0.8571));
			});
			it("should find the normal on a child", {
				final g1 = createGroup();
				g1.transform = rotationY(Math.PI * 0.5);
				final g2 = createGroup();
				g2.transform = scaling(1, 2, 3);
				g1.addChild(g2);
				final sphere = createSphere();
				sphere.transform = translation(5, 0, 0);
				g2.addChild(sphere);
				final n = sphere.normalAt(createPoint(1.7321, 1.1547, -5.5774));
				n.roundTo(4).should.equal(createVector(0.2857, 0.4285, -0.8572));
			});
		});
	}

	private function createShape():Shape {
		return new Shape();
	}
}
