#!/usr/bin/env python

from gimpfu import *
import os

def convert_for_atari(img, src_layer):
    try:
        pdb.gimp_image_undo_group_start(img)

        # Copy source layer and add it to image
        layer = src_layer.copy()
        img.add_layer(layer, 0) 

        # Convert layer to grayscale
        grayscale_conversion(layer)
         
        # Convert image to indexed with custom palette "atarigray"
        pdb.gimp_message("Converting to indexed with palette 'atarigray'...")
        pdb.gimp_image_convert_indexed(img, 0, 4, 256, False, False, "atarigray")

        # Convert image back to RGB
        pdb.gimp_message("Converting back to RGB...")
        pdb.gimp_image_convert_rgb(img)

        # Write luminance levels
        write_luminance_levels(layer)

        # Write color values to .gpl file
        write_color_values()

        # Flush and update layer
        layer.flush()
        layer.update(0,0,layer.width,layer.height)

        # End undo group and display success message
        pdb.gimp_image_undo_group_end(img)
        pdb.gimp_message("Grayscale conversion finished!")

    except Exception as err:
        # Display error message and end undo group
        pdb.gimp_message("ERROR: " + str(err))
        pdb.gimp_image_undo_group_end(img)

def grayscale_conversion(layer):
    # Display starting message
    pdb.gimp_message("Starting grayscale conversion...")

    # Get layer dimensions
    width, height = layer.width, layer.height

    # Loop through every pixel in the layer and convert to grayscale
    for y in range(height):
        for x in range(width):
            r, g, b = layer.get_pixel(x, y)
            gray = (r + g + b) // 3  # Average RGB to B/W formula
            layer.set_pixel(x, y, (gray,) * 3)

    # Display success message
    pdb.gimp_message("Grayscale conversion finished!")

def write_luminance_levels(layer):
    pdb.gimp_message("Writing luminance levels to file...")

    # Get layer dimensions
    width = layer.width
    height = layer.height
    
    # Loop through every pixel in the layer and calculate the min and max luminance
    min_luminance_array = [min([0.21*r + 0.72*g + 0.07*b for r, g, b in [layer.get_pixel(x, y) for x in range(width)]]) for y in range(height)]
    max_luminance_array = [max([0.21*r + 0.72*g + 0.07*b for r, g, b in [layer.get_pixel(x, y) for x in range(width)]]) for y in range(height)]
    
    # Round the calculated luminance values to the closest color value on the Atari palette
    closest_min_luminance_array = [round((min_luminance / 255) * 7) for min_luminance in min_luminance_array]
    closest_max_luminance_array = [round((max_luminance / 255) * 7) for max_luminance in max_luminance_array]

    # Write the luminance levels to a file
    with open("luminance_levels.txt", "w") as f:
        for y in range(height):
            f.write("Line " + str(y) + ": Min Luminance = " + str(min_luminance_array[y]) + ", Max Luminance = " + str(max_luminance_array[y]) + ", Closest Min Color Value = " + str(closest_min_luminance_array[y]) + ", Closest Max Color Value = " + str(closest_max_luminance_array[y]) + "\n")

    # Display success message
    pdb.gimp_message("Luminance levels written to file!")

def write_color_values():
    # Display a message
    pdb.gimp_message("Writing color values to file...")

    # Set the file path
    file_path = os.path.join(os.getenv('APPDATA'), 'GIMP', '2.10', 'palettes', 'atarigray.gpl')

    # Open the output file for writing
    output_file_path = os.path.join(os.path.expanduser("~"), "gpl_contents.txt")

    # Loop through the lines in the file and write the color numbers and RGB values to the output file
    with open(file_path) as f, open(output_file_path, "w") as output_file:
        color_num = -1
        for line in f:
            if not line.startswith("#"):
                values = line.strip().split()
                if len(values) >= 4:
                    r, g, b = values[:3]
                    color_num += 1
                    # Write the color number and RGB values to the output file
                    output_file.write("Color number {}: RGB values = ({}, {}, {})\n".format(color_num, r, g, b))
                else:
                    output_file.write("Length: {}\n".format(len(values)))

    # Display a message
    pdb.gimp_message("Color values written to file!")


register(
    "convert-for-atari",
    "Grayscale Conversion for Atari",
    "Converts an image to grayscale and back to RGB using the custom palette 'atarigray'",
    "Ron Dekoker", "Ron Dekoker", "2023",
    "Convert for Atari",
    "RGB", 
    [
        (PF_IMAGE, "img", "Takes current image", None),
        (PF_DRAWABLE, "srclayer", "Input layer", None)
    ],
    [],
    convert_for_atari, menu="<Image>/Filters/Test")

main()
