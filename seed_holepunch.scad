// seed hole puncher
// by Ming-Dao Chia

// Settings
horizontal_size = 40; // (mm) Main handle face
puncher_height = 30; // (mm) Height of main handle bit

hole_num = 4; // Number of hole punchers
punch_depth = 3; // (mm) How long each punch bit is
punch_width = 2; // (mm) Diameter of punch bit
punch_spacing = 11; // (mm) Space between each punch bit
punch_correction = 45; // (degrees) Rotates all the bits by this angle to align them to the box

// Advanced settings
circle_res = 64; // number of circle faces to approximate circle
// set to 16 for faster previews, higher e.g. 128 for printing
fudge = 0.001; // tolerance to ensure manifold objects

module shp_punch_bit(diameter, depth){
    cylinder(d=diameter, h=depth, $fn=circle_res);
}

module shp_punch_bits(num, size, depth, total_angle=360){
    function angle(i,num)=i*(total_angle/num);
    rad = ((punch_spacing/2)+punch_width)/sin(angle(1,num));
    for(i=[1:num]){
        rotate([0,0,angle(i,num)*0.999])
        translate([rad,0,0])
        shp_punch_bit(size, depth);
    }
}

module seed_hole_punch(){
    // core cube
    color("gray")
    cube([horizontal_size,horizontal_size,puncher_height]);
    
    // puncher bits
    color("brown")
    translate([horizontal_size/2,horizontal_size/2,puncher_height-fudge])
    rotate([0,0,45])
    shp_punch_bits(hole_num, punch_width, punch_depth);
}

seed_hole_punch();

