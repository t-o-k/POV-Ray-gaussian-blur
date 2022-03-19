// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
/*

https://github.com/t-o-k/POV-Ray-gaussian-blur

Copyright (c) 2017-2022 Tor Olav Kristensen, http://subcube.com

Use of this source code is governed by the GNU Lesser General Public License version 3,
which can be found in the LICENSE file.

Relevant Wikipedia articles:
https://en.wikipedia.org/wiki/Gaussian_filter
https://en.wikipedia.org/wiki/Gaussian_blur
https://en.wikipedia.org/wiki/Separable_filter
https://en.wikipedia.org/wiki/Error_function#Approximation_with_elementary_functions

*/
// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#version 3.7;

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#macro IntegrateFunction(Fn, N)

    function(s0, s1) {
        sum(i, 0, N-1, (Fn(s0 + (i + 0.5)*(s1 - s0)/N)))*(s1 - s0)/N
    }

#end // macro IntegrateFunction


#macro Sigma(NoOfSteps)

    #local S = (NoOfSteps + 0.5)/6;

    S

#end // macro Sigma


#declare GaussianFn =
    function(r, stddev) {
        exp(-pow(r/stddev, 2)/2)/sqrt(2*pi)/stddev
    }
;


#macro GaussianFunction(StdDev)

    function(r) { GaussianFn(r, StdDev) }

#end // macro GaussianFunction


/*
#macro IntegrateGaussianFunction(StdDev, NoOfSteps)

    IntegrateFunction(GaussianFunction(StdDev), NoOfSteps)

#end // macro IntegrateGaussianFunction
*/


#declare ErrorFn =
    function(s) {
        1 -
        pow(
            1.0000000000 + select(s, -s, s)*
            (
                0.0705230784 + select(s, -s, s)*
                (
                    0.0422820123 + select(s, -s, s)*
                    (
                        0.0092705272 + select(s, -s, s)*
                        (
                            0.0001520143 + select(s, -s, s)*
                            (
                                0.0002765672 + select(s, -s, s)*
                                (
                                    0.0000430638
                                )
                            )
                        )
                    )
                )
            ), -16
        )
    }
;

#declare GaussianIntegralFn =
    function(r0, r1, stddev) {
        0
        +select(r0, +0.5, -0.5)*ErrorFn(r0/sqrt(2)/stddev)
        +select(r1, -0.5, +0.5)*ErrorFn(r1/sqrt(2)/stddev)
    }
;


#macro GaussianIntegralFunction(StdDev)

    function(r0, r1) {
        GaussianIntegralFn(r0, r1, StdDev)
    }

#end // macro GaussianIntegralFunction

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#macro ObjectPigment(Object)

    pigment {
        object {
            Object
            color rgb <0, 0, 0> // Outside
            color rgb <1, 1, 1> // Inside
        }
    }

#end // macro ObjectPigment


#macro ObjectPigment_Function(Object)

    function { ObjectPigment(Object) }

#end // macro ObjectPigment_Function

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#macro FunctionsPigmentRGB(RdFn, GnFn, BuFn)

    pigment {
        average
        pigment_map {
            [
                function { RdFn(x, y, z) }
                color_map {
                    [ 0 red 0 ]
                    [ 1 red 3 ]
                }
            ]
            [
                function { GnFn(x, y, z) }
                color_map {
                    [ 0 green 0 ]
                    [ 1 green 3 ]
                }
            ]
            [
                function { BuFn(x, y, z) }
                color_map {
                    [ 0 blue 0 ]
                    [ 1 blue 3 ]
                }
            ]
        }
    }

#end // macro FunctionsPigmentRGB


#macro FunctionsPigmentRGBF(RdFn, GnFn, BuFn, FiFn)

    pigment {
        average
        pigment_map {
            [
                function { RdFn(x, y, z) }
                color_map {
                    [ 0 red 0 ]
                    [ 1 red 4 ]
                }
            ]
            [
                function { GnFn(x, y, z) }
                color_map {
                    [ 0 green 0 ]
                    [ 1 green 4 ]
                }
            ]
            [
                function { BuFn(x, y, z) }
                color_map {
                    [ 0 blue 0 ]
                    [ 1 blue 4 ]
                }
            ]
            [
                function { FiFn(x, y, z) }
                color_map {
                    [ 0 filter 0 ]
                    [ 1 filter 4 ]
                }
            ]
        }
    }

