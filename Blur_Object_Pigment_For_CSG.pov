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
#include "Gaussian_Blur.inc"

global_settings {
    assumed_gamma 1.0
    ambient_light color White
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare S = 2;
#declare R1 = S*0.24;
#declare R2 = S*0.20;

#declare TheObject =
    difference {
        box { -S*<1, 1, 1>/2, +S*<1, 1, 1>/2 }
        cylinder { -S*x, +S*x, R1 }
        cylinder { -S*y, +S*y, R1 }
        cylinder { -S*z, +S*z, R1 }
        cylinder { <0, 0, 0>, S*<-1, -1, -1>, R2 }
        cylinder { <0, 0, 0>, S*<+1, -1, -1>, R2 }
        cylinder { <0, 0, 0>, S*<+1, +1, -1>, R2 }
        cylinder { <0, 0, 0>, S*<-1, +1, -1>, R2 }
        cylinder { <0, 0, 0>, S*<-1, -1, +1>, R2 }
        cylinder { <0, 0, 0>, S*<+1, -1, +1>, R2 }
        cylinder { <0, 0, 0>, S*<+1, +1, +1>, R2 }
        cylinder { <0, 0, 0>, S*<-1, +1, +1>, R2 }
    } 

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare StepSize = S/100;
#declare NoOfSteps = 12;

object {
    TheObject
    BlurObjectPigmentDirXYZ(TheObject, StepSize, NoOfSteps)
    translate <+0.8,  0.0, +2.5>
}

#declare BlurredObjectPigmentDirXYZ_Fn =
    BlurObjectPigmentDirXYZ_Function(
        TheObject,
        StepSize,
        NoOfSteps
    )
;

object {
    TheObject
    pigment {
        function { BlurredObjectPigmentDirXYZ_Fn(x, y, z).gray }
        color_map {
            [ 0.3 color rgb <1.0, 0.5, 0.0> ]
            [ 0.6 color rgb <0.0, 0.5, 1.0> ]
        }
    }
    translate <+0.4,  0.0, -2.5>
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

light_source {
    100*<-2, 1, -3>
    color White
    shadowless
}

camera {
    location 2*<+3.0, +2.0, -4.0>
    look_at < 0.0, -0.6,  0.0>
    angle 40
}

background { color <1, 1, 4>/40 }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

