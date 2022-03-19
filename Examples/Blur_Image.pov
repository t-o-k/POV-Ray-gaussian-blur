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

default {
    texture {
        pigment { color White }
        finish {
            diffuse 0
            emission color White
        }
    }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare Width = 800; // pixels
#declare Height = 600; // pixels

#declare ImagePigment =
    pigment {
        image_map {
            png "SmallBoat_800x600.png"
            // gamma 2.2
            interpolate 2
            once
        }
        scale <Width, Height, 1>
    }

#declare StepSize = 1.0; // pixels
#declare NoOfSteps = 19;

#declare BlurredImagePigment =
    BlurPigmentDirXY(
        ImagePigment,
        StepSize,
        NoOfSteps
    )

box {
    <0, 0, 0>, <Width, Height, 1>
    pigment { BlurredImagePigment }
    // pigment { ImagePigment }
    scale <image_width/Width, image_height/Height, 1>
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

camera {
    orthographic
    location <image_width/2, image_height/2, -1>
    right image_width*x
    up image_height*y
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

