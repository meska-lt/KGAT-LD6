/*
background {
	color rgb 1
}
*/

#include "colors.inc"
#include "textures.inc"

#declare ImageWidth = 800;
#declare ImageHeight = 480;

global_settings {
	assumed_gamma 1.0
}

// camera ----------------------------------
camera {
	angle 75
	location  <0, 12.0, -20.0>
	look_at   <0.0, 6.0, 0.0>
	rotate <0,clock*360,0>
	right x*ImageWidth/ImageHeight
}

// sun -------------------------------------
light_source{
	<1500, 3000, -2500> color White
}

// sky ----------------------------------
plane{
	<0,1,0>, 1 hollow
	texture {
		pigment {
			bozo turbulence 0.92
			color_map {
				[0.00 rgb<0.05, 0.15, 0.45>]
				[0.50 rgb<0.05, 0.15, 0.45>]
				[0.70 rgb<1, 1, 1>]
				[0.85 rgb<0.2, 0.2, 0.2>]
				[1.00 rgb<0.5, 0.5, 0.5>]
			}
			scale<1, 1, 1.5> * 2.5
			translate<0, 0, 0>
		}
		finish {
			ambient 1 diffuse 0
		}
	}
	scale 10000
}

// ground ----------------------------------
plane {
	<0, 1, 0>, 0
	texture {
		Cork
//		pigment{ color rgb<0.22, 0.45, 0>}
//		normal { bumps 0.75 scale 0.015 }
//		finish { phong 0.1 }
	}
}

// fog on the ground -----------------------
fog {
	fog_type 2
	distance 35
	color rgb <1, 1, 1> * 0.8
	fog_offset 0.1
	fog_alt 1.5
	turbulence 1.8
}

union {
	union {
		cylinder {
			<0,0,0>,
			<0,8,0>,
			4
			clipped_by {
				cylinder {
					<0,1,0>,
					<0,8,0>,
					3
					translate<0,1,0> inverse
				}
			}
			pigment {
				color White
			}
		}

		cylinder {
			<0,1,0>,
			<0,7,0>,
			3
			pigment {
				color rgb <0, 0, 0>
			}
		}
	}

	torus {
		2,
		0.5
		rotate <90, 0, 0>
		translate <-4, 3.75, 0>
		pigment {
			color White
		}
	}
}

union {
	cylinder {
		<6,0.5,0>,
		<9,0.5,0>,
		0.5
		pigment {
			color Orange
		}
	}

	cylinder {
		<9,0.5,0>,
		<16,0.5,0>,
		0.5
		pigment {
			color White
		}
	}
}