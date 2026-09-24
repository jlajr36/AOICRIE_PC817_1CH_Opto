/* [Terminal Block Parameters] */

// Number of terminal positions
terminals = 2; // [2:1:24]

// Distance between terminal centers
pitch = 5.08; // [2.54, 3.5, 3.81, 5.00, 5.08, 7.5]

// Total height of plastic body
body_height = 10.0;

// Total depth of plastic body
body_depth = 8.0;


/* [Internal Hardware Elements] */

wire_hole_dia = 2.5;
screw_hole_dia = 2.2;
screw_hole_depth = 4.0;
cage_width = 3.0;


/* [PCB Pins] */

pin_dia = 1.0;
pin_length = 4.0;
pin_y = body_depth / 2;


/* [Rendering Quality] */

$fn = 32;


// ============================================================
// MAIN CALL
// ============================================================

terminal_block(terminals, pitch);


// ============================================================
// TERMINAL BLOCK MODULE
// ============================================================

module terminal_block(p, pt) {

    body_width = p * pt;

    difference() {

        // ----------------------------------------------------
        // Main plastic housing
        // ----------------------------------------------------

        color("MediumSeaGreen")
        cube([
            body_width,
            body_depth,
            body_height
        ]);


        // ----------------------------------------------------
        // Details for each terminal
        // ----------------------------------------------------

        for (i = [0 : p - 1]) {

            x_pos = (i * pt) + (pt / 2);


            // Wire entry hole
            translate([
                x_pos,
                -0.1,
                body_height * 0.35
            ])
            rotate([-90, 0, 0])
            cylinder(
                d = wire_hole_dia,
                h = body_depth * 0.6
            );


            // Screw hole
            translate([
                x_pos,
                body_depth / 2,
                body_height - screw_hole_depth + 0.1
            ])
            cylinder(
                d = screw_hole_dia,
                h = screw_hole_depth
            );


            // Internal cage slot
            translate([
                x_pos - cage_width / 2,
                (body_depth / 2) - 1.5,
                body_height * 0.15
            ])
            cube([
                cage_width,
                3.0,
                body_height * 0.6
            ]);


            // Divider between terminals
            if (i > 0) {

                translate([
                    i * pt - 0.4,
                    -0.1,
                    -0.1
                ])
                cube([
                    0.8,
                    body_depth * 0.3,
                    body_height * 0.8
                ]);
            }
        }
    }


    // --------------------------------------------------------
    // PCB PINS
    // --------------------------------------------------------

    for (i = [0 : p - 1]) {

        x_pos = (i * pt) + (pt / 2);

        color("Silver")
        translate([
            x_pos,
            pin_y,
            -pin_length
        ])
        cylinder(
            d = pin_dia,
            h = pin_length
        );
    }
}