#end // macro FunctionsPigmentRGBF


#macro FunctionsPigmentRGBT(RdFn, GnFn, BuFn, TrFn)

    pigment {
        average
        pigment_map {
            [
                function { RdFn(x, y, z) }
                color_map {
                    [ 0 red 0 ]
                    [ 1 red 4 ]
                }
            ]
            [
                function { GnFn(x, y, z) }
                color_map {
                    [ 0 green 0 ]
                    [ 1 green 4 ]
                }
            ]
            [
                function { BuFn(x, y, z) }
                color_map {
                    [ 0 blue 0 ]
                    [ 1 blue 4 ]
                }
            ]
            [
                function { TrFn(x, y, z) }
                color_map {
                    [ 0 transmit 0 ]
                    [ 1 transmit 4 ]
                }
            ]
        }
    }

#end // macro FunctionsPigmentRGBT


#macro FunctionsPigmentRGBFT(RdFn, GnFn, BuFn, FiFn, TrFn)

    pigment {
        average
        pigment_map {
            [
                function { RdFn(x, y, z) }
                color_map {
                    [ 0 red 0 ]
                    [ 1 red 5 ]
                }
            ]
            [
                function { GnFn(x, y, z) }
                color_map {
                    [ 0 green 0 ]
                    [ 1 green 5 ]
                }
            ]
            [
                function { BuFn(x, y, z) }
                color_map {
                    [ 0 blue 0 ]
                    [ 1 blue 5 ]
                }
            ]
            [
                function { FiFn(x, y, z) }
                color_map {
                    [ 0 filter 0 ]
                    [ 1 filter 5 ]
                }
            ]
            [
                function { TrFn(x, y, z) }
                color_map {
                    [ 0 transmit 0 ]
                    [ 1 transmit 5 ]
                }
            ]
        }
    }

#end // macro FunctionsPigmentRGBFT


#macro PigmentRGB(PigmentFn)

    pigment {
        average
        pigment_map {
            [
                function { PigmentFn(x, y, z).red }
                color_map {
                    [ 0 red 0 ]
                    [ 1 red 3 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).green }
                color_map {
                    [ 0 green 0 ]
                    [ 1 green 3 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).blue }
                color_map {
                    [ 0 blue 0 ]
                    [ 1 blue 3 ]
                }
            ]
        }
    }

#end // macro PigmentRGB


#macro PigmentRGBF(PigmentFn)

    pigment {
        average
        pigment_map {
            [
                function { PigmentFn(x, y, z).red }
                color_map {
                    [ 0 red 0 ]
                    [ 1 red 4 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).green }
                color_map {
                    [ 0 green 0 ]
                    [ 1 green 4 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).blue }
                color_map {
                    [ 0 blue 0 ]
                    [ 1 blue 4 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).filter }
                color_map {
                    [ 0 filter 0 ]
                    [ 1 filter 4 ]
                }
            ]
        }
    }

#end // macro PigmentRGBF


#macro PigmentRGBT(PigmentFn)

    pigment {
        average
        pigment_map {
            [
                function { PigmentFn(x, y, z).red }
                color_map {
                    [ 0 red 0 ]
                    [ 1 red 4 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).green }
                color_map {
                    [ 0 green 0 ]
                    [ 1 green 4 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).blue }
                color_map {
                    [ 0 blue 0 ]
                    [ 1 blue 4 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).transmit }
                color_map {
                    [ 0 transmit 0 ]
                    [ 1 transmit 4 ]
                }
            ]
        }
    }

#end // macro PigmentRGBT


