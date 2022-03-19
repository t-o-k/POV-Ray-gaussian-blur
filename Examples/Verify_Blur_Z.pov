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
        pigment { color White }
        finish {
            ambient color White
            diffuse 0
        }
    }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare StepSize = 10;
#declare N = 9; // Number of steps

#declare Box_Z = box { -StepSize*<1, 1, N>/2, +StepSize*<1, 1, N>/2 }

#declare Rectangle_ZX =
    union {
        triangle { <-1,  0, -N>, <+1,  0, -N>, <+1,  0, +N> }
        triangle { <+1,  0, +N>, <-1,  0, +N>, <-1,  0, -N> }
        scale StepSize*<1, 1, 1>
    }
#declare Rectangle_ZY =
    union {
        triangle { < 0, -1, -N>, < 0, +1, -N>, < 0, +1, +N> }
        triangle { < 0, +1, +N>, < 0, -1, +N>, < 0, -1, -N> }
        scale StepSize*<1, 1, 1>
    }

union {
    object { Rectangle_ZX }
    object { Rectangle_ZY }
    BlurObjectPigmentDirZ(Box_Z, StepSize, N)
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare R = 0.15;
#declare H = 0.5;

sphere {
    <0, 0, 0>, 4*R
    pigment { color Black }
}

union {
    #for (I, 0, 2*N-1)
        #declare A = I - N + 0.5;
        cylinder { StepSize*<-1,  0,  A>, StepSize*<+1,  0,  A>, R }
    #end // for
    pigment { color Red/2 }
}
union {
    #for (K, 0, 2*N-1)
        #declare C = K - N + 0.5;
        cylinder { StepSize*< 0, -1,  C>, StepSize*< 0, +1,  C>, R }
    #end // for
    pigment { color Green/2 }
}
union {
    cylinder { StepSize*< 0, -H, -N>, StepSize*< 0, -H, +N>, R }
    cylinder { StepSize*< 0, +H, -N>, StepSize*< 0, +H, +N>, R }
    cylinder { StepSize*<-H,  0, -N>, StepSize*<-H,  0, +N>, R }
    cylinder { StepSize*<+H,  0, -N>, StepSize*<+H,  0, +N>, R }
    pigment { color Blue/2 }
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

camera {
    location 80*<6, 3, 4>
    look_at <0, -6, 0>
    right image_width/image_height*x
    up y
    angle 30
}

background { color rgb <1, 2, 3>/60 }

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

