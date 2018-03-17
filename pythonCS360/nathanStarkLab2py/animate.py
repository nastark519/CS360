
# Nathan Stark
# CS 360 winter
# python Lab
#
# I was assisted with this lab by Khorben Boyer


import os
import math
import re

# the number of frames that will be in the movie.
# This makes sense to be outside of the class
# as I don't want to change it once the code is running.
number_of_frames = 25

class Movie:

  cam_r = 360


  # the name_tag will be used to name the frames exp. tmp001, tmp002 and so on.
  def __init__(self, name_tag):

    # make a list to hold the images
    self.image_list = []
    self.sdl = []
    # set the name of the file something like tmp
    self.name_tag = name_tag

#  def make_image(): I don't think that I need this anymore.
#    print 'making image'

  def file_set_up(self):
    fin = open('lab1PRNathanStark.pov')
    sdl = fin.read() # Read the entire file into a string
    # Now you have the entire POV source code in the string sdl
    self.sdl.append(sdl)
    fin.close()

  def write_to_file(self, outfile):
    # sdl_new = ''
    # outfile = 'tmp.pov'
    fout = open( outfile + '.pov', 'w')
    fout.write(self.image_list[0])
    fout.close()

  def render_image(self, name_tag):
    # path to execute POV-ray program with using the chosen file
    pov_cmd ='a users path\POV-Ray\\v3.7\\bin\\pvengine.exe +I%s +O%s -D -V +A /EXIT +H600 +W800'
    # it is important to take note of the '.pov' and the '.png' for the types of files we want.
    cmd = pov_cmd % (name_tag + '.pov', name_tag + '.png')
    os.system(cmd)

    # Now make the movie
  def make_movie(self):
    #
    # Now make the movie
    #
    print 'Encoding movie'
    
    os.system( 'mencoder.exe mf://tmp*.png -mf type=png:fps=25 -ovc lavc -lavcopts \
      vcodec=msmpeg4:vbitrate=2160000:keyint=5:vhq -o movie.avi ' )

  def change_camera(self, tup):
    # replacement for the location.
    changed_vect = 'location <%.1f,%.1f,%.1f>' % (tup[0],tup[1],tup[2])

    # switch the string thats in there with the new one using re.sub function.
    new_location = re.sub(r'location\s\<(\S+)\>', changed_vect, self.sdl[0])
    self.image_list.append(new_location)

  def helix(self, **keyword):
    x = (keyword['r']*2)*(math.cos(keyword['degree'])*(math.pi/180))
    y = keyword['h']/360*keyword['degree']
    z = (keyword['r']*2)*(math.sin(keyword['degree'])*(math.pi/180))

    new_vect = (x,y,z)
    return new_vect

  def new_object(self, tup):
    # here note the }, we know that the compiler will look for the first regular expr.
    # that matchs. We will use this to our lazy advantage.
    new_obj_str ='}\
       sphere{<%.2f,%.2f,%.2f>,1 pigment{color rgb <1,0,2>}}\
       light_source{' % (1 - tup[0],5,1 - tup[2])

    add_obj = re.sub(r'}(\n)light_source{', new_obj_str, self.image_list[0])
    self.image_list[0] = add_obj


def main():

  # init. the count, in order for the increments of the name tags to make sense
  # I want to do this outside of the loop that will be coming.
  count = 0
  # start with the tag as image001.png|image001.pov
  image_tag = 1

  # starting points for the camera.
  cam_h = 6
  cam_degree = 15


  while (count < number_of_frames):
    image_target = 'tmp' + str(image_tag).zfill(3)

    image_tag += 1
    count += 1
    
    movie = Movie(image_target)
    
    movie.file_set_up()
    
    tuple_helix = movie.helix(r = movie.cam_r, h = cam_h, degree = cam_degree)
    movie.change_camera(tuple_helix)
    movie.new_object(tuple_helix)
    
    cam_h = cam_h + .2
    cam_degree += .1
    
    movie.write_to_file(movie.name_tag)
    movie.render_image(movie.name_tag)



  # This method will execute last to make the short film.
  movie.make_movie()


# Standard boilerplate to call the main() function.
if __name__ == '__main__':
  main()