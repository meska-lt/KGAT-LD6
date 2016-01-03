/*
background {
	color rgb 1
}
*/

#include "colors.inc"
#include "textures.inc"

#declare ImageWidth = 1280;
#declare ImageHeight = 720;
//#declare ImageWidth = 800;
//#declare ImageHeight = 480;
//#declare ImageWidth = 640;
//#declare ImageHeight = 480;

#declare CupOffsetX = 21;
#declare CupOffsetY = 0;
#declare CupOffsetZ = 7;

#declare TeaspoonOffsetX = CupOffsetX + 8;
#declare TeaspoonOffsetY = CupOffsetY - 1;
#declare TeaspoonOffsetZ = CupOffsetZ - 8;

#local TableHeight = 40;
#local TableWidth = 60;
#local LegThickness = 1.25;

//------------------------
#declare Table_01 =
union{
	// feet
	cylinder{<0, 0, 0>,<0, TableHeight, 0>, LegThickness translate< TableWidth/2-LegThickness*4, 0, -TableWidth/2+LegThickness*4>}
	cylinder{<0, 0, 0>,<0, TableHeight, 0>, LegThickness translate< TableWidth/2-LegThickness*4, 0,  TableWidth/2-LegThickness*4>}
	cylinder{<0, 0, 0>,<0, TableHeight, 0>, LegThickness translate<-TableWidth/2+LegThickness*4, 0,  TableWidth/2-LegThickness*4>}
	cylinder{<0, 0, 0>,<0, TableHeight, 0>, LegThickness translate<-TableWidth/2+LegThickness*4, 0, -TableWidth/2+LegThickness*4>}

	// seat
	box{ <-TableWidth/2, -LegThickness / 5 * 3, -TableWidth/2>,<TableWidth/2, 0, TableWidth/2> translate<0, TableHeight, 0> }

	pigment{ color rgb<0.75, 0.5, 0.3>*0.3}
}

global_settings {
	assumed_gamma 1.0
}

// camera ----------------------------------
camera {
	angle 75
	location  <0, TableHeight+30.0, -30-(90.0*clock)>
	look_at   <0.0, TableHeight+10.0, 0.0>
	rotate <0, clock*360, 0>
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
			<CupOffsetX,TableHeight+0,CupOffsetZ>,
			<CupOffsetX,TableHeight+8,CupOffsetZ>,
			4
			clipped_by {
				cylinder {
					<CupOffsetX,TableHeight+1,CupOffsetZ>,
					<CupOffsetX,TableHeight+8,CupOffsetZ>,
					3
					translate<0,1,0> inverse
				}
			}
			pigment {
				color White
			}
		}

		cylinder {
			<CupOffsetX,TableHeight+1,CupOffsetZ>,
			<CupOffsetX,TableHeight+7,CupOffsetZ>,
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
		translate <CupOffsetX-4, TableHeight+3.75, CupOffsetZ>
		pigment {
			color White
		}
	}
}

// cigarette -------------
/*
union {
	union {
		cylinder {
			<6, TableHeight+0.5, 0>,
			<9, TableHeight+0.5, 0>,
			0.5
			open
			pigment {
				color Orange
			}
		}

		cylinder {
			<6, TableHeight+0.5, 0>,
			<9, TableHeight+0.5, 0>,
			0.495
			pigment {
				color White
			}
		}
	}

	union {
		cylinder {
			<9, TableHeight+0.5, 0>,
			<16, TableHeight+0.5, 0>,
			0.5
			open
			pigment {
				color White
			}
		}

		cylinder {
			<9, TableHeight+0.5, 0>,
			<16, TableHeight+0.5, 0>,
			0.495
			pigment {
				color Brown
			}
		}

	}
}
*/

// teaspoon -------------
merge {
	sphere {
		<TeaspoonOffsetX, TableHeight+TeaspoonOffsetY+1, TeaspoonOffsetZ>,
		1
		clipped_by {
			sphere {
				<TeaspoonOffsetX, TableHeight+TeaspoonOffsetY+0.95, TeaspoonOffsetZ+0>
				1
			}
		}
	}
	box {
		<TeaspoonOffsetX+0.05, TableHeight+TeaspoonOffsetY+0.8, TeaspoonOffsetZ-0.25>
		<TeaspoonOffsetX-5.95, TableHeight+TeaspoonOffsetY+1, TeaspoonOffsetZ+0.25>
	}
	texture { Chrome_Metal }
	rotate <0, 0, 8.5>
	translate <0, -2.75, 0>
}

// table ----------------
object {
	Table_01
	rotate<0, 0, 0>
	translate<0, 0, 10>
}