#macro PigmentRGBFT(PigmentFn)

    pigment {
        average
        pigment_map {
            [
                function { PigmentFn(x, y, z).red }
                color_map {
                    [ 0 red 0 ]
                    [ 1 red 5 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).green }
                color_map {
                    [ 0 green 0 ]
                    [ 1 green 5 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).blue }
                color_map {
                    [ 0 blue 0 ]
                    [ 1 blue 5 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).filter }
                color_map {
                    [ 0 filter 0 ]
                    [ 1 filter 5 ]
                }
            ]
            [
                function { PigmentFn(x, y, z).transmit }
                color_map {
                    [ 0 transmit 0 ]
                    [ 1 transmit 5 ]
                }
            ]
        }
    }

#end // macro PigmentRGBFT

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

/*
// Less accurate
#macro Blur_Function(Fn, StepSize, NoOfSteps, vDirection)

    #local StdDev = Sigma(NoOfSteps);
    #local G__Fn = GaussianFunction(StdDev);
    #local H = (NoOfSteps - 1)/2;
    #local SumG = 1e-6;
    #for (J, 0, NoOfSteps-1)
        #local C = J - H;
        #local SumG = SumG + G__Fn(C);
    #end // for
    #local vDir = StepSize*vDirection;
    #local dX = vDir.x;
    #local dY = vDir.y;
    #local dZ = vDir.z;

    function {
        0
        #for (J, 0, NoOfSteps-1)
            #local C = J - H;
            #local G = G__Fn(C)/SumG;
            +G*Fn(x + C*dX, y + C*dY, z + C*dZ)
        #end // for
    }

#end // macro Blur_Function
*/


#macro Blur_Function(Fn, StepSize, NoOfSteps, vDirection)

    #local StdDev = Sigma(NoOfSteps);
    #local GI__Fn = GaussianIntegralFunction(StdDev);
    #local H = (NoOfSteps - 1)/2;
    #local SumG = 1e-6;
    #for (J, 0, NoOfSteps-1)
        #local C = J - H;
        #local SumG = SumG + GI__Fn(C - 0.5, C + 0.5);
    #end // for
    #local vDir = StepSize*vDirection;
    #local dX = vDir.x;
    #local dY = vDir.y;
    #local dZ = vDir.z;

    function {
        0
        #for (J, 0, NoOfSteps-1)
            #local C = J - H;
            #local G = GI__Fn(C - 0.5, C + 0.5)/SumG;
            +G*Fn(x + C*dX, y + C*dY, z + C*dZ)
        #end // for
    }

#end // macro Blur_Function


#macro BlurDirX_Function(Fn, StepSize, NoOfSteps)

    Blur_Function(Fn, StepSize, NoOfSteps, x)

#end // macro BlurDirX_Function


#macro BlurDirY_Function(Fn, StepSize, NoOfSteps)

    Blur_Function(Fn, StepSize, NoOfSteps, y)

#end // macro BlurDirY_Function


#macro BlurDirZ_Function(Fn, StepSize, NoOfSteps)

    Blur_Function(Fn, StepSize, NoOfSteps, z)

#end // macro BlurDirZ_Function


#macro BlurDirXY_Function(Fn, StepSize, NoOfSteps)

    BlurDirY_Function(
        BlurDirX_Function(
            Fn,
            StepSize,
            NoOfSteps
        ),
        StepSize,
        NoOfSteps
    )

#end // macro BlurDirXY_Function


#macro BlurDirYZ_Function(Fn, StepSize, NoOfSteps)

    BlurDirZ_Function(
        BlurDirY_Function(
            Fn,
            StepSize,
            NoOfSteps
        ),
        StepSize,
        NoOfSteps
    )

#end // macro BlurDirYZ_Function


#macro BlurDirZX_Function(Fn, StepSize, NoOfSteps)

    BlurDirX_Function(
        BlurDirZ_Function(
            Fn,
            StepSize,
            NoOfSteps
        ),
        StepSize,
        NoOfSteps
    )

#end // macro BlurDirZX_Function


#macro BlurDirXYZ_Function(Fn, StepSize, NoOfSteps)

    BlurDirZ_Function(
        BlurDirY_Function(
            BlurDirX_Function(
                Fn,
                StepSize,
                NoOfSteps
            ),
            StepSize,
            NoOfSteps
        ),
        StepSize,
        NoOfSteps
    )

