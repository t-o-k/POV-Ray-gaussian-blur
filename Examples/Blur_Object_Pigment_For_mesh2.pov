// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
/*

https://github.com/t-o-k/POV-Ray-gaussian-blur

Copyright (c) 2017 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#version 3.7;

#include "colors.inc"
#include "../Gaussian_Blur.inc"

global_settings {
    assumed_gamma 1.0
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare X = 100;
#declare Y = 100;
#declare Z = 100;
#declare pCtr = <X, Y, Z>/2;

#declare Cube =
    mesh2 {
        vertex_vectors {
            8,
            <0, 0, 0> - pCtr,
            <X, 0, 0> - pCtr,
            <X, 0, Z> - pCtr,
            <0, 0, Z> - pCtr,
            <0, Y, 0> - pCtr,
            <X, Y, 0> - pCtr,
            <X, Y, Z> - pCtr,
            <0, Y, Z> - pCtr
        }
        face_indices {
            12,
            <0, 1, 2>,
            <0, 2, 3>,
            <0, 4, 5>,
            <0, 5, 1>,
            <1, 5, 6>,
            <1, 6, 2>,
            <2, 6, 7>,
            <2, 7, 3>,
            <3, 7, 4>,
            <3, 4, 0>,
            <4, 7, 6>,
            <4, 6, 5>
        }
        inside_vector y
    }

#declare CubeWithHoles =
    difference {
        object { Cube }
        object { Cube scale 0.6*<2, 1, 1> }
        object { Cube scale 0.6*<1, 2, 1> }
        object { Cube scale 0.6*<1, 1, 2> }
        rotate +45*y
        rotate degrees(atan2(sqrt(3), sqrt(2)))*x
        rotate -45*y
    }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare StepSize = 1.4;
#declare NoOfSteps = 16;

#declare BlurredObjectPigment =
    BlurObjectPigmentDirXYZ(
        CubeWithHoles,
        StepSize,
        NoOfSteps
    )

object {
    CubeWithHoles
    pigment {
        pigment_pattern { BlurredObjectPigment }
        pigment_map {
            [ 0.10 color rgb <1.0, 1.0, 1.0> ]
            [ 0.40 color rgb <1.0, 0.0, 0.5> ]
            [ 0.46 color rgb <0.0, 0.0, 0.0> ]
            [ 0.50 color rgb <0.0, 1.0, 0.5> ]
        }
    }
    rotate 8*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

light_source {
    100*<1, 3, -10>
    color White
}

camera {
    location 100*<2, 0, -3>
    look_at <0, 0, 0>
    angle 45
}

background { color rgb <1, 2, 3>/60 }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

