## cleaning variables
rm( list=ls() ); cat( ls(), "\n");

## load the training data from a file
load1 <- function(file)
{ 
	cat("-------Loading data\n"); 
	data <- read.csv(file, header=TRUE); cat("Data size: ", dim(data), "\n");
      return(data); 
}

## select predictors/variables from the data, we donot include all 160 variables in the prediction model
select1 <- function(data)
{ 
	cat("-------Selecting predictors\n"); 

	F <- names(data); cols <- dim(data)[2];
	sel <- c(1, 2, 3, 4, 5);
	for(k in 1:160)
	{
	    hasNA <- 0; X <- data[,k];
	    for(x in X) if( is.na(x) ) hasNA <- hasNA + 1;
    	    if( hasNA > 0 ) sel <- c(sel, k);
	}
      cat(sel, "\n");

     data <- data[, -sel];
     #write.table(data, file = "/temp/pml031-sel1.csv", sep = ",", row.names = FALSE, col.names = TRUE)

	sel = c(1:5, dim(data)[2]); cat(sel, "\n");
      data <- data[, sel];
      # write.table(data, file = "/temp/pml031-sel2.csv", sep = ",", row.names = FALSE, col.names = TRUE)

     return(data); 
}

## to measure the testing/training error to make sure that we have a reliable model
error1 <- function(M, D, msg)
{
	rows <- dim(D)[1];
	E <- sum( predict(M, newdata=D) != D$classe); 
	cat(msg, E, " or ", E/rows, "\n");
}

## to fit the model to the training data and to show the error
fit1 <- function(data)
{
	cat("-------Splitting\n"); 
	coin <- 0.1; cat("Training coin: ", coin, "\n");
	S <- createDataPartition(y=data$classe, p=coin, list=FALSE)
	A <- data[S,]; cat("Training size: ", dim(A), "\n");
	B <- data[-S,]; cat("Testing size: ", dim(B), "\n");

	cat("-------Fitting\n"); 
	M <- train(classe ~ ., method="rf", data=A);
	cat("Model size: ", length(M), "\n");

	cat("-------Evaluation\n"); 
	error1(M, A, "Training error");
	error1(M, B, "Testing error");
}

## our main process to find the best model

main1 <- function()
{
	wf <- "C:/Users/henrytu/Desktop/pml031-final/";
	f1 <- paste0(wf, "pml-training.csv");

	cat("Working folder:", wf, "\n"); 
	D<-load1(f1); D<-select1(D); fit1(D); 

	cat("THE END\n");
}

## Calling our main function to start the process
cat(rep("\n", 20)); main1();

