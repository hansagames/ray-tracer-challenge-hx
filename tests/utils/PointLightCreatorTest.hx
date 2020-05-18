package utils;

import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createColor;
import utils.PointLightCreator.createPointLight;

class PointLightCreatorTest extends BuddySuite {
	public function new() {
		describe("PointLightCreatorTest", {
			describe("createPointLight", {
				it("should create point light", {
					final position = createPoint(0, 0, 0);
					final intensity = createColor(1, 1, 1);
					final pointLight = createPointLight(position, intensity);
					pointLight.position.should.equal(position);
					pointLight.intensity.should.equal(intensity);
				});
			});
		});
	}
}
