%% Load10.m
%Abigail G Basener
%Packges: Computer Vision Toolbox
%Sourses:
%Johanna Pingel (2021). Image Recognition using Machine Learning Demo (https://www.mathworks.com/matlabcentral/fileexchange/62193-image-recognition-using-machine-learning-demo), MATLAB Central File Exchange. Retrieved May 24, 2021. 

%% Laoding Images
imds = imageDatastore('DisData','IncludeSubfolders',true,'LabelSource','foldernames');
imds.ReadFcn = @readAndResizeImages;
imdsD = imageDatastore('Data','IncludeSubfolders',true,'LabelSource','foldernames');
imdsD.ReadFcn = @readAndResizeImages;
tbl = countEachLabel(imds); % Shows name and # of samples
categories = tbl.Label;

visImds = splitEachLabel(imds,1,'randomize');

%% Create Bag samples 
[training_set, test_set] = imds.splitEachLabel(20,10,'randomize',true);
bag = bagOfFeatures(imageSet(imdsD.Files),...
'VocabularySize',150,'PointSelection','Detector');
scenedata = double(encode(bag,imageSet(training_set.Files)));

%% Create a Table using the encoded features
SceneImageData = array2table(scenedata);
%sceneType = categorical(repelem({training_set.Description}', [training_set.Count], 1));
SceneImageData.sceneType = training_set.Labels;

%% Visualize Feature Vectors
% imgs = training_set.splitEachLabel(1,'randomize',true);
% img = readimage(imgs,2);
% featureVector = encode(bag, img);
% subplot(4,2,1); imshow(img);
% subplot(4,2,2);
% bar(featureVector);title('Features Occurrences');xlabel('Features Index');ylabel('Frequency');
% img = readimage(imgs,3);
% featureVector = encode(bag, img);
% subplot(4,2,3); imshow(img);
% subplot(4,2,4); 
% bar(featureVector);title('Features Occurrences');xlabel('Features Index');ylabel('Frequency');
% img = readimage(imgs,4);
% featureVector = encode(bag, img);
% subplot(4,2,5); imshow(img);
% subplot(4,2,6); 
% bar(featureVector);title('Features Occurrences');xlabel('Features Index');ylabel('Frequency');
% img = readimage(imgs,6);
% featureVector = encode(bag, img);
% subplot(4,2,7); imshow(img);
% subplot(4,2,8); 
% bar(featureVector);title('Features Occurrences');xlabel('Features Index');ylabel('Frequency');

%% Trying somthing else
% 
% % Load pretrained network
% net = resnet50();
% % Visualize the first section of the network. 
% figure
% plot(net)
% title('First section of ResNet-50')
% set(gca,'YLim',[150 170]);
% % Inspect the first layer
% net.Layers(1)
% % Inspect the last layer
% net.Layers(end)
% % Number of class names for ImageNet classification task
% numel(net.Layers(end).ClassNames)

%% Use the new features to train a model and assess its performance using 
classificationLearner
% 
% %% Test out accuracy on test set!
% testSceneData = double(encode(bag, test_set));
% testSceneData = array2table(testSceneData,'VariableNames',trainedClassifier.RequiredVariables);
% actualSceneType = test_set.Labels;
% predictedOutcome = trainedClassifier.predictFcn(testSceneData);
% correctPredictions = (predictedOutcome == actualSceneType);
% validationAccuracy = sum(correctPredictions)/length(predictedOutcome);
