/* 
       
Nathan Stark 
CS 360
Part I
01-14-2018
 
*/

light_source{
 <-15,10,20>         
 color rgb<1,1,1>}
light_source{
 <2,2,-2.7>        
 color rgb<1,1,1>
 looks_like{ 
  sphere{ <2,2,-3>, 4
   pigment { rgbf <5,1,1,0> } no_shadow}
}}

intersection{
 sphere{<1,1,1>,3}
 box{<3,3,3>,<2,2,2>}
 sphere{<1,1,1>,3}
 interior { ior 1.3 }
 pigment { color rgb <0,0,1> }
 finish{         
  roughness 0
  reflection rgb<0,0,1>} }


plane{   
 <0,2,0>, -2
 pigment{
  checker
  rgbf <0,1,4,3>
  rgbf <1,0,0,1>
  scale 5}
 finish{
  diffuse 2
  ambient 0.2
  roughness 5
  reflection rgb<1,1,1>}
}

plane 
{ 
 <0,2,0>, -2.5
 pigment {color rgb <1,1,1> }
 finish{
  diffuse 3
  ambient 0.9
  roughness 0
  reflection rgb<1,1,1>}
}
 

camera
{
 perspective     
 location <-15,6,15>
 look_at <0,0,0>
} 


union{
 sphere{<-7,1.9,3>, 1.3}
 sphere{<-7,3.5,3>,1.3}
 pigment {color rgb <1,0,1> }
 finish{
  roughness 0
  reflection rgb<1,0,1>}
 
}





