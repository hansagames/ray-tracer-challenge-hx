package utils;

import types.Group;
import types.Tuple;
import types.Shape;
import utils.TuplesCreator.createPoint;
import utils.TuplesCreator.createVector;
import utils.GroupCreator.createGroup;
import utils.TriangleCreator.createTriangle;
import utils.TriangleCreator.createSmoothTriangle;

typedef ParsedData =  {
    final vertices: Array<Tuple>;
    final normals: Array<Tuple>;
    final defaultGroup: Group;
    final groups: Map<String, Group>;
}
class Obj {
    public static function parse(source: String): ParsedData {
        final lines = source.split("\n");
        final vertices: Array<Tuple> = [];
        final group = createGroup();
        final groups: Map<String, Group> = new Map();
        final normals: Array<Tuple> = [];
        var currentGroup = group;
        for (line in lines) {
            if (line.indexOf("v ") == 0) {
                if (vertices.length == 0) {
                    vertices.push(createPoint(0, 0, 0));
                }
                vertices.push(parseVertice(line.substr(2)));
            } else if (line.indexOf("g ") == 0) {
                final g = createGroup();
                currentGroup = g;
                groups.set(line.substr(2), g);
            } else if (line.indexOf("f ") == 0) {
                addFace(line.substr(2), vertices, normals, currentGroup);
            } else if (line.indexOf("vn ") == 0) {
                if (normals.length == 0) {
                    normals.push(createVector(0, 0, 0));
                }
                normals.push(parseNormalVector(line.substr(3)));
            }
        }
        return {
            vertices: vertices,
            defaultGroup: group,
            groups: groups,
            normals: normals
        };
    }
    private static function parseVertice(line: String): Tuple {
        final values = line.split(" ");
        return createPoint(Std.parseFloat(values[0]), Std.parseFloat(values[1]), Std.parseFloat(values[2]));
    }
    private static function addFace(line: String, vertices: Array<Tuple>, normals: Array<Tuple>, parent: Group): Void {
        final values = line.split(" ");
        final vert: Array<Tuple> = [vertices[0]];
        final norm: Array<Tuple> = [];
        for (v in values) {
            if (v.indexOf("/") >= 0) {
                if (norm.length == 0) {
                    norm.push(normals[0]);
                }
                final normalValues = v.split("/");
                vert.push(vertices[Std.parseInt(normalValues[0])]);
                if (normalValues.length > 2) {
                    norm.push(normals[Std.parseInt(normalValues[2])]);
                }
            } else {
                vert.push(vertices[Std.parseInt(v)]);
            }
        }
        if (norm.length > 1) {
            for (t in fanTriangulationSmooth(vert, norm)) {
                parent.addChild(t);
            }
        } else {
            for (t in fanTriangulation(vert)) {
                parent.addChild(t);
            }
        }
        
    }
    private static function fanTriangulation(vertices: Array<Tuple>): Array<Shape> {
        final triangles: Array<Shape> = [];
        for (i in 2...vertices.length - 1) {
            triangles.push(createTriangle(
                vertices[1],
                vertices[i],
                vertices[i + 1]
            ));
        }
        return triangles;
    }
    private static function fanTriangulationSmooth(vertices: Array<Tuple>, normals: Array<Tuple>): Array<Shape> {
        final triangles: Array<Shape> = [];
        for (i in 2...vertices.length - 1) {
            triangles.push(createSmoothTriangle(
                vertices[1],
                vertices[i],
                vertices[i + 1],
                normals[1],
                normals[i],
                normals[i + 1]
            ));
        }
        return triangles;
    }
    private static function parseNormalVector(line: String): Tuple {
        final values = line.split(" ");
        return createVector(Std.parseFloat(values[0]), Std.parseFloat(values[1]), Std.parseFloat(values[2]));
    }
}