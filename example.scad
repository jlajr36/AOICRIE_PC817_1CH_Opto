/* [Terminal Block Parameters] */
// Number of terminal positions/poles
poles = 2; // [2:1:24]
// Distance between center of pins (Pitch in mm)
pitch = 5.08; // [2.54, 3.5, 3.81, 5.00, 5.08, 7.5]
// Total height of the terminal plastic body
body_height = 10.0;
// Total depth of the terminal plastic body
body_depth = 8.0;

/* [Internal Hardware Elements] */
// Diameter of the entry hole for the wire
wire_hole_dia = 2.5;
// Diameter of the top screw entry hole
screw_hole_dia = 2.2;
// Depth of the terminal screw holes
screw_hole_depth = 4.0;
// Side-to-side wire entry window width (for internal cage)
cage_width = 3.0;

/* [Rendering Quality] */
// Smoothness of circles
$fn = 32;

// Execute the main model
terminal_block(poles, pitch, body_height, body_depth);

module terminal_block(p, pt, h, d) {
    body_width = p * pt;
    
    difference() {
        // 1. Main Outer Housing Block
        color("MediumSeaGreen")
        cube([body_width, d, h]);
        
        // Loop through each pole position to subtract internal details
        for (i = [0 : p - 1]) {
            // Calculate X-center for current pole
            x_pos = (i * pt) + (pt / 2);
            
            // 2. Wire Entry Holes (Front Face)
            // Positioned slightly above the bottom line
            translate([x_pos, -0.1, h * 0.35])
            rotate([-90, 0, 0])
            cylinder(d = wire_hole_dia, h = d * 0.6);
            
            // 3. Screw Holes (Top Face)
            // Positioned in the middle of the depth profile
            translate([x_pos, d / 2, h - screw_hole_depth + 0.1])
            cylinder(d = screw_hole_dia, h = screw_hole_depth);
            
            // 4. Clamping Cage Slots (Internal Rectangles)
            // Simulates the metal box that holds the wire
            translate([x_pos - (cage_width / 2), (d / 2) - 1.5, h * 0.15])
            cube([cage_width, 3.0, h * 0.6]);
            
            // 5. Interlocking Barrier/Divider slots (Optional aesthetic)
            if (i > 0) {
                translate([i * pt - 0.4, -0.1, -0.1])
                cube([0.8, d * 0.3, h * 0.8]);
            }
        }
    }
}