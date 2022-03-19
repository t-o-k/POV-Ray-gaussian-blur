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

#declare CylinderWithHole =
    union {
        difference {
            cylinder { -1.5*x, +1.5*x, 0.95 }
            cylinder { -1.6*x, +1.6*x, 0.5 }
        }
    }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare StepSize = 0.004;
#declare NoOfSteps = 100;

#declare BlurredObjectPigment =
    BlurObjectPigmentDirYZ(
        CylinderWithHole,
        StepSize,
        NoOfSteps
    )

object {
    sphere {
        <0, 0, 0>, 1
        scale <1.6, 1.0, 1.2>
    }
    pigment {
        pigment_pattern { BlurredObjectPigment }
        pigment_map {
            [ 0.00 color rgb <1.0, 1.0, 1.0> ]
            [ 0.40 color rgb <1.0, 0.0, 0.5> ]
            [ 0.46 color rgb <0.0, 0.0, 0.0> ]
            [ 0.50 color rgb <0.2, 0.0, 0.3> ]
            [ 1.00 color rgb <1.0, 1.0, 0.0> ]
        }
    }
    rotate 110*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

light_source {
    100*<1, 3, -10>
    color White
}

camera {
    location <2, 3, -3>*2
    look_at <0, 0, 0>
    angle 30
}

background { color rgb <0.005, 0.00, 0.02> }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

