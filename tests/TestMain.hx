package;

import buddy.Buddy;
import utils.TuplesTest;
import utils.TuplesCreatorTest;
import utils.ColorTest;
import utils.CanvasCreatorTest;
import utils.CanvasPPMTest;
import utils.MatrixCreatorTest;
import utils.MatricesTest;
import utils.TransformationTest;
import utils.RayCreatorTest;
import utils.RaysTest;
import utils.IntersectionCreatorTest;
import utils.IntersectionsTest;
import utils.PointLightCreatorTest;
import utils.MaterialsCreatorTest;
import utils.WorldCreatorTest;
import utils.WorldsTest;
import utils.CameraCreatorTest;
import utils.CamerasTest;
import utils.PatternsTest;
import components.CanvasTest;
import types.ShapeTest;
import types.SphereTest;
import types.PlaneTest;
import types.CubeTest;
import types.CylinderTest;
import types.ConeTest;

class TestMain implements Buddy<[
	TuplesCreatorTest, TuplesTest, ColorTest, CanvasCreatorTest, CanvasTest, MatrixCreatorTest, MatricesTest, TransformationTest, RayCreatorTest, RaysTest,
	CanvasPPMTest, IntersectionCreatorTest, IntersectionsTest, PointLightCreatorTest, MaterialsCreatorTest, WorldCreatorTest, WorldsTest, CameraCreatorTest,
	CamerasTest, ShapeTest, SphereTest, PlaneTest, PatternsTest, CubeTest, CylinderTest, ConeTest
]> {}
