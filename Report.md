# A report on building a prediction model for course Practical Machine Learning from 03-aug-2015 to 31-aug-2015
(Henry T.H. Tu, 23-aug-2015)

## 1. Problem
+ Our main task is to label the instances or rows in the file pml-testing.csv given the training data we have in pml-training.csv

+ It is not straight-forward to load the table pml-training.csv and fit any learning model to the table because the table is large (19622 rows and 160 columns) and it is very slow to learn any training model. We need to quickly locate the model we want in few hours. We decided to reduce the size of the table before applying any model.

<img src='https://cloud.githubusercontent.com/assets/2976884/9428128/51e20252-49c9-11e5-979d-1a67b078e79a.png'>


+ We completed 3 tasks to solve the problem:

+ So the first task (see section 2) is to shrink (reducing the rows and columns) the table into a smaller size so that we can test the data set against many models as we can before we can end up with the optimal one.

+ And the second task (see section 3 and 4 and 5) is to select a model (random forest, naïve Bayes classifier, boosting, classification tree, LDA) to fit the model.

+ And finally (see section 6 and 7), when we have the reliable model, we only have to use it to label / predict the examples in the file pml-testing.csv

 

## 2. Shrinking the training table
+ We cannot fit the model with 160 variables and we saw that many columns contains blank (NA) values. Therefore, our first task is to remove those columns and we can reduce the size of the table.

+ Given the the data, we can use the following procedure to select columns containing NA values.

<img src='https://cloud.githubusercontent.com/assets/2976884/9428129/562126d6-49c9-11e5-82dd-ca633d867673.png'>

+ In fact, we saw that the first variables (after removing NA columns) are enough to have good training results without using all the variables. In our code, we choose to use the several fields (see section 5). But our code is flexible enough to test with different column sets (predictor sets).

+ We also tried to apply PCA processing with preprocess='pca' but the result got worse. We have to admit that PCA was not our choice to reduce the dimensionality of the table.

 

## 3. Selecting the learning model
+ When we have the small data table (in our case, we have around 1000 rows and 6 columns), we can fit many models as we can within an hour.

+ We tried different model, including method='nb', method='rpart', method='rf', and we saw that method='rf' is the one with smallest values. Therefore, we choose to use Random Forest as the learning model in the next sections.

<img src='https://cloud.githubusercontent.com/assets/2976884/9428131/59025bb8-49c9-11e5-9b67-a1a6c1ab5876.png'>


##  4. Flipping the coin: changing the training size
+ In our model, the training size is controlled by the coin. We use small value p=0.1 implies or n=19622*0.1 training rows in building the model.

+ We can use p=0.7 and we see that there is only 1 error in nearly 6000 testing items.

<img src='https://cloud.githubusercontent.com/assets/2976884/9428132/5b7286c0-49c9-11e5-8d3f-b4de82e23932.png'>

Run the file CodePart1-changing-trainsize.R to see the following table
 

 

##  5. The model we have chosen
+ We use p = 0.7 in training to reduce both training/testing errors before we apply to the unlabeled data in the pml-testing.csv file

+ We use method='rf' to get minimal error in the training dataset
<img src='https://cloud.githubusercontent.com/assets/2976884/9428133/5feb8dbe-49c9-11e5-9e86-b2123b560462.png'>

##  6. Applying the model to pml-testing.csv
+ In our framework, we transform both data files in the same manner. Therefore, they will have the same schema / structure and they can be used in the same model.

+ To do that, we develop the functions (load2, select2, fit2) which works in both files in variable selection and in training/testing. Please refer to the file CodePart2.R for the details.

 

## 7. The final result on pml-testing.csv
<img src='https://cloud.githubusercontent.com/assets/2976884/9428134/64a9cb4a-49c9-11e5-9e6c-33858d4a0201.png'>
