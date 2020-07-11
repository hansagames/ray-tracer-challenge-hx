package utils;

import types.Pattern;
import utils.WorldCreator.createDefaultWorld;
import utils.WorldCreator.createWorld;
import utils.RayCreator.createRay;
import utils.TuplesCreator.createVector;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.IntersectionCreator.createIntersection;
import utils.PointLightCreator.createPointLight;
import utils.SphereCreator.createSphere;
import utils.PlaneCreator.createPlane;
import utils.Transformation.translation;
import utils.MaterialsCreator.createMaterial;
import utils.Paterns.stripePattern;

using utils.Worlds;
using utils.Intersections;
using utils.Tuples;

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
					final comps = i.prepeareComputation(ray, [i]);
					final c = w.shadeHit(comps);
					c.should.equal(createColor(0.38066, 0.47583, 0.2855));
				});
				it("should shade intersection from the inside", {
					final w = createDefaultWorld();
					w.replaceLight(createPointLight(createPoint(0, 0.25, 0), createColor(1, 1, 1)));
					final ray = createRay(createPoint(0, 0, 0), createVector(0, 0, 1));
					final shape = w.meshes[1];
					final i = createIntersection(0.5, shape);
					final comps = i.prepeareComputation(ray, [i]);
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
					final comps = i.prepeareComputation(r, [i]);
					final c = w.shadeHit(comps);
					c.should.equal(createColor(0.1, 0.1, 0.1));
				});
				it("should calculate reflected color for reflective material", {
					final w = createDefaultWorld();
					final plane = createPlane();
					plane.material = createMaterial();
					plane.material.reflective = 0.5;
					plane.transform = translation(0, -1, 0);
					w.addMesh(plane);
					final ray = createRay(createPoint(0, 0, -3), createVector(0, -Math.sqrt(2) * 0.5, Math.sqrt(2) * 0.5));
					final i = createIntersection(Math.sqrt(2), plane);
					final comps = i.prepeareComputation(ray, [i]);
					final color = w.shadeHit(comps);
					color.should.equal(createColor(0.87677, 0.92436, 0.82918));
				});
				it("should calculate with transparent material", {
					final w = createDefaultWorld();
					final floor = createPlane();
					floor.material = createMaterial();
					floor.material.transparency = 0.5;
					floor.material.refractiveIndex = 1.5;
					floor.transform = translation(0, -1, 0);
					w.addMesh(floor);
					final ball = createSphere();
					ball.material.color = createColor(1, 0, 0);
					ball.material.ambient = 0.5;
					ball.transform = translation(0, -3.5, -0.5);
					w.addMesh(ball);
					final ray = createRay(createPoint(0, 0, -3), createVector(0, -Math.sqrt(2) * 0.5, Math.sqrt(2) * 0.5));
					final intersections = [createIntersection(Math.sqrt(2), floor)];
					final comps = intersections[0].prepeareComputation(ray, intersections);
					final color = w.shadeHit(comps, 5).roundTo(5);
					color.should.equal(createColor(0.93642, 0.68642, 0.68642));
				});
				it("should calculate with reflective and transparent material", {
					final w = createDefaultWorld();
					final floor = createPlane();
					floor.material = createMaterial();
					floor.material.reflective = 0.5;
					floor.material.transparency = 0.5;
					floor.material.refractiveIndex = 1.5;
					floor.transform = translation(0, -1, 0);
					w.addMesh(floor);
					final ball = createSphere();
					ball.material.color = createColor(1, 0, 0);
					ball.material.ambient = 0.5;
					ball.transform = translation(0, -3.5, -0.5);
					w.addMesh(ball);
					final ray = createRay(createPoint(0, 0, -3), createVector(0, -Math.sqrt(2) * 0.5, Math.sqrt(2) * 0.5));
					final intersections = [createIntersection(Math.sqrt(2), floor)];
					final comps = intersections[0].prepeareComputation(ray, intersections);
					final color = w.shadeHit(comps, 5).roundTo(5);
					color.should.equal(createColor(0.93391, 0.69643, 0.69243));
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
		describe("reflectedColor", {
			it("should calculate reflected color for reflective material", {
				final w = createDefaultWorld();
				final plane = createPlane();
				plane.material = createMaterial();
				plane.material.reflective = 0.5;
				plane.transform = translation(0, -1, 0);
				w.addMesh(plane);
				final ray = createRay(createPoint(0, 0, -3), createVector(0, -Math.sqrt(2) * 0.5, Math.sqrt(2) * 0.5));
				final i = createIntersection(Math.sqrt(2), plane);
				final comps = i.prepeareComputation(ray, [i]);
				final color = w.reflectedColor(comps, 5);
				color.should.equal(createColor(0.19032, 0.2379, 0.14274));
			});
			it("should calculate reflected color with max depth", {
				final w = createDefaultWorld();
				final plane = createPlane();
				plane.material = createMaterial();
				plane.material.reflective = 0.5;
				plane.transform = translation(0, -1, 0);
				w.addMesh(plane);
				final ray = createRay(createPoint(0, 0, -3), createVector(0, -Math.sqrt(2) * 0.5, Math.sqrt(2) * 0.5));
				final i = createIntersection(Math.sqrt(2), plane);
				final comps = i.prepeareComputation(ray, [i]);
				final color = w.reflectedColor(comps, 0);
				color.should.equal(createColor(0, 0, 0));
			});
		});
		describe("refractedColor", {
			it("should calculate refracted color for opaque surface", {
				final w = createDefaultWorld();
				final shape = w.meshes[0];
				final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
				final intersections = [createIntersection(4, shape), createIntersection(6, shape)];
				final comps = intersections[0].prepeareComputation(ray, intersections);
				w.refractedColor(comps, 5).should.equal(createColor(0, 0, 0));
			});
			it("should calculate refracted color for max recursive depth", {
				final w = createDefaultWorld();
				final shape = w.meshes[0];
				shape.material.transparency = 1;
				shape.material.refractiveIndex = 1.5;
				final ray = createRay(createPoint(0, 0, -5), createVector(0, 0, 1));
				final intersections = [createIntersection(4, shape), createIntersection(6, shape)];
				final comps = intersections[0].prepeareComputation(ray, intersections);
				w.refractedColor(comps, 0).should.equal(createColor(0, 0, 0));
			});
			it("should calculate color under total internal reflection", {
				final w = createDefaultWorld();
				final shape = w.meshes[0];
				shape.material.transparency = 1;
				shape.material.refractiveIndex = 1.5;
				final ray = createRay(createPoint(0, 0, Math.sqrt(2) * 0.5), createVector(0, 1, 0));
				final intersections = [
					createIntersection(-Math.sqrt(2) * 0.5, shape),
					createIntersection(Math.sqrt(2) * 0.5, shape)
				];
				final comps = intersections[1].prepeareComputation(ray, intersections);
				w.refractedColor(comps, 5).should.equal(createColor(0, 0, 0));
			});
			it("should calcualte color with refracted ray", {
				final w = createDefaultWorld();
				final a = w.meshes[0];
				a.material.ambient = 1;
				a.material.pattern = new Pattern();
				final b = w.meshes[1];
				b.material.transparency = 1;
				b.material.refractiveIndex = 1.5;
				final ray = createRay(createPoint(0, 0, 0.1), createVector(0, 1, 0));
				final intersections = [
					createIntersection(-0.9899, a),
					createIntersection(-0.4899, b),
					createIntersection(0.4899, b),
					createIntersection(0.9899, a)
				];
				final comps = intersections[2].prepeareComputation(ray, intersections);
				w.refractedColor(comps, 5).should.equal(createColor(0, 0.99888, 0.04725));
			});
		});
	}
}
