#!/usr/bin/env python

from gimpfu import *
import os

def convert_for_atari(img, srclayer):
    try:
        pdb.gimp_image_undo_group_start(img)

        layer = srclayer.copy()
        img.add_layer(layer, 0) 
        width = layer.width
        height = layer.height

        grayscale_conversion(layer)
         
        # Convert image to indexed with custom palette "atarigray"
        pdb.gimp_message("Converting to indexed with palette 'atarigray'...")
        pdb.gimp_image_convert_indexed(img, 0, 4, 256, False, False, "atarigray")

        # Convert image back to RGB
        pdb.gimp_message("Converting back to RGB...")
        pdb.gimp_image_convert_rgb(img)


        write_luminance_levels(layer)

        
        # Specify the path to the .gpl file
        file_path = "atarigray.gpl"
        
        write_color_values(file_path)

        layer.flush()
        layer.update(0,0,width,height)
        pdb.gimp_image_undo_group_end(img)
        pdb.gimp_message("Grayscale conversion finished!")

    except Exception as err:
        pdb.gimp_message("ERROR: " + str(err))
        pdb.gimp_image_undo_group_end(img)

def grayscale_conversion(layer):
    pdb.gimp_message("Starting grayscale conversion...")

    width = layer.width
    height = layer.height
    
    for y in range(height):
        for x in range(width):
            r, g, b = layer.get_pixel(x, y)
            gray = (r + g + b) // 3 # Averaging RGB to B/W formula
            layer.set_pixel(x, y, (gray, gray, gray))
    pdb.gimp_message("Grayscale conversion finished!")

def write_luminance_levels(layer):
    pdb.gimp_message("Writing luminance levels to file...")
    width = layer.width
    height = layer.height
    min_luminance_array = [min([0.21*r + 0.72*g + 0.07*b for r, g, b in [layer.get_pixel(x, y) for x in range(width)]]) for y in range(height)]
    max_luminance_array = [max([0.21*r + 0.72*g + 0.07*b for r, g, b in [layer.get_pixel(x, y) for x in range(width)]]) for y in range(height)]
    closest_min_luminance_array = [round((min_luminance / 255) * 7) for min_luminance in min_luminance_array]
    closest_max_luminance_array = [round((max_luminance / 255) * 7) for max_luminance in max_luminance_array]
    with open("luminance_levels.txt", "w") as f:
        for y in range(height):
            f.write("Line " + str(y) + ": Min Luminance = " + str(min_luminance_array[y]) + ", Max Luminance = " + str(max_luminance_array[y]) + ", Closest Min Color Value = " + str(closest_min_luminance_array[y]) + ", Closest Max Color Value = " + str(closest_max_luminance_array[y]) + "\n")
    pdb.gimp_message("Luminance levels written to file!")

def write_color_values(file_path):
    pdb.gimp_message("Writing color values to file...")
    with open(file_path) as f:
        contents = f.readlines()

    # Open the output file for writing
    home_dir = os.path.expanduser("~")
    output_file_path = os.path.join(home_dir, "gpl_contents.txt")
    with open(output_file_path, "w") as f:
        # Loop through the lines in the file and write the color numbers and RGB values to the output file
        for i, line in enumerate(contents):
            if not line.startswith("#"):
                values = line.strip().split("\t")
                len_values = len(values)
                if len_values >= 4:
                    r, g, b, name = values[:4]
                    rgb = (int(r), int(g), int(b))
                    color_num = i - 3  # subtract 3 to skip the header lines
                    # Write the color number and RGB values to the output file
                    line_text = "Color number {}: RGB values = ({}, {}, {})\n".format(color_num, r, g, b)
                    f.write(line_text)
                else:
                    message = "Length: {}\n".format(len_values)
                    f.write(message)

    pdb.gimp_message("Color values written to file!")

register(
    "convert-for-atari",
    "Grayscale Conversion for Atari",
    "Converts an image to grayscale and back to RGB using the custom palette 'atarigray'",
    "Author Name", "Author Name", "Year",
    "Convert for Atari",
    "RGB", 
    [
        (PF_IMAGE, "img", "Takes current image", None),
        (PF_DRAWABLE, "srclayer", "Input layer", None)
    ],
    [],
    convert_for_atari, menu="<Image>/Filters/Test")

main()
