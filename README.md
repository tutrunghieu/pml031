# pml031
To build a prediction system using R

## Part 1, to select and to build a model with small training/testing error

When the learning table we have with 19622 rows and 160 columns, we need to reduce the size of the table before we can fit the model in it. Otherwise, it will take forever to complete the training. <br>

To select the rows for training, we can use createDataPartition(y=classColumn, p=0.7, list=FALSE). For the long table with just five classes, we don't need to select p=0.7 we can use p=0.1 or p=0.2 to reduce the training size to test the prediction model and the whole process first. Of course, low p implies smaller training data and higher error. But we can still set p=0.7 after have done the whole proces.

To select columns for training, we need to remove NA columns first. They will not contribute to training/prediction process. Then we can select few variables / predictors to fit the model. We cannot use all the predictors.

See [CodePart1.R](https://github.com/tutrunghieu/pml031/blob/master/CodePart1.md) for <b>runnable</b> version and <b>CodePart1.md</b> for <b>readable</b> version.

## Part 2, to predict unlabled samples

Now that we have the reliable prediction model (small training error, small testing error), we can apply the model to predict new data. 

We have to set up a new process for the unlabelled data and we will fill the last column of the table with the predicted values. This leads to the reuse of feature transformation model (the variable selector) and the trained model. In our implementation, we train and use the model directly. Therefore when we have updated training data, we only have to run the whole program again.

See <b>CodePart2.R</b> for <b>runnable</b> version and <b>CodePart2.md</b> for <b>readable</b> version.
