package utils;

import utils.WorldCreator.createWorld;
import utils.WorldCreator.createDefaultWorld;

class WorldCreatorTest extends BuddySuite {
	public function new() {
		describe("WorldCreatorTest", {
			describe("createWorld", {
				it("should create world", {
					final w = createWorld();
					w.lightCount.should.be(0);
					w.meshCount.should.be(0);
				});
			});
			describe("createDefaultWorld", {
				it("should create default world", {
					final w = createDefaultWorld();
					w.lightCount.should.be(1);
					w.meshCount.should.be(2);
				});
			});
		});
	}
}
