library('DMwR')
library('cluster')
library('rpart')

data(algae)
algae <- algae[-c(62, 199),]
fillPO4 <- function(o) {
  if (is.na(o)) return(NA)
  return((o+15.6142)/0.6466)
}
central.value <- function(x) {
  if (is.numeric(x)) median(x, na.rm=T)
  else if(is.factor(x)) levels(x)[which.max(table(x))]
  else {
    f <- as.factor(x)
    levels(f)[which.max(table(f))]
  }
}
dist.mtx <- as.matrix(daisy(algae,stand=T))
algae[is.na(algae$Chla), 'Chla'] <- median(algae$Chla,na.rm=T)
algae[is.na(algae$PO4), 'PO4'] <- sapply(algae[is.na(algae$PO4), 'oPO4'], fillPO4)
for(r in which(!complete.cases(algae))) {
  algae[r, which(is.na(algae[r,]))] <- 
    apply(data.frame(algae[c(as.integer(names(sort(dist.mtx[r,])[2:11]))),
                     which(is.na(algae[r,]))]), 
          2, central.value)
}
clean.algae <- algae  # Save clean result
final.lm <- lm(a1 ~ ., data = clean.algae[,1:12])

data(algae)
algae <- algae[-c(62, 199),]
rt.a1 <- rpart(a1 ~ ., data = algae[,1:12])

lm.prediction.a1 <- predict(final.lm, clean.algae)
rt.prediction.a1 <- predict(rt.a1, algae)

mse.lm.a1 <- mean((lm.prediction.a1 - clean.algae[,'a1'])^2)
mse.rt.a1 <- mean((rt.prediction.a1 - algae[,'a1'])^2)

nmse.lm.a1 <- mean((lm.prediction.a1 - clean.algae[,'a1'])^2) / 
   mean((mean(clean.algae[,'a1']) - clean.algae[,'a1'])^2)
nmse.rt.a1 <- mean((rt.prediction.a1 - algae[,'a1'])^2) / 
   mean((mean(algae[,'a1']) - algae[,'a1'])^2)


sensible.lm.prediction.a1 <- ifelse(lm.prediction.a1 < 0, 0, lm.prediction.a1)
nmse.lm.a1 <- mean((sensible.lm.prediction.a1 - clean.algae[,'a1'])^2) / 
  mean((mean(clean.algae[,'a1']) - clean.algae[,'a1'])^2)

old.par <- par(mfrow=c(2,1))
plot(lm.prediction.a1, clean.algae[,'a1'], main="Linear model",
     xlab="Predictions", ylab="True value")
abline(0, 1, lty=2)
plot(rt.prediction.a1, algae[, 'a1'], main="Regression Tree", 
     xlab="Predictions", ylab="True value")
abline(0, 1, lty=2)
par(old.par)

cross.validation <- function(all.data, clean.data, n.folds = 10) {
  n <- nrow(all.data)
  idx <- sample(n, n)
  all.data <- all.data[idx,]
  clean.data <- clean.data[idx,]
  
  n.each.part <- as.integer(n/n.folds)
  perf.lm <- vector()
  perf.rt <- vector()
  
  for(i in 1:n.folds) {
    cat('Fold ', i, '\n')
    out.fold <- ((i - 1)*n.each.part+1):(i*n.each.part)
    l.model <- lm(a1 ~ ., clean.data[-out.fold, 1:12])
    l.model <- step(l.model)
    l.model.preds <- predict(l.model, clean.data[-out.fold, 1:12])
    l.model.preds <- ifelse(l.model.preds < 0, 0, l.model.preds)
    
    r.model <- reliable.rpart(a1 ~ ., all.data[-out.fold, 1:12])
    r.model.preds <- predict(r.model, all.data[-out.fold, 1:12])
    
    perf.lm[i] <- mean((l.model.preds - all.data[-out.fold,1:12])^2) /
      mean((mean(all.data[-out.fold,1:12]) - all.data[-out.fold,1:12])^2)
    perf.rt[i] <- mean((r.model.preds - all.data[-out.fold,1:12])^2) /
      mean((mean(all.data[-out.fold,1:12]) - all.data[-out.fold,1:12])^2)
  }
  
  list(lm=list(avg=mean(perf.lm), std=sd(perf.lm), fold.res=perf.lm),
    rt=list(avg=mean(perf.rt), std=sd(perf.rt), fold.res=perf.rt))
}

cv10.res <- cross.validation(algae, clean.algae)