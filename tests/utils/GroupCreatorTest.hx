package utils;

import utils.GroupCreator.createGroup;
import utils.MatrixCreator.createIdentityMatrix;

class GroupCreatorTest extends BuddySuite {
	public function new() {
		describe("GroupCreatorTest", {
			it("should create group", {
				var g = createGroup();
				g.transform.should.equal(createIdentityMatrix(4, 4));
			});
		});
	}
}
