package utils;

import utils.RayCreator.createRay;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.SphereCreator.createSphere;
import utils.MatrixCreator.createIdentityMatrix;
import utils.Transformation.translation;
import utils.Transformation.scaling;

using utils.Spheres;

class SpheresTest extends BuddySuite {
	public function new() {
		describe("SpheresTest", {
			describe("intersects", {
				it("should intersect sphere at 2 points", {
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final sphere = createSphere();
					final xs = sphere.intersects(ray);
					xs.length.should.be(2);
					xs[0].t.should.be(4);
					xs[1].t.should.be(6);
				});
				it("should intersect at tangent", {
					final ray = createRay(createPoint(0, 1, -5), createVector(0, 0, 1));
					final sphere = createSphere();
					final xs = sphere.intersects(ray);
					xs.length.should.be(2);
					xs[0].t.should.be(5);
					xs[1].t.should.be(5);
				});
				it("should miss sphere", {
					final ray = createRay(createPoint(0, 2, -5), createVector(0, 0, 1));
					final sphere = createSphere();
					final xs = sphere.intersects(ray);
					xs.length.should.be(0);
				});
				it("should intersect from within sphere", {
					final ray = createRay(createPoint(0, 0, 0), createVector(0, 0, 1));
					final sphere = createSphere();
					final xs = sphere.intersects(ray);
					xs.length.should.be(2);
					xs[0].t.should.be(-1);
					xs[1].t.should.be(1);
				});
				it("should intersect with sphere that is behind", {
					final ray = createRay(createPoint(0, 0, 5), createVector(0, 0, 1));
					final sphere = createSphere();
					final xs = sphere.intersects(ray);
					xs.length.should.be(2);
					xs[0].t.should.be(-6);
					xs[1].t.should.be(-4);
				});
				it("should return intersected object", {
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final sphere = createSphere();
					final xs = sphere.intersects(ray);
					xs.length.should.be(2);
					xs[0].object.should.be(sphere);
					xs[1].object.should.be(sphere);
				});
				it("should intersected scaled sphere", {
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final sphere = createSphere();
					sphere.transform = scaling(2, 2, 2);
					final xs = sphere.intersects(ray);
					xs.length.should.be(2);
					xs[0].t.should.be(3);
					xs[1].t.should.be(7);
				});
				it("should intersected transalted sphere", {
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final sphere = createSphere();
					sphere.transform = translation(5, 0, 0);
					final xs = sphere.intersects(ray);
					xs.length.should.be(0);
				});
			});
			describe("transform", {
				it("should have default identity matrix as transform", {
					final sphere = createSphere();
					final identity = createIdentityMatrix(4, 4);
					sphere.transform.should.equal(identity);
				});
				it("should set sphere transform", {
					final sphere = createSphere();
					final m = translation(2, 3, 4);
					sphere.transform = m;
					sphere.transform.should.equal(m);
				});
			});
		});
	}
}
