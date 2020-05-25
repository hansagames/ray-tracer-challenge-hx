package types;

import utils.RayCreator.createRay;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.SphereCreator.createSphere;
import utils.Transformation.translation;
import utils.Transformation.scaling;
import utils.Transformation.rotationZ;

using utils.Tuples;

class SphereTest extends BuddySuite {
	public function new() {
		describe("SphereTest", {
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
			describe("normalAt", {
				it("should calcualte normal on the x axis", {
					final sphere = createSphere();
					sphere.normalAt(createPoint(1, 0, 0)).should.equal(createVector(1, 0, 0));
				});
				it("should calcualte normal on the y axis", {
					final sphere = createSphere();
					sphere.normalAt(createPoint(0, 1, 0)).should.equal(createVector(0, 1, 0));
				});
				it("should calcualte normal on the z axis", {
					final sphere = createSphere();
					sphere.normalAt(createPoint(0, 0, 1)).should.equal(createVector(0, 0, 1));
				});
				it("should calcualte normal at nonaxial point", {
					final sphere = createSphere();
					sphere.normalAt(createPoint(Math.sqrt(3) / 3, Math.sqrt(3) / 3, Math.sqrt(3) / 3))
						.should.equal(createVector(Math.sqrt(3) / 3, Math.sqrt(3) / 3, Math.sqrt(3) / 3));
				});
				it("shoul be normalized", {
					final sphere = createSphere();
					final n = sphere.normalAt(createPoint(Math.sqrt(3) / 3, Math.sqrt(3) / 3, Math.sqrt(3) / 3));
					n.normalize().should.equal(n);
				});
				it("should compute normal for transformed sphere", {
					final sphere = createSphere();
					sphere.transform = translation(0, 1, 0);
					final n = sphere.normalAt(createPoint(0, 1.70711, -0.70711));
					n.should.equal(createVector(0, 0.70711, -0.70711));
				});
				it("should compute normal for scaled sphere", {
					final sphere = createSphere();
					sphere.transform = scaling(1, 0.5, 1) * rotationZ(Math.PI / 5);
					final n = sphere.normalAt(createPoint(0, Math.sqrt(2) / 2, -Math.sqrt(2) / 2));
					n.should.equal(createVector(0, 0.97014, -0.24254));
				});
			});
		});
	}
}
