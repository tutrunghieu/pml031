# A course project pml031
To build a prediction system using R based on the given training/testing dataset 

## Part 1, to find a model that fits pml-training.csv

When the learning table we have with 19622 rows and 160 columns, we need to reduce the size of the table before we can fit the model in it. Otherwise, it will take forever to complete the training. <br>

To select the rows for training, we can use createDataPartition(y=classColumn, p=0.7, list=FALSE). For the long table with just five classes, we don't need to select p=0.7 we can use p=0.1 or p=0.2 to reduce the training size to test the prediction model and the whole process first. Of course, low p implies smaller training data and higher error. But we can still set p=0.7 after have done the whole proces.

To select columns for training, we need to remove NA columns first. They will not contribute to training/prediction process. Then we can select few variables / predictors to fit the model. We cannot use all the predictors.

See [CodePart1.R](https://github.com/tutrunghieu/pml031/blob/master/CodePart1.R) for <b>runnable</b> version and [CodePart1.md](https://github.com/tutrunghieu/pml031/blob/master/CodePart1.md) for <b>readable</b> version.

## Part 2, to label samples in pml-testing.csv

Now that we have the reliable prediction model (small training error, small testing error), we can apply the model to predict new data. 

We have to set up a new process for the unlabelled data and we will fill the last column of the table with the predicted values. This leads to the reuse of feature transformation model (the variable selector) and the trained model. In our implementation, we train and use the model directly. Therefore when we have updated training data, we only have to run the whole program again.

See [CodePart2.R](https://github.com/tutrunghieu/pml031/blob/master/CodePart2.R) for <b>runnable</b> version and [CodePart2.md](https://github.com/tutrunghieu/pml031/blob/master/CodePart2.md) for <b>readable</b> version.

<img src='https://cloud.githubusercontent.com/assets/2976884/9427722/7a6ddb8c-49b6-11e5-9a8f-07699f80425c.png'>