#end // macro BlurDirXYZ_Function

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

/*
// Less accurate
#macro BlurPigment(Pigment, StepSize, NoOfSteps, vDirection)

    #local StdDev = Sigma(NoOfSteps);
    #local G__Fn = GaussianFunction(StdDev);
    #local H = (NoOfSteps - 1)/2;
    #local vDir = StepSize*vDirection;

    #local SumG = 1e-6;
    #for (J, 0, NoOfSteps-1)
        #local C = J - H;
        #local SumG = SumG + G__Fn(C);
    #end // for

    pigment {
        average
        pigment_map {
            #for (J, 0, NoOfSteps-1)
                #local C = J - H;
                #local G = G__Fn(C);
                [ G/SumG Pigment translate C*vDir ]
            #end // for
        }
    }

#end // macro BlurPigment
*/


#macro BlurPigment(Pigment, StepSize, NoOfSteps, vDirection)

    #local StdDev = Sigma(NoOfSteps);
    #local GI__Fn = GaussianIntegralFunction(StdDev);
    #local H = (NoOfSteps - 1)/2;
    #local vDir = StepSize*vDirection;

    #local SumG = 1e-6;
    #for (J, 0, NoOfSteps-1)
        #local C = J - H;
        #local SumG = SumG + GI__Fn(C - 0.5, C + 0.5);
    #end // for

    pigment {
        average
        pigment_map {
            #for (J, 0, NoOfSteps-1)
                #local C = J - H;
                #local G = GI__Fn(C - 0.5, C + 0.5);
                [ G/SumG Pigment translate C*vDir ]
            #end // for
        }
    }

#end // macro BlurPigment


#macro BlurPigmentDirX(Pigment, StepSize, NoOfSteps)

    BlurPigment(Pigment, StepSize, NoOfSteps, x)

#end // macro BlurPigmentDirX


#macro BlurPigmentDirY(Pigment, StepSize, NoOfSteps)

    BlurPigment(Pigment, StepSize, NoOfSteps, y)

#end // macro BlurPigmentDirY


#macro BlurPigmentDirZ(Pigment, StepSize, NoOfSteps)

    BlurPigment(Pigment, StepSize, NoOfSteps, z)

#end // macro BlurPigmentDirZ


#macro BlurPigmentDirXY(Pigment, StepSize, NoOfSteps)

    BlurPigmentDirY(
        BlurPigmentDirX(
            Pigment,
            StepSize,
            NoOfSteps
        ),
        StepSize,
        NoOfSteps
    )

#end // macro BlurPigmentDirXY


#macro BlurPigmentDirYZ(Pigment, StepSize, NoOfSteps)

    BlurPigmentDirZ(
        BlurPigmentDirY(
            Pigment,
            StepSize,
            NoOfSteps
        ),
        StepSize,
        NoOfSteps
    )

#end // macro BlurPigmentDirYZ


#macro BlurPigmentDirZX(Pigment, StepSize, NoOfSteps)

    BlurPigmentDirX(
        BlurPigmentDirZ(
            Pigment,
            StepSize,
            NoOfSteps
        ),
        StepSize,
        NoOfSteps
    )

#end // macro BlurPigmentDirZX


#macro BlurPigmentDirXYZ(Pigment, StepSize, NoOfSteps)

    BlurPigmentDirZ(
        BlurPigmentDirY(
            BlurPigmentDirX(
                Pigment,
                StepSize,
                NoOfSteps
            ),
            StepSize,
            NoOfSteps
        ),
        StepSize,
        NoOfSteps
    )

#end // macro BlurPigmentDirXYZ

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#macro BlurPigment_Function(Pigment, StepSize, NoOfSteps, vDirection)

    function { BlurPigment(Pigment, StepSize, NoOfSteps, vDirection) }

#end // macro BlurPigment_Function


#macro BlurPigmentDirX_Function(Pigment, StepSize, NoOfSteps)

    function { BlurPigmentDirX(Pigment, StepSize, NoOfSteps) }

#end // macro BlurPigmentDirX_Function


