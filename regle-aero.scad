use <roundedcube.scad>;


//Paremètres importants :
speed=100;
map_scale=250000;
ruler_size_lengh=200;
ruler_size_width=55;
ruler_size_hight=2;

//Margins
high_margin = 15;
high_margin_leg = 20;

//PON
pon_radius = 8;
pon_offsetX = 10;
pon_offsetY = 10;

//Graduations
gap_btw_fentes_texte = 3;
gap_btw_leg=10;
fente_width=8;
fente_size=2.5;
font_size=10;

//Taille des graduations
one_minute_lengh= (1/60)*speed*1.852*1000000/map_scale;

//nombre de fentes
nb_fentes = floor(ruler_size_lengh/one_minute_lengh);

//font = "Arcline:style=bold";
//font = "X.Template";
font = "Cleanwork";


//Définition des cercles
$fn=50;

//ISO 838
espace_entre_trous=80;
hole_radius=3;

//Rectangle
rect_long=20;
rect_larg=10;
rect_haut=10;
rect_left_margin=2;

//Triangle
triangle_size=10;

//projection() 
difference(){
    //Ruler base
    
    roundedcube([ruler_size_lengh,ruler_size_width,ruler_size_hight],false,1,"z");
    
    //Trous pour rangement dans un classeur Norme ISO 838
    translate([ruler_size_lengh/2,ruler_size_width,0]){     //Déplacement en haut à gauche
        translate([2,-8,0]){
            translate([espace_entre_trous/2,0,0])
                cylinder(h=10, r=hole_radius, center=true);
            translate([-espace_entre_trous/2,0,0])
                cylinder(h=10, r=hole_radius, center=true);
        }
    }
    
    //PON
        translate([pon_offsetX,pon_offsetY,-1])
            cylinder(h=10,r=pon_radius,center=false);
        
    // Triangle
         translate([45,ruler_size_width-10,-1])
            cylinder(h=10,r=triangle_size,$fn=3, center=false);
    
    // Rectangle
        translate([ruler_size_lengh/2,ruler_size_width-rect_larg/2-rect_left_margin,-1])
            cube([rect_long,rect_larg,rect_haut],center=true);
      
    //Leg
        //Leg rectangle
        
        for(i=[0:1:3]) {
            if((nb_fentes-i)*one_minute_lengh-gap_btw_leg < ruler_size_lengh) {
                translate([pon_offsetX+gap_btw_leg+pon_radius/2-2,pon_offsetY-fente_size/2,-1])
                    cube([(nb_fentes-i)*one_minute_lengh-high_margin_leg-pon_radius/2-2,fente_size,5],center=false);
            
                //Leg cylindre début
                translate([pon_offsetX+gap_btw_leg+pon_radius/2-2,pon_offsetY,0])
                    cylinder(h=ruler_size_hight*2+2,r=fente_size/2,center=true);
              
                //Leg cylindre fin
                translate([(nb_fentes-i)*one_minute_lengh+pon_offsetX+gap_btw_leg-high_margin_leg-4,pon_offsetY,0])
                    cylinder(h=ruler_size_hight*2+2,r=fente_size/2,center=true);
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
                cylinder(h=ruler_size_hight*2+2,r=fente_size/2,center=true);
          
            //Fente cylindre gauche
            translate([pon_offsetX,pon_offsetY+fente_width/2,0])
            translate([dx,gap_btw_leg,0])
                cylinder(h=ruler_size_hight*2+2,r=fente_size/2,center=true);
            //Texte
            translate([pon_offsetX-5,pon_offsetY+fente_width/2,-1])
            translate([dx,gap_btw_leg+gap_btw_fentes_texte,0])
                rotate([0,0,270])
                linear_extrude(ruler_size_hight+2)
                text(str(i), font=font, size=font_size, halign = "right");
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
                cylinder(h=ruler_size_hight*2+2,r=fente_size/2,center=true);
              
            //Fente cylindre droit
            translate([pon_offsetX,pon_offsetY+fente_width/4-(fente_width/4),0])
            translate([dx,gap_btw_leg,0])
                cylinder(h=ruler_size_hight*2+2,r=fente_size/2,center=true);
        }
    }

    //Text : Vitesse
    rotate([0,0,270])
    translate([-ruler_size_width+1,8,1])
    linear_extrude(height=2)
        text(str(speed), font=font, size=5, halign = "left");
              
    rotate([0,0,270])
    translate([-ruler_size_width+12,8,1])
    linear_extrude(height=2)
        text("kts", font=font, size=4, halign = "left");  
                
    //Text : Echelle        
    rotate([0,0,270])
    translate([-ruler_size_width+1,1,1])
    linear_extrude(height=2)
        text("1/", font=font, size=5, halign = "left"); 
                
    rotate([0,0,270])
    translate([-ruler_size_width+7,1,1])
    linear_extrude(height=2)
        text(str(map_scale), font=font, size=5, halign = "left");         

}

//renfort
//translate([ruler_size_lengh/2,0,0])
//    cube([1,pon_offsetX+1,ruler_size_hight]);
   


 


 