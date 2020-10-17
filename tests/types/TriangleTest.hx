package types;

import utils.RayCreator.createRay;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.TriangleCreator.createTriangle;
import utils.Transformation.translation;
import utils.Transformation.scaling;
import utils.Transformation.rotationZ;

using utils.Tuples;

class TriangleTest extends BuddySuite {
	public function new() {
		describe("TriangleTest", {
			describe("create", {
				it("should create triangle", {
					final p1 = createPoint(0,1,0);
					final p2 = createPoint(-1, 0, 0);
					final p3 = createPoint(1, 0, 0);
					final t = createTriangle(p1, p2, p3);
					t.p1.should.equal(p1);
					t.p2.should.equal(p2);
					t.p3.should.equal(p3);
					t.e1.should.equal(createVector(-1, -1, 0));
					t.e2.should.equal(createVector(1, -1, 0));
					t.normal.should.equal(createVector(0, 0, -1));
				});
			});
			describe("normal", {
				it("should calculate normal", {
					final t = createTriangle(
						createPoint(0,1,0),
						createPoint(-1,0,0),
						createPoint(1,0,0)
					);
					final n1 = t.normalAt(createPoint(0, 0.5, 0));
					final n2 = t.normalAt(createPoint(-0.5, 0.75, 0));
					final n3 = t.normalAt(createPoint(0.5, 0.25, 0));

					n1.should.equal(t.normal);
					n2.should.equal(t.normal);
					n3.should.equal(t.normal);
				});
			});
			describe("intersection", {
				it("should intersect parallel ray", {
					final t = createTriangle(
						createPoint(0,1,0),
						createPoint(-1,0,0),
						createPoint(1,0,0)
					);
					final ray = createRay(createPoint(0, -1, -2), createVector(0, 1, 0));
					final xs = t.intersects(ray);
					xs.length.should.be(0);
				});
				it("should miss p1-p3 edge", {
					final t = createTriangle(
						createPoint(0,1,0),
						createPoint(-1,0,0),
						createPoint(1,0,0)
					);
					final ray = createRay(createPoint(1, 1, -2), createVector(0, 0, 1));
					final xs = t.intersects(ray);
					xs.length.should.be(0);
				});
				it("should miss p1-p2 edge", {
					final t = createTriangle(
						createPoint(0,1,0),
						createPoint(-1,0,0),
						createPoint(1,0,0)
					);
					final ray = createRay(createPoint(-1, 1, -2), createVector(0, 0, 1));
					final xs = t.intersects(ray);
					xs.length.should.be(0);
				});
				it("should miss p2-p3 edge", {
					final t = createTriangle(
						createPoint(0,1,0),
						createPoint(-1,0,0),
						createPoint(1,0,0)
					);
					final ray = createRay(createPoint(0, -1, -2), createVector(0, 0, 1));
					final xs = t.intersects(ray);
					xs.length.should.be(0);
				});
				it("should miss p2-p3 edge", {
					final t = createTriangle(
						createPoint(0,1,0),
						createPoint(-1,0,0),
						createPoint(1,0,0)
					);
					final ray = createRay(createPoint(0, 0.5, -2), createVector(0, 0, 1));
					final xs = t.intersects(ray);
					xs.length.should.be(1);
					xs[0].t.should.be(2);
				});
			});
		});
	}
}
