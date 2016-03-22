##########################
# start stage 1 training #
##########################
cd torso

## create simulinks

# image data
ln -s ../../data/Pascal-Part
# training / validataion imageset
ln -s ../../data/imagesets/part_trainval_imgset/torso
# caffe
ln -s ../../caffe
# pre-trained caffe model (VGG16 - fully convolution)
ln -s ../../model
# training result saving path
ln -s ../../model/torso_train_result

## create directories
mkdir snapshot
mkdir training_log

## start training
./start_train.sh

## copy and rename trained model
cp ./snapshot/torso_train_iter_20000.caffemodel ./torso_train_result/torso_train_result.caffemodel
