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
#declare NoOfSteps = 30;

#declare ImagePigmentFn = function { pigment { ImagePigment } };

#declare BlurredGyFn =
    BlurDirXY_Function(
        function { ImagePigmentFn(x, y, z).gray },
        StepSize,
        NoOfSteps
    )
;

#declare BlurredImagePigmentGy =
    pigment {
        function { BlurredGyFn(x, y, z) }
        color_map {
            [ 0.0 Black ]
            [ 1.0 White ]
        }
    }

#declare SelectRectangleFn =
    function {
        1
        *select(x - 0.596*Width, 0, 1)
        *select(x - 0.870*Width, 1, 0)
        *select(y - 0.166*Height, 0, 1)
        *select(y - 0.590*Height, 1, 0)
    }
;

box {
    <0, 0, 0>, <Width, Height, 1>
    texture {
        function { SelectRectangleFn(x, y, z) }
        texture_map {
            [ 0.0 ImagePigment ]
            [ 1.0 BlurredImagePigmentGy ]
            // [ 1.0 pigment { color Yellow } ]
        }
    }
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

