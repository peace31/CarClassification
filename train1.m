clc;
clear;
close all;
keySet= {'ToyotaVios', 'ToyotaAltis', 'ToyotaCamry'};
valueSet =keySet;
mapObj = containers.Map(keySet,valueSet);
save catmatch1.mat mapObj
%% Load the entire folder containing training images
trainfolder = 'F:\Mycompleted task\object tracking\car_detection\train_data1';
train_images = imageDatastore(trainfolder, 'IncludeSubfolders',true,'LabelSource','foldernames'); 
%% A test of successful loading of the images and the number 
%% Create Visual Vocabulary using the Bag of features function
surf_features = bagOfFeatures(train_images, 'VocabularySize', 1000);
feature_vector = double(encode(surf_features, train_images));
%% Use the new features to train a model and assess its performance using 
%classificationLearner
categoryClassifier = trainImageCategoryClassifier(train_images, surf_features);

try
    save db1.mat categoryClassifier
catch
    db=categoryClassifier; 
    save db1.mat db
end
