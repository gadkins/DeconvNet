# Given a directory of images, split them into training and validation sets
# Output the filename and corresponding label map to train.txt or val.txt

from os import listdir, walk
from os.path import abspath, join
import random
import math

data_root = "/home/cv/DeconvNet/data/Pascal-Part"
# Location of training images
img_dir = "/images/person/torso/"

# Location of corresponding annotations (segmentation labels)
seg_dir = "/segmentations/person/torso/"

# Location to store train.txt and val.txt
imgsets_dir = "/home/cv/DeconvNet/data/imagesets/part_stage_1_train_imgset/"
train = imgsets_dir+"train.txt"
val = imgsets_dir+"val.txt"

# Training & validation split ratio
train_ratio = 0.7


# Build imageset
img_files=[]
seg_files=[]
imgset = []

for dirpath,_,filenames in walk(data_root+img_dir):
	for f in filenames:
		img_files.append(join(img_dir,f))
		seg_files.append(join(seg_dir,f))

for i in zip(img_files,seg_files):
	imgset.append(" ".join(i))


# Split training and validation
random.shuffle(imgset)
size = len(imgset)
train_size = int(math.ceil(size*train_ratio))
train_set = imgset[:train_size]
val_set = imgset[train_size:]
train_set.sort()
val_set.sort()


train_file = open(train, 'w+')
for t in train_set:
	train_file.write("%s\n" % t)
train_file.close()

val_file = open(val, 'w+')
for v in val_set:
	val_file.write("%s\n" % v)
val_file.close()
