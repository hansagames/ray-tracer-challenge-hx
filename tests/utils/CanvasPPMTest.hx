package utils;

import utils.CanvasCreator.createCanvas;
import utils.TuplesCreator.createColor;

using utils.CanvasPPM;
using utils.Lines;

class CanvasPPMTest extends BuddySuite {
	public function new() {
		describe("CanvasPPMTest", {
			it("should have ppm header", {
				var width = 5;
				var height = 3;
				var canvas = createCanvas(width, height);
				var ppm = canvas.toPPM();
				ppm.readLine(1).should.be("P3");
				ppm.readLine(2).should.be('${width} ${height}');
				ppm.readLine(3).should.be("255");
			});
			it("should write pixel data", {
				var width = 5;
				var height = 3;
				var canvas = createCanvas(width, height);
				var c1 = createColor(1.5, 0, 0);
				var c2 = createColor(0, 0.5, 0);
				var c3 = createColor(-0.5, 0, 1);

				canvas.writePixel(0, 0, c1);
				canvas.writePixel(2, 1, c2);
				canvas.writePixel(4, 2, c3);
				var ppm = canvas.toPPM();
				ppm.readLine(4).should.be('255 0 0 0 0 0 0 0 0 0 0 0 0 0 0');
				ppm.readLine(5).should.be('0 0 0 0 0 0 0 128 0 0 0 0 0 0 0');
				ppm.readLine(6).should.be('0 0 0 0 0 0 0 0 0 0 0 0 0 0 255');
			});
			it("should have max 70 characters per line", {
				var width = 10;
				var height = 2;
				var canvas = createCanvas(width, height);
				canvas.fillPixels(createColor(1, 0.8, 0.6));
				var ppm = canvas.toPPM();
				ppm.readLine(4).should.be('255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204');
				ppm.readLine(5).should.be('153 255 204 153 255 204 153 255 204 153 255 204 153');
				ppm.readLine(6).should.be('255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204');
				ppm.readLine(7).should.be('153 255 204 153 255 204 153 255 204 153 255 204 153');
			});
			it("should have line break at end of file", {
				var width = 5;
				var height = 3;
				var canvas = createCanvas(width, height);
				var ppm = canvas.toPPM();
				var newLineChar = "\n";
				ppm.lastIndexOf(newLineChar).should.be(ppm.length - newLineChar.length);
			});
		});
	}
}
