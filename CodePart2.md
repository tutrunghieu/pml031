## to clear all variables
<pre><code>
rm( list=ls() ); cat( ls(), "\n"); 
</code></pre>

## the function to load training/testing file
<pre><code>
load2 <- function(file1, file2)
{ 
	cat("-------Loading data\n"); 
	d1 <- read.csv(file1, header=TRUE); cat("Data size: ", dim(d1), "\n");
	d2 <- read.csv(file2, header=TRUE); cat("Data size: ", dim(d2), "\n");
      return( list("d1"=d1, "d2"=d2) ); 
}
</code></pre>

## the function to transform both training/testing data
<pre><code>
select2 <- function(P)
{ 
	data = P$d1;
	data2 = P$d2;

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
     data2 <- data2[, -sel];

	sel = c(1:5, dim(data)[2]); cat(sel, "\n");
      data <- data[, sel]; 
	data2 <- data2[, sel];

	cat("Base data: ", dim(data), " [", names(data), "]\n");
	cat("New data: ", dim(data2), " [", names(data2), "]\n");
	
	P$d1 <- data;
	P$d2 <- data2;

     return(P); 
}
</code></pre>

## the function to measure if the model is reliable
<pre><code>
error1 <- function(M, D, msg)
{
	rowD <- dim(D)[1];
	E <- sum( predict(M, newdata=D) != D$classe); 
	cat(msg, E, " or ", E/rowD, "\n");
}
</code></pre>

## the function to train the model with training data and label the new data
<pre><code>
fit2 <- function(P, res)
{
	D <- P$d1; D2 <- P$d2;

	cat("-------Splitting\n"); 
	coin = 0.1; cat("Training coin: ", coin, "\n");
	S <- createDataPartition(y=D$classe, p=coin, list=FALSE)
	A <- D[S,]; cat("Training size: ", dim(A), "\n");
	B <- D[-S,]; cat("Testing size: ", dim(B), "\n");

	cat("-------Fitting\n"); 
	M <- train(classe ~ ., method="rf", data=A);
	cat("Model size: ", length(M), "\n");

	cat("-------Evaluation\n"); 
	error1(M, A, "Training error: ");
	error1(M, B, "Testing error: ");

	cat("-------Predicting new data\n"); 
	R2 = data.frame(id=D2$problem_id, classe=predict(M, newdata=D2));
	cat(as.character(R2$classe), "\n");
      write.table(R2, file = res, sep = ",", row.names = FALSE, col.names = TRUE)
}
</code></pre>


## our main process
<pre><code>
main2 <- function()
{
	wf <- "/path/to/pml031-project/";
	f1 <- paste0(wf, "pml-training.csv");
	f2 <- paste0(wf, "pml-testing.csv"); 
	resf <- paste0(wf, "pml-testing-labelled.csv");

	cat("Working folder: ", wf, "\n"); 
	P <- load2(f1, f2); P <- select2(P); fit2(P, resf);
	cat("-------THE END\n");
}
</code></pre>

## call to start our main process
<pre><code>
cat(rep("\n", 20)); main2();
</code></pre>
