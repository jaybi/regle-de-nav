ruler_size_lengh=150;
ruler_size_width=50;
ruler_size_hight=2;

//MArgins
high_margin = 15;
high_margin_leg = 20;

//PON
pon_radius = 8;
pon_offsetX = 10;
pon_offsetY = 10;

//Graduations
gap_btw_fentes_texte = 2;
gap_btw_leg=8;
fente_width=8;
fente_size=1.5;

//Vitesse en kts
speed=100;
map_scale=250000;
one_minute_lengh= (1/60)*speed*1.852*1000000/map_scale;

//nombre de fentes
nb_fentes = floor(ruler_size_lengh/one_minute_lengh);

font = "Arcline";

$fn=50;
    
//projection() 
difference(){

    //Ruler base
    cube([ruler_size_lengh,ruler_size_width,ruler_size_hight]);
        
    //PON
        translate([pon_offsetX,pon_offsetY,0])
            cylinder(h=ruler_size_hight*2+1,r=pon_radius,center=true);
        
    // Triangle
         translate([25,38,-1])
            cylinder(h=10,r=10,$fn=3, center=false);
      
    //Leg
        //Leg rectangle
        
        for(i=[0:1:3]) {
            echo((nb_fentes-i)*one_minute_lengh-gap_btw_leg-high_margin_leg);
            if((nb_fentes-i)*one_minute_lengh-gap_btw_leg < ruler_size_lengh) {
                translate([pon_offsetX+gap_btw_leg+pon_radius/2,pon_offsetY-fente_size/2,-1])
                    cube([(nb_fentes-i)*one_minute_lengh-high_margin_leg-pon_radius/2,fente_size,5],center=false);
            
                //Leg cylindre début
                translate([pon_offsetX+gap_btw_leg+pon_radius/2,pon_offsetY,0])
                    cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);
              
                //Leg cylindre fin
                translate([
                    (nb_fentes-i)*one_minute_lengh+pon_offsetX+gap_btw_leg-high_margin_leg,pon_offsetY,0])
                    cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);
            }
       }   
          
    //Graduation longues
    //echo((nb_fentes-2)*one_minute_lengh)
    for (i=[2:2:nb_fentes-2]) {
        dx = i*one_minute_lengh;    
        if (ruler_size_lengh - dx  > high_margin) {
            //Fente rectangle
            translate([pon_offsetX,pon_offsetY,0])
            translate([dx,gap_btw_leg,0])
                cube([fente_size,fente_width,5],center=true);  
            
            //Fente cylindre droit
            translate([pon_offsetX,pon_offsetY-fente_width/2,0])
            translate([dx,gap_btw_leg,0])
                cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=false);
          
            //Fente cylindre gauche
            translate([pon_offsetX,pon_offsetY+fente_width/2,0])
            translate([dx,gap_btw_leg,0])
                cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);
            //Texte
            translate([pon_offsetX-2,pon_offsetY+fente_width/2+1,-1])
            translate([dx,gap_btw_leg+gap_btw_fentes_texte,0])
                rotate([0,0,270])
                linear_extrude(ruler_size_hight+2)
                text(str(i), font=font, size=5, halign = "right");
        }
    }
        
    //Graduation courtes
    for (i=[3:2:nb_fentes-1]) {
        dx = i*one_minute_lengh; 
        if (ruler_size_lengh - dx  > high_margin) { 
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
                cylinder(h=ruler_size_hight*2+1,r=fente_size/2,center=true);
        }
    }

    //Text : Vitesse
    rotate([0,0,270])
    translate([-ruler_size_width+1,8,1])
    linear_extrude(height=2)
        text(str(speed), font=font, size=4, halign = "left");
                
    rotate([0,0,270])
    translate([-ruler_size_width+12,8,1])
    linear_extrude(height=2)
        text("kts", font=font, size=3, halign = "left");  
                
    //Text : Echelle
                
    rotate([0,0,270])
    translate([-ruler_size_width+1,1,1])
    linear_extrude(height=2)
        text("1/", font=font, size=4, halign = "left"); 
                
    rotate([0,0,270])
    translate([-ruler_size_width+5,1,1])
    linear_extrude(height=2)
        text(str(map_scale), font=font, size=4, halign = "left");         

}

//renfort
translate([ruler_size_lengh/2,0,0])
    cube([1,pon_offsetX+1,ruler_size_hight]);
   


 


 