
df <- read.csv("data.csv", stringsAsFactors = FALSE)
library(dplyr)

df$count <- as.numeric(df$count)

co_list <- df %>% group_by(company) %>% summarise(n())
co_list

#write.csv(co_list, "co_list.csv")

hit_list <- df %>%
  filter(job_category == "Totals", race == "Black_or_African_American") %>%
  group_by(company) %>%
  mutate(GenTot = sum(count)) %>%
  filter(gender == "male") %>%
  select("company", "GenTot")


overall_list <- df %>%
  filter(race == "Overall_totals", job_category=="Totals") %>%
  select("company", "count")


data <- inner_join(hit_list, overall_list)

data <- data %>% arrange(desc(count))

data$size <- c(rep("big", 8),rep("medium", 7),rep("small",7))

colnames(data)<-c("Company", "Hires", "TotalHires", "Size")

write.csv(data, "race_data.csv")

