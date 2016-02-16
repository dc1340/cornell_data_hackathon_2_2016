#simple analysis


all_no_na=na.exclude(all_data)
  
granger_out=matrix(nrow=8, ncol=15)
  for (i in 3:17){
    for (lag in 1:8){
      granger_out[ lag, i-2]=grangertest(diff(all_no_na$USD_Scaled_Price)~diff(all_no_na[ , i]), order=lag)$`Pr(>F)`[[2]]
    } 
  }

rev_granger_out=matrix(nrow=8, ncol=15)
for (i in 3:17){
  for (lag in 1:8){
    rev_granger_out[ lag, i-2]=grangertest(diff(all_no_na[ , i])~diff(all_no_na$USD_Scaled_Price), order=lag)$`Pr(>F)`[[2]]
  } 
}

for (i in 3:4){
  for (lag in 1:8){
    cat(grangertest(diff(all_no_na[ , i])~diff(all_no_na$Scaled_USD_Price), order=lag)$`Pr(>F)`[[2]] , '\n')
  } 
}


train_inds=sample(1:nrow(all_data), size=nrow(all_data)*0.8)
train_dat=all_data[ train_inds, ]
test_dat=all_data[ -train_inds, ]




  test_val_inds=(1:nrow(all_data))[ (!(1:nrow(all_data) %in% train_inds)) ] +1
  test_vals=all_data[  test_val_inds, 'USD_Scaled_Price']
  lag=1
  cur_data=cbind(all_data[ train_inds , 3:17], all_data[  train_inds+lag , 3])
  colnames(cur_data)[[16]]="Scaled_USD_Price"
  cur_fit=with(cur_data, lm(as.formula(paste0("Scaled_USD_Price~",big_form))))
  pred.out=predict(cur_fit, test_dat)
  plot(pred.out, test_vals)
  summary(lm(test_vals~pred.out))
  summary(cur_fit)


train_inds=sample(1:nrow(all_data), size=nrow(all_data)*0.8)
train_dat=all_data[ train_inds, ]
test_dat=all_data[ -train_inds, ]


#Including lag1 - allow for 1 day of autocorrelation
test_val_inds=(1:nrow(all_data))[ (!(1:nrow(all_data) %in% train_inds)) ] +1
test_vals=all_data[  test_val_inds, 'USD_Scaled_Price']
lag=1
cur_data=cbind(all_data[ train_inds , 3:18], all_data[  train_inds+lag , 3])
colnames(cur_data)[[17]]="Scaled_USD_Price"
cur_fit=with(cur_data, lm(as.formula(paste0("Scaled_USD_Price~",big_form,"+usd_lag1"))))
pred.out=predict(cur_fit, test_dat)
plot(pred.out, test_vals)
summary(lm(test_vals~pred.out))
summary(cur_fit)



