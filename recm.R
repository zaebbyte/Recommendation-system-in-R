install.packages("recommenderlab")

library(recommenderlab)
library(ggplot2)
data("MovieLense")
print(str(MovieLense))
View(MovieLense)
summary(MovieLense)

rating_matrix<-as(MovieLense,"realRatingMatrix")

set.seed(123)

train_set_split<-sample(x=c(TRUE,FALSE),size=nrow(rating_matrix),replace = TRUE,prob = c(0.8,0.2))
train_data<-rating_matrix[train_set_split, ]
test_data<-rating_matrix[!train_set_split, ]

recomm_model<-Recommender(train_data,method="UBCF")

recommendations<-predict(recomm_model,test_data,n=5)

recommendation_list<-as(recommendations,"list")
print(recommendation_list[1:5])

evaluation_scheme<-evaluationScheme(data = rating_matrix,method="split",train=0.8,given=10,goodRating=4)

eval_result<-evaluate(evaluation_scheme,method="UBCF",n=c(1,2,3,4,5))

plot(eval_result,annotate=TRUE,main="ROC Curve for UBFC",legend="topright")

plot(eval_result,"prec/rec",annotate=TRUE,main="Precision-Recall for UBCF",legend="topright")

























































































