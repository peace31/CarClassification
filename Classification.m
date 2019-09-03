clc;
clear;
close all;
keySet= {'honda civic', 'honda crv', 'honda fit', 'nissan cefiro','nissan livena','nissan march','nissan sentra','nissan tena','nissan xtrail','toyota altis','toyota camry','toyota innova','toyota previa','toyota rav','toyota surf','toyota tercel','toyota vios','toyota wish','toyota yaris'};
valueSet =keySet;
mapObj = containers.Map(keySet,valueSet);
save catmatch.mat mapObj
%% Load the entire folder containing training images
trainfolder = 'F:\Mycompleted task\object tracking\car_detection\train_data';
train_images = imageDatastore(trainfolder, 'IncludeSubfolders',true,'LabelSource','foldernames'); 
%% A test of successful loading of the images and the number 
%% Create Visual Vocabulary using the Bag of features function
surf_features = bagOfFeatures(train_images, 'VocabularySize', 1000);
feature_vector = double(encode(surf_features, train_images));
%% Use the new features to train a model and assess its performance using 
%classificationLearner
categoryClassifier = trainImageCategoryClassifier(train_images, surf_features);

try
    save db.mat categoryClassifier
catch
    db=categoryClassifier; 
    save db.mat db
end
