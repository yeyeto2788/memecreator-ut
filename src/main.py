"""
 Copyright (C) 2022  Juan Biondi

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 memecreator is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""

import os
import sys

lib_path = os.path.join(
    os.path.abspath(os.path.dirname(os.path.dirname(__file__))),
    "python-lib",
)
sys.path.append(lib_path)

from datetime import datetime

# from PIL import Image, ImageFont, ImageDraw
import utils_config


def execute(text):
    print(text)
    # return create_meme(infile="", text="UT MEME")
    config_file = os.path.join(lib_path, "config.json")
    config = utils_config.load_config(config_file)
    return "{text}{config}".format(text=text, config=config)


# def create_meme(infile, text):
#     timestamp = datetime.now().timestamp()
#     i = os.path.join(lib_path, "test.png")
#     font_file = os.path.join(lib_path, "PublicSans-VariableFont_wght.ttf")

#     with Image.open(i) as im:
#         # with Image.open(infile) as im:
#         draw = ImageDraw.Draw(im)
#         # use a bitmap font
#         font = ImageFont.truetype(font_file, 15)
#         draw.text((10, 10), text.title(), font=font)
#         # use a truetype font
#         draw.text((10, 25), text.title(), font=font)

#         # write to stdout
#         im.save("result.png", "PNG")
#     return font_file
