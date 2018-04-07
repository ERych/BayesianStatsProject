df <- read.csv("data.csv", stringsAsFactors = FALSE)
df_f <- read.csv("founding_data.csv", stringsAsFactors = FALSE)
library(dplyr)

df$count <- as.numeric(df$count)

#str(as.factor(df$race))

#co_list <- df %>% group_by(company) %>% summarise(n())
#co_list

#write.csv(co_list, "co_list.csv")

hit_list <- df %>%
  filter(job_category == "Totals", race == "White") %>%
  group_by(company) %>%
  mutate(Hires = sum(count)) %>%
  filter(gender == "male") %>%
  select("company", "Hires")


overall_list <- df %>%
  filter(race == "Overall_totals", job_category=="Totals") %>%
  select("company", "count")


data <- inner_join(hit_list, overall_list)

data <- data %>% arrange(desc(count))

data$size <- c(rep("big", 8),rep("medium", 7),rep("small",7))
data <- full_join(data, df_f)

colnames(data)<-c("Company", "Hires", "TotalHires", "Size", "Founded","Age")

write.csv(data, "race_data.csv")

