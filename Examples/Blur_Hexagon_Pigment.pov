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
    ambient_light color White
}

default {
    texture {
        pigment { color Black }
        finish {
            ambient color White
            diffuse 0
        }
    }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare HexagonPigment =
    pigment {
        hexagon
            color rgb < 4,  2, 12>/100
            color rgb < 0,  0,  0>/100
            color rgb <42, 36, 16>/100
    }

#declare StepSize = 0.02;
#declare NoOfSteps = 60;

#declare HexagonPigment1 =
    BlurPigmentDirX(
        pigment {
            HexagonPigment
            rotate -60*y
        },
        StepSize,
        NoOfSteps
    )
#declare HexagonPigment2 =
    BlurPigmentDirX(
        HexagonPigment,
        StepSize,
        NoOfSteps
    )
#declare HexagonPigment3 =
    BlurPigmentDirX(
        pigment {
            HexagonPigment
            rotate +60*y
        },
        StepSize,
        NoOfSteps
    )

plane {
    y, 1
    pigment {
        average
        pigment_map {
            [ 1 HexagonPigment1 rotate +60*y ]
            [ 1 HexagonPigment2 ]
            [ 1 HexagonPigment3 rotate -60*y ]
        }
    }
    rotate -35*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

camera {
    location 4*<0, 1, -1>
    look_at <0, 0, 0>
    // angle 150
}

background { color rgb <1, 2, 3>/60 }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

