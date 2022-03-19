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

#declare Text =
    text {
        ttf "timrom.ttf" "POV-Ray" 0.2, 0
        translate <-1.9, -0.1, 0.0>
        scale 60*<1, 1, 1>
    }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare StepSize = 0.2;
#declare NoOfSteps = 16;

#declare BlurredObjectPigment =
    BlurObjectPigmentDirXYZ(
        Text,
        StepSize,
        NoOfSteps
    )

object {
    Text
    pigment {
        pigment_pattern { BlurredObjectPigment }
        pigment_map {
            [ 0.40 color rgb <1.0, 0.0, 0.5> ]
            [ 0.50 color rgb <0.0, 0.5, 1.0> ]
        }
    }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

light_source {
    100*<1, 3, -10>
    color White
}

camera {
    location -60*z
    look_at 0*y
    angle 130
}

background { color rgb <1, 2, 3>/60 }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

