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
#include "textures.inc"
#include "Gaussian_Blur.inc"

global_settings {
    assumed_gamma 1.0
    max_trace_level 10
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare CheckerPigment =
    pigment {
        checker color blue 1 color green 1 
        turbulence 0.2
        translate -0.5*y
    }

#declare StepSize = 0.02;
#declare NoOfSteps = 30;

#declare BlurredCheckerPigmentFn =
    BlurPigmentDirZX_Function(
        CheckerPigment,
        StepSize,
        NoOfSteps
    )

torus {
    1.4, 0.5
    material { M_Ruby_Glass }
    translate 1.2*y
}

plane {
    y, 0
    texture {
        function { BlurredCheckerPigmentFn(x, y, z).green }
        texture_map {
            [ 0.0 Polished_Chrome ]
            [ 1.0 pigment { color <0.05, 0.10, 0.30> } ]
        }
        
    }
    rotate -25*y
}

plane {
    <0.0, 1, -3.0>, -40
    pigment { color White }
    finish { ambient color Black }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

light_source {
    100*<-20, 20, -30>
    color White
}

camera {
    location 4*<0, 1.5, -2>
    look_at <0, 0, 0>
    angle 40
}

background { color Black }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

