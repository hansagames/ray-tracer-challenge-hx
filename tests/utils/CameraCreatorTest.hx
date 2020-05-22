package utils;

import utils.CameraCreator.createCamera;
import utils.MatrixCreator.createIdentityMatrix;

using utils.Numbers;

class CameraCreatorTest extends BuddySuite {
	public function new() {
		describe("CameraCreatorTest", {
			describe("createCamera", {
				it("shoulc create camera", {
					final hSize = 160;
					final vSize = 120;
					final fov = Math.PI * 0.5;
					final c = createCamera(hSize, vSize, fov);
					c.fov.should.be(fov);
					c.hSize.should.be(hSize);
					c.vSize.should.be(vSize);
					c.transform.should.equal(createIdentityMatrix(4, 4));
				});
				it("should calculate pixel size for horizontal canvas", {
					final c = createCamera(200, 125, Math.PI * 0.5);
					c.pixelSize.roundTo(2).should.be(0.01);
				});
				it("should calculate pixel size for vertical canvas", {
					final c = createCamera(125, 200, Math.PI * 0.5);
					c.pixelSize.roundTo(2).should.be(0.01);
				});
			});
		});
	}
}
