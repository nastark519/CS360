//python lab2

//nathanStarkPartI

difference {    

 union {
   
   intersection {
    box{          
     <-2,-2,-2><2,2,2>
    }
    sphere{    
    <2,2,2>,4
    }
   }
   
   sphere{   
    <0,2,0>,2
   }
  }
    
 sphere{   
  <0,0,-2>,4
 }
 
 pigment {color rgb<0,0,1>}
 finish{         
  roughness 0
  reflection rgb<0,0,1>} 
}

light_source{
 <10,10,10>         
 color rgb<1,1,1>
}

plane{   
 <0,1,0>, -2
 pigment{          
  checker
  color rgb<0,1,0.1>
  color rgb<2,0,0>
  scale 5
 }

 finish{
  diffuse 2
  ambient 0.2
  roughness 0
  reflection rgb<0,1,0>
 } 
}

camera
{
 perspective     
 location <10,5,1>
 look_at <0,0,0>
}