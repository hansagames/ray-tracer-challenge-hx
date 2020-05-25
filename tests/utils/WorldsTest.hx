package utils;

import utils.WorldCreator.createDefaultWorld;
import utils.WorldCreator.createWorld;
import utils.RayCreator.createRay;
import utils.TuplesCreator.createVector;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.IntersectionCreator.createIntersection;
import utils.PointLightCreator.createPointLight;
import utils.SphereCreator.createSphere;
import utils.Transformation.translation;

using utils.Worlds;
using utils.Intersections;

class WorldsTest extends BuddySuite {
	public function new() {
		describe("WorldsTest", {
			describe("intersects", {
				it("should intersect world with ray", {
					final w = createDefaultWorld();
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final xs = w.intersects(ray);
					xs.length.should.be(4);
					xs[0].t.should.be(4);
					xs[1].t.should.be(4.5);
					xs[2].t.should.be(5.5);
					xs[3].t.should.be(6);
				});
			});
			describe("shadeHit", {
				it("should shade intersection", {
					final w = createDefaultWorld();
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final shape = w.meshes[0];
					final i = createIntersection(4, shape);
					final comps = i.prepeareComputation(ray);
					final c = w.shadeHit(comps);
					c.should.equal(createColor(0.38066, 0.47583, 0.2855));
				});
				it("should shade intersection from the inside", {
					final w = createDefaultWorld();
					w.replaceLight(createPointLight(createPoint(0, 0.25, 0), createColor(1, 1, 1)));
					final ray = createRay(createPoint(0, 0, 0), createVector(0, 0, 1));
					final shape = w.meshes[1];
					final i = createIntersection(0.5, shape);
					final comps = i.prepeareComputation(ray);
					final c = w.shadeHit(comps);
					c.should.equal(createColor(0.90498, 0.90498, 0.90498));
				});
				it("should shade with shadow", {
					final w = createWorld();
					w.addLight(createPointLight(createPoint(0, 0, -10), createColor(1, 1, 1)));
					final s1 = createSphere();
					w.addMesh(s1);
					final s2 = createSphere();
					s2.transform = translation(0, 0, 10);
					w.addMesh(s2);
					final r = createRay(createPoint(0, 0, 5), createVector(0, 0, 1));
					final i = createIntersection(4, s2);
					final comps = i.prepeareComputation(r);
					final c = w.shadeHit(comps);
					c.should.equal(createColor(0.1, 0.1, 0.1));
				});
			});
			describe("colorAt", {
				it("should color when ray misses", {
					final w = createDefaultWorld();
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 1, 0));
					final c = w.colorAt(ray);
					c.should.equal(createColor(0, 0, 0));
				});
				it("should color when ray hits", {
					final w = createDefaultWorld();
					final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
					final c = w.colorAt(ray);
					c.should.equal(createColor(0.38066, 0.47583, 0.2855));
				});
				it("should color with intersection behind the ray", {
					final w = createDefaultWorld();
					w.meshes[0].material.ambient = 1;
					w.meshes[1].material.ambient = 1;
					final ray = createRay(createPoint(0, 0, 0.75), createVector(0, 0, -1));
					final c = w.colorAt(ray);
					c.should.equal(w.meshes[1].material.color);
				});
			});
			describe("isShadowed", {
				it("should return false if nothing is between light and point", {
					final w = createDefaultWorld();
					final p = createPoint(0, 10, 0);
					w.isShadowed(p).should.be(false);
				});
				it("should return true if something is between light and point", {
					final w = createDefaultWorld();
					final p = createPoint(10, -10, 10);
					w.isShadowed(p).should.be(true);
				});
				it("should return false if point is behind light", {
					final w = createDefaultWorld();
					final p = createPoint(-20, 20, -20);
					w.isShadowed(p).should.be(false);
				});
				it("should return false if point is between light and object", {
					final w = createDefaultWorld();
					final p = createPoint(-2, 2, -2);
					w.isShadowed(p).should.be(false);
				});
			});
		});
	}
}
