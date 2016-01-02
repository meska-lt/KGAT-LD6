/*
background {
	color rgb 1
}
*/

global_settings {
	assumed_gamma 1.5
}

camera {
  location <0, 6, -5>
  look_at <0, 0, 0>
}

// now, some light
light_source {
  <0, 5, 2>
  color rgb <1, 1, 1>
}

cylinder {
	<0, 1, 0>,		// Center of one end
	<0, 3, 0>,		// Center of other end
	1				// Radius
	// open			// Remove end caps
	pigment { colour rgb <0, 1, 0> }
	translate <0, 0, 0>
	rotate <0,clock*360,0>
}