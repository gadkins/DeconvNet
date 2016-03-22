import caffe, lmdb
import numpy as np
from os import walk
from os.path import join
from PIL import Image

img_dir = '/home/cv/DeconvNet/data/Pascal-Part/images/person/torso/'
img_files = []
for dirpath,_,filenames in walk(img_dir):
	for f in filenames:
		img_files.append(join(img_dir,f))


in_db = lmdb.open('train-img-torso-lmdb', map_size=int(1e12))
with in_db.begin(write=True) as in_txn:
    for in_idx, in_ in enumerate(img_files):
        # load image:
        # - as np.uint8 {0, ..., 255}
        # - in BGR (switch from RGB)
        # - in Channel x Height x Width order (switch from H x W x C)
        im = np.array(Image.open(in_)) # or load whatever ndarray you need
        im = im[:,:,::-1] # note: -1 reverses channel order to BGR
        im = im.transpose((2,0,1))
        im_dat = caffe.io.array_to_datum(im)
        in_txn.put('{:0>10d}'.format(in_idx), im_dat.SerializeToString())
in_db.close()


# Segmentation images are single channel, thus channel swapping is not performed
# Instead, a channel dimension is enforced (i.e. 1x250x250)
seg_dir = '/home/cv/DeconvNet/data/Pascal-Part/segmentations/person/torso/'
seg_files = []
for dirpath,_,filenames in walk(seg_dir):
	for f in filenames:
		seg_files.append(join(seg_dir,f))

in_db = lmdb.open('train-seg-torso-lmdb', map_size=int(1e12))
with in_db.begin(write=True) as in_txn:
    for in_idx, in_ in enumerate(seg_files):
        # load image:
        # - as np.uint8 {0, ..., 255}
        # - in BGR (switch from RGB)
        # - in Channel x Height x Width order (switch from H x W x C)
        im = np.array(Image.open(in_),ndmin=3) # Sets channel = 1
        im_dat = caffe.io.array_to_datum(im)
        in_txn.put('{:0>10d}'.format(in_idx), im_dat.SerializeToString())
in_db.close()
