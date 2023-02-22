import gimp
import os
from gimpfu import *

def convert_for_atari(img, srclayer):
    try:
        pdb.gimp_message("Running grayscale conversion...")
        pdb.gimp_image_undo_group_start(img)

        layer = srclayer.copy()
        img.add_layer(layer, 0) 
        width = layer.width
        height = layer.height

        # Convert image to grayscale
        pdb.gimp_message("Starting grayscale conversion...")
        for y in range(height):
            for x in range(width):
                r, g, b = layer.get_pixel(x, y)
                gray = (r + g + b) // 3 # Averaging RGB to B/W formula
                layer.set_pixel(x, y, (gray, gray, gray))

        # Convert image to indexed with custom palette "atarigray"
        pdb.gimp_message("Converting to indexed with palette 'atarigray'...")
        pdb.gimp_image_convert_indexed(img, 0, 4, 256, False, False, "atarigray")

        # Convert image back to RGB
        pdb.gimp_message("Converting back to RGB...")
        pdb.gimp_image_convert_rgb(img)

        min_luminance_array = []
        max_luminance_array = []
        closest_min_luminance_array = []
        closest_max_luminance_array = []

        for y in range(height):
            min_luminance = 255
            max_luminance = 0
            closest_min_luminance = 0
            closest_max_luminance = 0
            for x in range(width):
                r, g, b = layer.get_pixel(x, y)
                luminance = (0.21 * r) + (0.72 * g) + (0.07 * b)
                min_luminance = min(min_luminance, luminance)
                max_luminance = max(max_luminance, luminance)

            # Set closest color value for min and max luminance
            closest_min_luminance = round((min_luminance / 255) * 7)
            closest_max_luminance = round((max_luminance / 255) * 7)

            # Save the closest color values to an array
            min_luminance_array.append(min_luminance)
            max_luminance_array.append(max_luminance)
            closest_min_luminance_array.append(closest_min_luminance)
            closest_max_luminance_array.append(closest_max_luminance)

        # Write the luminance levels and closest color values to a text file
        with open("luminance_levels.txt", "w") as f:
            for y in range(height):
                f.write("Line " + str(y) + ": Min Luminance = " + str(min_luminance_array[y]) + ", Max Luminance = " + str(max_luminance_array[y]) + ", Closest Min Color Value = " + str(closest_min_luminance_array[y]) + ", Closest Max Color Value = " + str(closest_max_luminance_array[y]) + "\n")

        layer.flush()
        layer.update(0,0,width,height)
        pdb.gimp_image_undo_group_end(img)
        pdb.gimp_message("Grayscale conversion finished!")

    except Exception as err:
        pdb.gimp_message("ERROR: " + str(err))
        pdb.gimp_image_undo_group_end(img)

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
