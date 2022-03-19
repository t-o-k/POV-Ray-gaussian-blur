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

#declare Box_ZX  = box { -StepSize*<N, 1, N>/2, +StepSize*<N, 1, N>/2 }

#declare Square_ZX =
    union {
        triangle { <-N,  0, -N>, <+N,  0, -N>, <+N,  0, +N> }
        triangle { <+N,  0, +N>, <-N,  0, +N>, <-N,  0, -N> }
        scale StepSize*<1, 1, 1>
    }
#declare Rectangle_XY =
    union {
        triangle { <-N, -1,  0>, <+N, -1,  0>, <+N, +1,  0> }
        triangle { <+N, +1,  0>, <-N, +1,  0>, <-N, -1,  0> }
        scale StepSize*<1, 1, 1>
    }
#declare Rectangle_ZY =
    union {
        triangle { < 0, -1, -N>, < 0, +1, -N>, < 0, +1, +N> }
        triangle { < 0, +1, +N>, < 0, -1, +N>, < 0, -1, -N> }
        scale StepSize*<1, 1, 1>
    }

union {
    object { Square_ZX }
    object { Rectangle_ZY }
    object { Rectangle_XY }
    BlurObjectPigmentDirZX(Box_ZX, StepSize, N)
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare R = 0.15;
#declare H = 0.5;

sphere {
    <0, 0, 0>, 4*R
    pigment { color Black }
}

union {
    cylinder { StepSize*<-N, -H,  0>, StepSize*<+N, -H,  0>, R }
    cylinder { StepSize*<-N, +H,  0>, StepSize*<+N, +H,  0>, R }
    #for (I, 0, 2*N-1)
        #declare A = I - N + 0.5;
        cylinder { StepSize*<-N,  0,  A>, StepSize*<+N,  0,  A>, R }
    #end // for
    pigment { color Red/2 }
}
union {
    #for (J, 0, 2*N-1)
        #declare B = J - N + 0.5;
        cylinder { StepSize*< B, -1,  0>, StepSize*< B, +1,  0>, R }
    #end // for
    #for (K, 0, 2*N-1)
        #declare C = K - N + 0.5;
        cylinder { StepSize*< 0, -1,  C>, StepSize*< 0, +1,  C>, R }
    #end // for
    pigment { color Green/2 }
}
union {
    cylinder { StepSize*< 0, -H, -N>, StepSize*< 0, -H, +N>, R }
    cylinder { StepSize*< 0, +H, -N>, StepSize*< 0, +H, +N>, R }
    #for (I, 0, 2*N-1)
        #declare A = I - N + 0.5;
        cylinder { StepSize*< A,  0, -N>, StepSize*< A,  0, +N>, R }
    #end // for
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

