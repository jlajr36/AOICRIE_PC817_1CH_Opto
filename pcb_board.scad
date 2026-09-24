/*
    General Purpose PCB Board
    =========================

    Example:
        pcb_board(50, 30);

    Width  = 50 mm
    Depth  = 30 mm
    Thickness defaults to 1.6 mm
*/

module pcb_board(
    width,
    depth,
    thickness = 1.6,
    corner_radius = 0,
    mounting_holes = true,
    hole_dia = 3.2,
    hole_offset = 3.0
) {

    difference() {

        // ----------------------------------------------------
        // PCB BODY
        // ----------------------------------------------------

        color("DarkGreen")
        if (corner_radius > 0) {
            rounded_box(
                width,
                depth,
                thickness,
                corner_radius
            );
        }
        else {
            cube([
                width,
                depth,
                thickness
            ]);
        }


        // ----------------------------------------------------
        // MOUNTING HOLES
        // ----------------------------------------------------

        if (mounting_holes) {

            for (x = [
                hole_offset,
                width - hole_offset
            ])
            for (y = [
                hole_offset,
                depth - hole_offset
            ]) {

                translate([
                    x,
                    y,
                    -0.1
                ])
                cylinder(
                    d = hole_dia,
                    h = thickness + 0.2
                );
            }
        }
    }
}


/*
    Rounded PCB helper
*/

module rounded_box(w, d, h, r) {

    linear_extrude(height = h)
    hull() {

        translate([r, r])
        circle(r = r);

        translate([w-r, r])
        circle(r = r);

        translate([r, d-r])
        circle(r = r);

        translate([w-r, d-r])
        circle(r = r);
    }
}