#macro BlurPigmentDirY_Function(Pigment, StepSize, NoOfSteps)

    function { BlurPigmentDirY(Pigment, StepSize, NoOfSteps) }

#end // macro BlurPigmentDirY_Function


#macro BlurPigmentDirZ_Function(Pigment, StepSize, NoOfSteps)

    function { BlurPigmentDirZ(Pigment, StepSize, NoOfSteps) }

#end // macro BlurPigmentDirZ_Function


#macro BlurPigmentDirXY_Function(Pigment, StepSize, NoOfSteps)

    function { BlurPigmentDirXY(Pigment, StepSize, NoOfSteps) }

#end // macro BlurPigmentDirXY_Function


#macro BlurPigmentDirZX_Function(Pigment, StepSize, NoOfSteps)

    function { BlurPigmentDirZX(Pigment, StepSize, NoOfSteps) }

#end // macro BlurPigmentDirZX_Function


#macro BlurPigmentDirYZ_Function(Pigment, StepSize, NoOfSteps)

    function { BlurPigmentDirYZ(Pigment, StepSize, NoOfSteps) }

#end // macro BlurPigmentDirYZ_Function


#macro BlurPigmentDirXYZ_Function(Pigment, StepSize, NoOfSteps)

    function { BlurPigmentDirXYZ(Pigment, StepSize, NoOfSteps) }

#end // macro BlurPigmentDirXYZ_Function

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#macro BlurObjectPigment(Object, StepSize, NoOfSteps, vDirection)

    BlurPigment(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps,
        vDirection
    )

#end // macro BlurObjectPigment


#macro BlurObjectPigmentDirX(Object, StepSize, NoOfSteps)

    BlurPigmentDirX(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirX


#macro BlurObjectPigmentDirY(Object, StepSize, NoOfSteps)

    BlurPigmentDirY(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirY


#macro BlurObjectPigmentDirZ(Object, StepSize, NoOfSteps)

    BlurPigmentDirZ(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirZ


#macro BlurObjectPigmentDirXY(Object, StepSize, NoOfSteps)

    BlurPigmentDirXY(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirXY


#macro BlurObjectPigmentDirZX(Object, StepSize, NoOfSteps)

    BlurPigmentDirZX(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirZX


#macro BlurObjectPigmentDirYZ(Object, StepSize, NoOfSteps)

    BlurPigmentDirYZ(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirYZ


#macro BlurObjectPigmentDirXYZ(Object, StepSize, NoOfSteps)

    BlurPigmentDirXYZ(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirXYZ

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10

#macro BlurObjectPigment_Function(Object, StepSize, NoOfSteps, vDirection)

    BlurPigment_Function(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps,
        vDirection
    )

#end // macro BlurObjectPigment_Function


#macro BlurObjectPigmentDirX_Function(Object, StepSize, NoOfSteps)

    BlurPigmentDirX_Function(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirX_Function


#macro BlurObjectPigmentDirY_Function(Object, StepSize, NoOfSteps)

    BlurPigmentDirY_Function(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirY_Function


#macro BlurObjectPigmentDirZ_Function(Object, StepSize, NoOfSteps)

    BlurPigmentDirZ_Function(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirZ_Function


#macro BlurObjectPigmentDirXY_Function(Object, StepSize, NoOfSteps)

    BlurPigmentDirXY_Function(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirXY_Function


#macro BlurObjectPigmentDirZX_Function(Object, StepSize, NoOfSteps)

    BlurPigmentDirZX_Function(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirZX_Function


#macro BlurObjectPigmentDirYZ_Function(Object, StepSize, NoOfSteps)

    BlurPigmentDirYZ_Function(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirYZ_Function


#macro BlurObjectPigmentDirXYZ_Function(Object, StepSize, NoOfSteps)

    BlurPigmentDirXYZ_Function(
        ObjectPigment(Object),
        StepSize,
        NoOfSteps
    )

#end // macro BlurObjectPigmentDirXYZ_Function

// ===== 1 ======= 2 ======= 3 ======= 4 ======= 5 ======= 6 ======= 7 ======= 8 ======= 9 ======= 10
