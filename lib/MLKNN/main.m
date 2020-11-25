load('emotion/emotions-train.arff');
train_Data=emotions_train(:,1:1:72);
train_Target=emotions_train(:,73:1:end);
load('emotion/emotions-test.arff');
test_Data=emotions_test(:,1:1:72);
test_Target=emotions_test(:,73:1:end);
[Prior,PriorN,Cond,CondN]=MLKNN_train(train_Data,train_Target',10,1);
[HammingLoss,RankingLoss,OneError,Coverage,Average_Precision,Outputs,Pre_Labels]=MLKNN_test(train_Data,train_Target',test_Data,test_Target',10,Prior,PriorN,Cond,CondN);

