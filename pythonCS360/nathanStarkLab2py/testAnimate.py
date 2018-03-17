
# Nathan Stark
# CS 360 winter
# python Lab


import os
import math
import re

# the number of frames that will be in the movie.
number_of_frames = 10


def make_image():
  print 'making image'


  fin = open('C:\\Users\\nstar\\Desktop\\CS\\CS360\\past360\\Lab2py\\base.pov')
  sdl = fin.read() # Read the entire file into a string
  fin.close()
  # Now you have the entire POV source code in the string sdl

  sdl_new = ''
  outfile = 'tmp.pov'
  fout = open( outfile, 'w')
  fout.write(sdl_new)
  fout.close()


  #...
  pov_cmd ='a user path\\POV-Ray\\v3.7\\bin\\pvengine.exe +I%s +O%s -D -V +A /EXIT +H600 +W800'
  cmd = pov_cmd % ("tmp.pov","tmp5.png")
  os.system(cmd)


  #
  # Now make the movie
  #
  print 'Encoding movie'

  os.system( 'mencoder.exe mf://tmp*.png -mf type=png:fps=25 -ovc lavc -lavcopts \
        vcodec=msmpeg4:vbitrate=2160000:keyint=5:vhq -o movie.avi ' )
  
def main():
  make_image()


# Standard boilerplate to call the main() function.
if __name__ == '__main__':
  main()