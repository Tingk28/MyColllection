library(readxl)
##7
COGgeneration201307 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201307.xlsx", 
                                sheet = "COG生產", range = "A6:I44647")
write.csv(COGgeneration201307,file="Desktop/機器學習專題/COGgeneration201307.csv",row.names = FALSE)
COGuser201307 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201307.xlsx", 
                                  sheet = "COG用戶", range = "A5:BR44646")
write.csv(COGuser201307,file="Desktop/機器學習專題/COGuser201307.csv",row.names = FALSE)
##8
COGgeneration201308 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201308.xlsx", 
                                  sheet = "COG生產", range = "A6:I44647")
write.csv(COGgeneration201308,file="Desktop/機器學習專題/COGgeneration201308.csv",row.names = FALSE)
COGuser201308 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201307.xlsx", 
                            sheet = "COG用戶", range = "A5:BR44646")
write.csv(COGuser201308,file="Desktop/機器學習專題/COGuser201308.csv",row.names = FALSE)
##9
COGgeneration201309 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201309.xlsx", 
                                  sheet = "COG生產", range = "A6:I43207")
write.csv(COGgeneration201309,file="Desktop/機器學習專題/COGgeneration201309.csv",row.names = FALSE)
COGuser201309 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201309.xlsx", 
                            sheet = "COG用戶", range = "A5:BR43206")
write.csv(COGuser201309,file="Desktop/機器學習專題/COGuser201309.csv",row.names = FALSE)
##10
COGgeneration201310 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201310.xlsx", 
                                  sheet = "COG生產", range = "A6:I44647")
write.csv(COGgeneration201310,file="Desktop/機器學習專題/COGgeneration201310.csv",row.names = FALSE)
COGuser201310 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201310.xlsx", 
                            sheet = "COG用戶", range = "A5:BR44646")
write.csv(COGuser201310,file="Desktop/機器學習專題/COGuser201310.csv",row.names = FALSE)
##11
COGgeneration201311 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201311.xlsx", 
                                  sheet = "COG生產", range = "A6:I43207")
write.csv(COGgeneration201311,file="Desktop/機器學習專題/COGgeneration201311.csv",row.names = FALSE)
COGuser201311 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201311.xlsx", 
                            sheet = "COG用戶", range = "A5:BR43206")
write.csv(COGuser201311,file="Desktop/機器學習專題/COGuser201311.csv",row.names = FALSE)
##12
COGgeneration201312 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201312.xlsx", 
                                  sheet = "COG生產", range = "A6:I44647")
write.csv(COGgeneration201312,file="Desktop/機器學習專題/COGgeneration201312.csv",row.names = FALSE)
COGuser201312 <- read_excel("Desktop/機器學習作業/期末專題/COG 201307-12/COG產用資訊-數據-201312.xlsx", 
                            sheet = "COG用戶", range = "A5:BR44646")
write.csv(COGuser201312,file="Desktop/機器學習專題/COGuser201312.csv",row.names = FALSE)
