COGuser201307 <- read.csv("COGuser201307.csv")
COGuser201308 <- read.csv("COGuser201308.csv")
COGuser201309 <- read.csv("COGuser201309.csv")
COGuser201310 <- read.csv("COGuser201310.csv")
COGuser201311 <- read.csv("COGuser201311.csv")
COGuser201312 <- read.csv("COGuser201312.csv")
COGu <- rbind(COGuser201307,COGuser201308,COGuser201309,COGuser201310,COGuser201311,COGuser201312)

write.csv(COGu,"COGuser2013_rawdata2.csv")
