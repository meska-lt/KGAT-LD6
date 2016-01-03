/*
background {
	color rgb 1
}
*/

#include "colors.inc"
#include "textures.inc"

#declare ImageWidth = 800;
#declare ImageHeight = 480;
//#declare ImageWidth = 640;
//#declare ImageHeight = 480;

#declare CupOffsetX = 21;
#declare CupOffsetY = 0;
#declare CupOffsetZ = 7;

#local H = 40; // table height,
#local W = 60; // table width in x and z
#local R = 0.75; // table leg thickness

//------------------------
#declare Table_01 =
union{
	// feet
	cylinder{<0,0,0>,<0,H,0>, R translate< W/2-R,0,-W/2+R>}
	cylinder{<0,0,0>,<0,H,0>, R translate< W/2-R,0, W/2-R>}
	cylinder{<0,0,0>,<0,H,0>, R translate<-W/2+R,0, W/2-R>}
	cylinder{<0,0,0>,<0,H,0>, R translate<-W/2+R,0,-W/2+R>}

	// seat
	box{ <-W/2,-0.025,-W/2>,<W/2,0,W/2> translate<0,H,0> }

	pigment{ color rgb<0.75,0.5,0.3>*0.3}
}

global_settings {
	assumed_gamma 1.0
}

// camera ----------------------------------
camera {
	angle 75
	location  <0, H+30.0, -30-(90.0*clock)>
	look_at   <0.0, H+6.0, 0.0>
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

// coffee cup ------------------
union {
	union {
		cylinder {
			<CupOffsetX,H+0,CupOffsetZ>,
			<CupOffsetX,H+8,CupOffsetZ>,
			4
			clipped_by {
				cylinder {
					<CupOffsetX,H+1,CupOffsetZ>,
					<CupOffsetX,H+8,CupOffsetZ>,
					3
					translate<0,1,0> inverse
				}
			}
			pigment {
				color White
			}
		}

		cylinder {
			<CupOffsetX,H+1,CupOffsetZ>,
			<CupOffsetX,H+7,CupOffsetZ>,
			3
			pigment {
				color rgb <0, 0, 0>
			}
		}
	}

	torus {
		2.5,
		0.5
		rotate <90, 0, 0>
		translate <CupOffsetX-4, H+3.75, CupOffsetZ>
		pigment {
			color White
		}
	}
}

// cigarette -------------
union {
	union {
		cylinder {
			<6,H+0.5,0>,
			<9,H+0.5,0>,
			0.5
			open
			pigment {
				color Orange
			}
		}

		cylinder {
			<6,H+0.5,0>,
			<9,H+0.5,0>,
			0.495
			pigment {
				color White
			}
		}
	}

	union {
		cylinder {
			<9,H+0.5,0>,
			<16,H+0.5,0>,
			0.5
			open
			pigment {
				color White
			}
		}

		cylinder {
			<9,H+0.5,0>,
			<16,H+0.5,0>,
			0.495
			pigment {
				color Brown
			}
		}

	}
}

// table ----------------
object {
	Table_01
	rotate<0,0,0>
	translate<0,0,10>
}