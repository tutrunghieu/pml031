# A report on building a prediction model for course Practical Machine Learning from 03-aug-2015 to 31-aug-2015
(Henry T.H. Tu, 23-aug-2015)

## 1. Problem
+ Our main task is to label the instances or rows in the file pml-testing.csv given the training data we have in pml-training.csv

+ It is not straight-forward to load the table pml-training.csv and fit any learning model to the table because the table is large (19622 rows and 160 columns) and it is very slow to learn any training model. We need to quickly locate the model we want in few hours. We decided to reduce the size of the table before applying any model.

pml-training:  19622 160
pml-testing.csv :  20 160
 
### Table 1: the sizes of the training/testing data
 

+ We completed 3 tasks to solve the problem:

+ So the first task (see section 2) is to shrink (reducing the rows and columns) the table into a smaller size so that we can test the data set against many models as we can before we can end up with the optimal one.

+ And the second task (see section 3 and 4 and 5) is to select a model (random forest, naïve Bayes classifier, boosting, classification tree, LDA) to fit the model.

+ And finally (see section 6 and 7), when we have the reliable model, we only have to use it to label / predict the examples in the file pml-testing.csv

 

## 2. Shrinking the training table
+ We cannot fit the model with 160 variables and we saw that many columns contains blank (NA) values. Therefore, our first task is to remove those columns and we can reduce the size of the table.

+ Given the the data, we can use the following procedure to select columns containing NA values.

F <- names(data); cols <- dim(data)[2];
sel <- c(1, 2, 3, 4, 5);
for(k in 1:160)
{
                   hasNA <- 0; X <- data[,k];
                   for(x in X) if( is.na(x) ) hasNA <- hasNA + 1;
                   if( hasNA > 0 ) sel <- c(sel, k);
}
data <- data[, -sel];
### Table 2: the code to select the predictors / columns
+ In fact, we saw that the first variables (after removing NA columns) are enough to have good training results without using all the variables. In our code, we choose to use the several fields (see section 5). But our code is flexible enough to test with different column sets (predictor sets).

+ We also tried to apply PCA processing with preprocess='pca' but the result got worse. We have to admit that PCA was not our choice to reduce the dimensionality of the table.

 

## 3. Selecting the learning model
+ When we have the small data table (in our case, we have around 1000 rows and 6 columns), we can fit many models as we can within an hour.

+ We tried different model, including method='nb', method='rpart', method='rf', and we saw that method='rf' is the one with smallest values. Therefore, we choose to use Random Forest as the learning model in the next sections.

-------Splitting
Training coin:  0.1
Training size:  1964 6
Testing size:  17658 6
 
-------Splitting
Training coin:  0.1
Training size:  1964 6
Testing size:  17658 6
 
-------Splitting
Training coin:  0.1
Training size:  1964 6
Testing size:  17658 6
 
-------Fitting
Model:  nbModel size:  23
-------Evaluation
Training error 1154  or  0.5875764
Testing error 10448  or  0.5916865
 
-------Fitting
Model:  rfModel size:  23
-------Evaluation
Training error 0  or  0
Testing error 286  or  0.01619662
 
-------Fitting
Model:  rpartModel size:  23
-------Evaluation
Training error 1166  or  0.5936864
Testing error 10721  or  0.6071469
 
### Table 3: what is the learning model? Run the file CodePart1-model-selection.R to see this table
 

##  4. Flipping the coin: changing the training size
+ In our model, the training size is controlled by the coin. We use small value p=0.1 implies or n=19622*0.1 training rows in building the model.

+ We can use p=0.7 and we see that there is only 1 error in nearly 6000 testing items.

-------Splitting
Training coin:  0.1
Training size:  1964 6
Testing size:  17658 6
 
-------Splitting
Training coin:  0.2
Training size:  3927 6
Testing size:  15695 6
 
-------Splitting
Training coin:  0.5
Training size:  9812 6
Testing size:  9810 6
 
-------Splitting
Training coin:  0.7
Training size:  13737 6
Testing size:  5885 6
 
-------Fitting
Model size:  23
-------Evaluation
Training error 0  or  0
Testing error 236  or  0.01336505
 
-------Fitting
Model size:  23
-------Evaluation
Training error 0  or  0
Testing error 109  or  0.006944887
 
-------Fitting
Model size:  23
-------Evaluation
Training error 0  or  0
Testing error 8  or  0.0008154944
 
-------Fitting
Model size:  23
-------Evaluation
Training error 0  or  0
Testing error 1  or  0.0001699235
 
###  Table 4: what is the optimal training size?
 
Run the file CodePart1-changing-trainsize.R to see the following table
 

 

##  5. The model we have chosen
+ We use p = 0.7 in training to reduce both training/testing errors before we apply to the unlabeled data in the pml-testing.csv file

+ We use method='rf' to get minimal error in the training dataset

training predictors =  [ new_window num_window roll_belt pitch_belt yaw_belt *classe ]
 
testing predictors =  [ new_window num_window roll_belt pitch_belt yaw_belt *problem_id]
 
p = 0.7
 
method = 'rf'
###  Table 5: our final model to label pml-training.csv
 

 

 

 

 

##  6. Applying the model to pml-testing.csv
+ In our framework, we transform both data files in the same manner. Therefore, they will have the same schema / structure and they can be used in the same model.

+ To do that, we develop the functions (load2, select2, fit2) which works in both files in variable selection and in training/testing. Please refer to the file CodePart2.R for the details.

 

## 7. The final result on pml-testing.csv
+ This is our final result

1             B
2             A
3             B
4             A
5             A
6             E
7             D
8             B
9             A
10           A
11           B
12           C
13           B
14           A
15           E
16           E
17           A
18           B
19           B
20           B
### Table 6: our final result
 

 

 

 

 

 

 

 
