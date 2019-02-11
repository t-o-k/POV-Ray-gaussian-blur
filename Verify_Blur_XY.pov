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

#declare Box_XY = box { -StepSize*<N, N, 1>/2, +StepSize*<N, N, 1>/2 }

#declare Square_XY =
    union {
        triangle { <-N, -N,  0>, <+N, -N,  0>, <+N, +N,  0> }
        triangle { <+N, +N,  0>, <-N, +N,  0>, <-N, -N,  0> }
        scale StepSize*<1, 1, 1>
    }
#declare Rectangle_XZ =
    union {
        triangle { <-N,  0, -1>, <+N,  0, -1>, <+N,  0, +1> }
        triangle { <+N,  0, +1>, <-N,  0, +1>, <-N,  0, -1> }
        scale StepSize*<1, 1, 1>
    }
#declare Rectangle_YZ =
    union {
        triangle { < 0, -N, -1>, < 0, -N, +1>, < 0, +N, +1> }
        triangle { < 0, +N, +1>, < 0, +N, -1>, < 0, -N, -1> }
        scale StepSize*<1, 1, 1>
    }

union {
    object { Square_XY }
    object { Rectangle_XZ }
    object { Rectangle_YZ }
    BlurObjectPigmentDirXY(Box_XY, StepSize, N)
}

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#declare R = 0.15;
#declare H = 0.5;

sphere {
    <0, 0, 0>, 4*R
    pigment { color Black }
}

union {
    cylinder { StepSize*<-N,  0, -H>, StepSize*<+N,  0, -H>, R }
    cylinder { StepSize*<-N,  0, +H>, StepSize*<+N,  0, +H>, R }
    #for (J, 0, 2*N-1)
        #declare B = J - N + 0.5;
        cylinder { StepSize*<-N,  B,  0>, StepSize*<+N,  B,  0>, R }
    #end // for
    pigment { color Red/2 }
}
union {
    cylinder { StepSize*< 0, -N, -H>, StepSize*< 0, +N, -H>, R }
    cylinder { StepSize*< 0, -N, +H>, StepSize*< 0, +N, +H>, R }
    #for (J, 0, 2*N-1)
        #declare B = J - N + 0.5;
        cylinder { StepSize*< B, -N,  0>, StepSize*< B, +N,  0>, R }
    #end // for
    pigment { color Green/2 }
}
union {
    #for (K, 0, 2*N-1)
        #declare C = K - N + 0.5;
        cylinder { StepSize*< 0,  C, -1>, StepSize*< 0,  C, +1>, R }
    #end // for
    #for (I, 0, 2*N-1)
        #declare A = I - N + 0.5;
        cylinder { StepSize*< A,  0, -1>, StepSize*< A,  0, +1>, R }
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

