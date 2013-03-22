# (c) 2013 Felipe C. da S. Sanches <juca@members.fsf.org>
# Licensed under the terms of the GNU General Public License
# version 3 (or later).

pixelbuffer = []
WIDTH=24
HEIGHT=16
for x in range(WIDTH):
  column = []
  for y in range(HEIGHT):
    column.append(0)
  pixelbuffer.append(column)

def draw():
  pixels = []
  for x in range(WIDTH):
    for y in range(HEIGHT):
      if (pixelbuffer[x][y]):
        pixels.append("true")
      else:
        pixels.append("false")

  code = "dmd_image = ["+ ','.join(pixels) +"];\n"
  open("dmd_image.scad", "w").write(code)


from math import sqrt
import time
def draw_circle(cx, cy, r):
  for x in range(WIDTH):
    for y in range(HEIGHT):
      if sqrt((x-cx)**2 + (y-cy)**2) <= r:
        pixelbuffer[x][y]=1
      else:
        pixelbuffer[x][y]=0

r = 8
cx = 0
cy = 7.5
while True:
  cx= (cx+1)%24
  draw_circle(cx, cy, r)
  draw()
  print cx
  time.sleep(1)

