package utils;

import types.SmoothTriangle;
import types.Triangle;
import utils.Obj.parse;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;

class ObjTest extends BuddySuite {
	public function new() {
		describe("ObjTest", {
			describe("parse", {
				it("should ignore invalid lines", {
                    final data = parse("bla bla");
                    data.vertices.length.should.be(0);
                });
                it("should parse vertices", {
                    final source = '
v -1 1 0
v -1.0000 0.5000 0.0000
v 1 0 0
v 1 1 0
';
                    final data = parse(source);
                    data.vertices.length.should.be(5);
                    data.vertices[1].should.equal(createPoint(-1, 1, 0));
                    data.vertices[2].should.equal(createPoint(-1, 0.5, 0));
                    data.vertices[3].should.equal(createPoint(1, 0, 0));
                    data.vertices[4].should.equal(createPoint(1, 1, 0));
                });
                it("should parse triangle faces", {
                    final source = '
v -1 1 0
v -1 0 0
v 1 0 0
v 1 1 0

f 1 2 3
f 1 2 4
';
                    final data = parse(source);
                    final g = data.defaultGroup;
                    final t1: Triangle = cast(g.children[0], Triangle);
                    final t2: Triangle = cast(g.children[1], Triangle);

                    t1.p1.should.equal(data.vertices[1]);
                    t1.p2.should.equal(data.vertices[2]);
                    t1.p3.should.equal(data.vertices[3]);
                    t2.p1.should.equal(data.vertices[1]);
                    t2.p2.should.equal(data.vertices[2]);
                    t2.p3.should.equal(data.vertices[4]);
                });
                it("should triangulate polygons", {
                    final source = '
v -1 1 0
v -1 0 0
v 1 0 0
v 1 1 0
v 0 2 0

f 1 2 3 4 5
';
                    final data = parse(source);
                    final g = data.defaultGroup;
                    final t1: Triangle = cast(g.children[0], Triangle);
                    final t2: Triangle = cast(g.children[1], Triangle);
                    final t3: Triangle = cast(g.children[2], Triangle);

                    t1.p1.should.equal(data.vertices[1]);
                    t1.p2.should.equal(data.vertices[2]);
                    t1.p3.should.equal(data.vertices[3]);

                    t2.p1.should.equal(data.vertices[1]);
                    t2.p2.should.equal(data.vertices[3]);
                    t2.p3.should.equal(data.vertices[4]);

                    t3.p1.should.equal(data.vertices[1]);
                    t3.p2.should.equal(data.vertices[4]);
                    t3.p3.should.equal(data.vertices[5]);
                });
                it("should parse groups", {
                    final source = '
v -1 1 0
v -1 0 0
v 1 0 0
v 1 1 0
g FirstGroup
f 1 2 3
g SecondGroup
f 1 2 4
';
                    final data = parse(source);
                    final g1 = data.groups.get("FirstGroup");
                    final g2 = data.groups.get("SecondGroup");
                    final t1: Triangle = cast(g1.children[0], Triangle);
                    final t2: Triangle = cast(g2.children[0], Triangle);

                    t1.p1.should.equal(data.vertices[1]);
                    t1.p2.should.equal(data.vertices[2]);
                    t1.p3.should.equal(data.vertices[3]);

                    t2.p1.should.equal(data.vertices[1]);
                    t2.p2.should.equal(data.vertices[2]);
                    t2.p3.should.equal(data.vertices[4]);
                });
                it("should parse normal vectors", {
                    final source = '
vn 0 0 1
vn 0.707 0 -0.707
vn 1 2 3
';
                    final data = parse(source);
                    data.normals[1].should.equal(createVector(0, 0, 1));
                    data.normals[2].should.equal(createVector(0.707, 0, -0.707));
                    data.normals[3].should.equal(createVector(1, 2, 3));
                });
                it("should parse faces with normals", {
                    final source = '
v 0 1 0
v -1 0 0
v 1 0 0                    
vn -1 0 0
vn 1 0 0
vn 0 1 0
f 1//3 2//1 3//2
f 1/0/3 2/102/1 3/14/2
';
                    final data = parse(source);
                    final g = data.defaultGroup;
                    final t1: SmoothTriangle = cast(g.children[0], SmoothTriangle);
                    final t2: SmoothTriangle = cast(g.children[1], SmoothTriangle);
                    t1.p1.should.equal(data.vertices[1]);
                    t1.p2.should.equal(data.vertices[2]);
                    t1.p3.should.equal(data.vertices[3]);
                    t1.n1.should.equal(data.normals[3]);
                    t1.n2.should.equal(data.normals[1]);
                    t1.n3.should.equal(data.normals[2]);
                });
			});
		});
	}
}
