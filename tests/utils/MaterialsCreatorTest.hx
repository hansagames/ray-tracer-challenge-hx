package utils;

import types.PointLight;
import types.Material;
import types.Tuple;
import utils.TuplesCreator.createColor;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.MaterialsCreator.createMaterial;
import utils.MaterialsCreator.lighting;
import utils.PointLightCreator.createPointLight;

using utils.Tuples;

class MaterialsCreatorTest extends BuddySuite {
	public function new() {
		describe("MaterialsCreatorTest", {
			describe("createMaterial", {
				it("should create material", {
					final material = createMaterial();
					material.ambient.should.be(0.1);
					material.diffuse.should.be(0.9);
					material.specular.should.be(0.9);
					material.shininess.should.be(200);
					material.color.should.equal(createColor(1, 1, 1));
				});
			});
			describe("lighting", {
				var position:Tuple;
				var m:Material;
				var eyeView:Tuple;
				var normal:Tuple;
				var light:PointLight;
				var result:Tuple;
				beforeEach(() -> {
					m = createMaterial();
					position = createPoint(0, 0, 0);
				});
				it("should light with eye between light and surface", {
					eyeView = createVector(0, 0, -1);
					normal = createVector(0, 0, -1);
					light = createPointLight(createPoint(0, 0, -10), createColor(1, 1, 1));
					result = lighting(m, light, position, eyeView, normal);
					result.should.equal(createColor(1.9, 1.9, 1.9));
				});
				it("should light with eye between light and surface, eye offset 45 degree", {
					eyeView = createVector(0, Math.sqrt(2) / 2, -Math.sqrt(2) / 2);
					normal = createVector(0, 0, -1);
					light = createPointLight(createPoint(0, 0, -10), createColor(1, 1, 1));
					result = lighting(m, light, position, eyeView, normal);
					result.should.equal(createColor(1, 1, 1));
				});
				it("should light with eye opposite the surface, eye offset 45 degree", {
					eyeView = createVector(0, 0, -1);
					normal = createVector(0, 0, -1);
					light = createPointLight(createPoint(0, 10, -10), createColor(1, 1, 1));
					result = lighting(m, light, position, eyeView, normal);
					result.roundTo(4).should.equal(createColor(0.7364, 0.7364, 0.7364));
				});
				it("should light with eye in path of reflection vector", {
					eyeView = createVector(0, -Math.sqrt(2) / 2, -Math.sqrt(2) / 2);
					normal = createVector(0, 0, -1);
					light = createPointLight(createPoint(0, 10, -10), createColor(1, 1, 1));
					result = lighting(m, light, position, eyeView, normal);
					result.roundTo(4).should.equal(createColor(1.6364, 1.6364, 1.6364));
				});
				it("should light with light behind the surface", {
					eyeView = createVector(0, 0, -1);
					normal = createVector(0, 0, -1);
					light = createPointLight(createPoint(0, 0, 10), createColor(1, 1, 1));
					result = lighting(m, light, position, eyeView, normal);
					result.should.equal(createColor(0.1, 0.1, 0.1));
				});
			});
		});
	}
}
