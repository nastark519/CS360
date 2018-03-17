/* Lab 1, Cube example: cube.pov
*/
camera
{
 perspective
 location <6,4,-6>
 look_at <0,0,0>
}

/*
light_source
{
 <1.5,1.5,1.5>,
 color rgb <5,5,5>
}

light_source
{
 <20,20,20>,
 color rgb <1,1,1>
}
*/

box
{
 <-0.5,-0.5,-0.5>,<0.5,0.5,0.5>
 interior { ior 1.3 }
 pigment { rgbf <0.9,0,0,1> }
 photons { target reflection on refraction on }
}

light_source
{
 <1.5,1.5,1.5>,
 color rgb <5,5,5>
 looks_like{ 
  box { <1,1,1>,<2,2,2>
   pigment {color rgb <1,0,1>}
   no_shadow} 
}}

plane
{
 <0,1,0>, -2
 pigment { rgb <1,1,1> }
}
