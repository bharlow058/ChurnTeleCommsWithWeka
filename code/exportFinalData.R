# Export final data 

# orange.train.NA.labels

subsetChangeChurn = subset(orange.train.NA.labels, churn=='-1')
summary(subsetChangeChurn)
subsetStayChurn = subset(orange.train.NA.labels, churn=='1')
summary(subsetStayChurn)
subsetChangeChurn = subsetChangeChurn[sample(nrow(subsetChangeChurn)),]
subsetChangeChurn = subsetChangeChurn[1:3672,]

unitedChurn = rbind(subsetChangeChurn,subsetStayChurn)

dme.exportARFF(unitedChurn, "unitedChurn")

subsetChangeAppetency = subset(orange.train.NA.labels, appetency=='-1')
summary(subsetChangeAppetency)
subsetStayAppetency = subset(orange.train.NA.labels, appetency=='1')
summary(subsetStayAppetency)
subsetChangeAppetency = subsetChangeAppetency[sample(nrow(subsetChangeAppetency)),]
subsetChangeAppetency = subsetChangeAppetency[1:890,]

unitedAppetency= rbind(subsetChangeAppetency,subsetStayAppetency)

dme.exportARFF(unitedAppetency, "unitedAppetency")

subsetChangeUpselling = subset(orange.train.NA.labels, upselling=='-1')
summary(subsetChangeUpselling)
subsetStayUpselling = subset(orange.train.NA.labels, upselling=='1')
summary(subsetStayUpselling)
subsetChangeUpselling = subsetChangeUpselling[sample(nrow(subsetChangeUpselling)),]
subsetChangeUpselling = subsetChangeUpselling[1:3682,]

unitedUpselling= rbind(subsetChangeUpselling,subsetStayUpselling)

dme.exportARFF(unitedUpselling, "unitedUpselling")

