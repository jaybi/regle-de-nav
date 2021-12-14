ruler_size_lengh=130;
ruler_size_width=40;
ruler_size_hight=2;

//PON
pon_radius = 10;
pon_offsetX = 10;
pon_offsetY = 10;

//Graduations
gap_btw_leg=8;
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
  
//Leg
    //Leg rectangle
        translate([pon_offsetX+gap_btw_leg,pon_offsetY-fente_size/2,0])
            cube([(nb_fentes-2)*one_minute_lengh-gap_btw_leg,fente_size,5],center=false);
    
    //Leg cylindre début
        translate([pon_offsetX+gap_btw_leg,pon_offsetY,0])
            cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);
      
    //Leg cylindre fin
        translate([
            (nb_fentes-2)*one_minute_lengh+pon_offsetX,
            pon_offsetY,
            0])
            cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);
      

      
//Graduation longues
    for (i=[2:2:nb_fentes]) {
        dx = i*one_minute_lengh; 
//Fente rectangle
        translate([pon_offsetX,pon_offsetY,0])
        translate([dx,gap_btw_leg,0])
            cube([fente_size,fente_width,5],center=true);  
        
//Fente cylindre gauche
        translate([pon_offsetX,pon_offsetY-fente_width/2,0])
        translate([dx,gap_btw_leg,0])
            cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=false);
      
//Fente cylindre droit
        translate([pon_offsetX,pon_offsetY+fente_width/2,0])
        translate([dx,gap_btw_leg,0])
            cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);}
    
//Graduation courtes
    for (i=[1:2:nb_fentes]) {
        dx = i*one_minute_lengh;  
//Fente rectangle
        translate([pon_offsetX,pon_offsetY-(fente_width/4),0])
        translate([dx,gap_btw_leg,0])
            cube([fente_size,fente_width/2,5],center=true);  
//Fente cylindre gauche
        translate([pon_offsetX,pon_offsetY-fente_width/4-(fente_width/4),0])
        translate([dx,gap_btw_leg,0])
            cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=false);
      
//Fente cylindre droit
        translate([pon_offsetX,pon_offsetY+fente_width/4-(fente_width/4),0])
        translate([dx,gap_btw_leg,0])
            cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);}
  
    
   

}


 


 