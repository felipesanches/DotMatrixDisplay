// (c) 2013 Felipe C. da S. Sanches <juca@members.fsf.org>
// Licensed under the terms of the GNU General Public License
// version 3 (or later).

pcb_width = 96;
pcb_height = 99;
mount_hole_diam = 3;
pcb_thickness = 1.8;

module pcb(){
  color([0.2, 0.2, 0.2])
  linear_extrude(height=pcb_thickness)
  pcb_outline();
}

module pcb_outline(){
  difference(){
    square([pcb_width, pcb_height]);

    translate([4 + mount_hole_diam/2, 3 + mount_hole_diam/2])
    circle(r=mount_hole_diam/2, $fn=20);

    translate([pcb_width - (4 + mount_hole_diam/2), 3 + mount_hole_diam/2])
    circle(r=mount_hole_diam/2, $fn=20);

    translate([4 + mount_hole_diam/2, pcb_height - (2 + mount_hole_diam/2)])
    circle(r=mount_hole_diam/2, $fn=20);

    translate([pcb_width - (4 + mount_hole_diam/2), pcb_height - (2 + mount_hole_diam/2)])
    circle(r=mount_hole_diam/2, $fn=20);
  }
}

cover_thickness = 3;
cover_color = [0.9, 0.9, 1, 0.5];

module dmd_cover(){
  color(cover_color)
  linear_extrude(height=cover_thickness)
  dmd_cover_curves();
}

module dmd_cover_curves(){
  for (i=[0:6])
    translate([i*(pcb_width),0])
      pcb_outline();
}

ledmodule_size = 32;
pixel_diam = 3;

module led8x8(data){
  size = ledmodule_size-0.2;
  thickness = 8;
  color ([0.8, 0.8, 0.8])
  cube([size,size,thickness]);

  translate([0,0,thickness]){
    color([0.3, 0.3, 0.3])
    linear_extrude(height=0.1){
      difference(){
        square([size,size]);

        for (x=[0:7])
          for (y=[0:7])
            translate([2+x*4,2+y*4])
            circle(r=pixel_diam/2, $fn=20);
      }
    }

    for (x=[0:7])
      for (y=[0:7])
        translate([2+x*4,2+y*4])
        if (data[(x+offset[0])*16 + (y+offset[1])]){
          color("red")
            linear_extrude(height=0.1)
            circle(r=pixel_diam/2, $fn=20);
        }
  }
}


include <dmd_image.scad>;

module dmd_module(){
  pcb();
  translate([0,pcb_height-ledmodule_size-8,pcb_thickness])
  for (x=[0:2])
    for (y=[0:1])
      translate([x*ledmodule_size, (y-1)*ledmodule_size])
      led8x8(data=dmd_image, offset=[x*8,y*8]);
}


for (i=[0:6])
  translate([i*(pcb_width),0])
  dmd_module();

translate([0,0,12])
dmd_cover();











