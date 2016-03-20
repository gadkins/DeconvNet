##########################
# start stage 1 training #
##########################
cd part_001_stage_1

## create simulinks

# image data
ln -s ../../data/Pascal-Part
# training / validataion imageset
ln -s ../../data/imagesets/part_stage_1_train_imgset
# caffe
ln -s ../../caffe
# pre-trained caffe model (VGG16 - fully convolution)
ln -s ../../model
# training result saving path
ln -s ../../model/part_stage_1_train_result

## create directories
mkdir snapshot
mkdir training_log

## start training
./start_train.sh

## copy and rename trained model
cp ./snapshot/part_stage_1_train_iter_5000.caffemodel ./part_stage_1_train_result/part_stage_1_train_result.caffemodel
