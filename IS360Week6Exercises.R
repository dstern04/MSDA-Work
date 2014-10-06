Bundestag <- read.csv("Bundestag2005.csv", header=TRUE)
Lander <- Bundestag$X
Bundestag <- Bundestag[2:6]
rownames(Bundestag) <- Lander
# The document that accompanies the Bundestag2005.csv only includes political parties that did
# not meet the threshold for representation in the Bundestag. The post-war constitution (Grundgesetz)
# bars parties that received less than 5% of the vote from parliamentary representation. This applies to 
# the national parliament (Bundestag) and to the regional parliaments (Landestag).
# The following expression will show us how many votes votes are included in the dataset
sum(Bundestag)
# The German government's voting website indicates that 48,044,134 citizens voted in the election
# Ref: http://www.bundeswahlleiter.de/de/bundestagswahlen/fruehere_bundestagswahlen/btw2005.html
# The following expression indicates the number of voters who casted ballots for "minor" parties
48044134 - sum(Bundestag) #Number of votes for minor parties
(48044134 - sum(Bundestag))*100/sum(Bundestag) #Percentage of votes for all minor parties
# A majority of the votes for minor parties were won by the extremist right-wing party, NPD
# I will add the number of NPD votes, by Land, to the Bundestag dataframe
# From above URL, dataset is "Ergebnis der Wahl zum 16. Deutschen Bundestag am 18. September 2005 nach Wahlkreisen.csv"
NPD <-  c(17497, 32944,	10135, 62313, 5513, 51389, 40324,	33508, 97166,	131718, 51499, 57464, 36481, 126059, 92847,	10920)
Bundestag["NPD"] <- NPD
SPD <- Bundestag$SPD
SPD*100/colSums(Bundestag)["SPD"]
for (i in ncol(Bundestag)){
  Bundestag[i] <- Bundestag[colnames(Bundestag)[i]]
  Bundestag <- Bundestag[i]*100/colSums(Bundestag)[i]}
