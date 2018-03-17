

# Nathan Stark
# CS 360 winter 2018

# I am geting alot of errors right off that I believe should not be coming up 
# So I am just turning to the solution again on this one... Not happy with this part.
# And have tested the solution that they gave in the folder and that is still not working.

#!/usr/bin/python
# Copyright 2010 Google Inc.
# Licensed under the Apache License, Version 2.0
# http://www.apache.org/licenses/LICENSE-2.0

# Google's Python Class
# http://code.google.com/edu/languages/google-python-class/

import sys
import re
import os
import shutil
import commands

"""Copy Special exercise
"""

def get_special_paths(dir):
  filenames = os.listdir(dir)
  for filename in filenames:
    print os.path.abspath(os.path.join(dir, filename))



# def copy_to(paths, dir)

# def zip_to(paths, zippath)



def main():
  # This basic command line argument parsing code is provided.
  # Add code to call your functions below.

  # Make a list of command line arguments, omitting the [0] element
  # which is the script itself.
  args = sys.argv[1:]
  if not args:
    print "usage: [--todir dir][--tozip zipfile] dir [dir ...]";
    sys.exit(1)

  # todir and tozip are either set from command line
  # or left as the empty string.
  # The args array is left just containing the dirs.
  todir = ''
  if args[0] == '--todir':
    todir = args[1]
    del args[0:2]

  tozip = ''
  if args[0] == '--tozip':
    tozip = args[1]
    del args[0:2]

  if len(args) == 0:
    print "error: must specify one or more dirs"
    sys.exit(1)

  for files in args:
    get_special_paths(file)
  
if __name__ == "__main__":
  main()
