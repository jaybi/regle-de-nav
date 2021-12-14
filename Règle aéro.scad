ruler_size_lengh=130;
ruler_size_width=40;
ruler_size_hight=2;


pon_radius = 10;
pon_offsetX = 10;
pon_offsetY = 10;

fente_width=8;
fente_size=1;

//Vitesse en kts
speed=100;
map_scale=500000;
one_minute_lengh= (1/60)*speed*1.852*1000000/map_scale;

//nombre de fentes
nb_fentes = ruler_size_lengh/one_minute_lengh;



difference(){
    
    //Ruler base
    cube([ruler_size_lengh,ruler_size_width,ruler_size_hight]);
    
//PON
    translate([pon_offsetX,pon_offsetY,0])
        cylinder(h=ruler_size_hight*2+1,r=5,center=true);
  for (i=[1:1:nb_fentes]) {
        dx = i*one_minute_lengh;
      
//Fente cylindre gauche
        translate([pon_offsetX,pon_offsetY-fente_width/2,0])
        translate([dx,0,0])
            cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=false);
      
//Fente cylindre droit
        translate([pon_offsetX,pon_offsetY+fente_width/2,0])
        translate([dx,0,0])
            cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);
//Fente rectangle
        translate([pon_offsetX,pon_offsetY,0])
        translate([dx,0,0])
            cube([fente_size,fente_width,5],center=true);
 
    }
  
    
    

}


 