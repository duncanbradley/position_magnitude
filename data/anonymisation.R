library(tidyverse)

# reading in data
risk1_raw <- read_csv("risk1_raw.csv")
risk2_raw <- read_csv("risk2_raw.csv")
risk3_raw <- read_csv("risk3_raw.csv")

risk1_prolific <- read_csv("risk1_prolific.csv")
risk2_prolific <- read_csv("risk2_prolific.csv")
risk3_prolific1 <- read_csv("risk3_prolific1.csv") 
risk3_prolific2 <- read_csv("risk3_prolific2.csv")

# bind the two separate files
risk3_prolific <- rbind(risk3_prolific1, risk3_prolific2) 

# creating a dataframe with correct answers:
corr_38 <- c(38, 1, 1)
corr_39 <- c(39, 1, 7)
corr_40 <- c(40, 7, 1)
corr_41 <- c(41, 7, 7)
corr_42 <- c(42, 1, 1)

correct_answers <- rbind(corr_38, corr_39, corr_40, corr_41, corr_42) 
colnames(correct_answers) <- c("item_no", "chance_answer", "severity_answer") 
correct_answers <- correct_answers %>% as_tibble()

# removing participants whose data is not usable
# all participants who were excluded but passed attention checks were paid 
# for their participation
risk1_database <- risk1_raw %>% 
  filter(session != "001", # researcher testing data saving on Pavlovia
         session != "0ocwabqfaros") # researcher testing redirect to Prolific
# session == "{{%SESSION_ID%}}" is a valid participant:
# this participant was sent a direct link to the study 
# after insufficient credit had been assigned on Pavlovia (researcher error)

risk2_database <- risk2_raw %>% 
  filter(session != "6149e590c6effaef347b4e83", # participated prior to pre-registration
         session != "614c4d7645fd8aa7b3d1314d", # completed exp. twice due to initial saving error
         session != "614c4c9f8a346661a5a8673b", # TIMED_OUT submission status
         session != "614c6d5b54575e21c5653df8") # TIMED_OUT submission status)

risk3_database <- risk3_raw %>% 
  filter(session != "6194d18a77dd8d646e2ddce8") # manual completion after exceeding maximum completion time

# all participants excluded here were still paid for their participation

# define responses to attention check questions as correct or incorrect
check_responses <- function(database) {
  
  database %>%
  select(participant, 
         item_no,
         chance_slider.response,
         severity_slider.response) %>%
  inner_join(correct_answers, by = "item_no") %>%
  mutate("chance" = (chance_slider.response == chance_answer),
         "severity" = (severity_slider.response == severity_answer)) %>%
  select(participant,
         chance,
         severity) %>%
  pivot_longer(chance:severity, names_to = "slider", values_to = "correct") %>%
  select(- slider) %>%
  group_by(participant) %>%
  summarise(no_correct = sum (correct)) %>%
  mutate(outcome = case_when(no_correct >= 8 ~ "ACCEPT",
                             no_correct < 8 ~ "REJECT")) %>%
  assign(paste0(unique(database$expName), "_outcomes"), 
         value = ., envir = .GlobalEnv) %>%
  inner_join(database, by = "participant") %>%
  assign(paste0(unique(database$expName), "_database"), 
           value = ., envir = .GlobalEnv)
}

map(list(risk1_database,
         risk2_database,
         risk3_database),
    check_responses)

# join prolific files
risk1_joined <- risk1_prolific %>% 
  select(participant_id, time_taken) %>%
  rename(participant = participant_id) %>%
  right_join(y = risk1_database, # include all rows in pavlovia database
             by = "participant") 

risk2_joined <- risk2_prolific %>% 
  select(participant_id, time_taken) %>%
  rename(participant = participant_id) %>%
  right_join(y = risk2_database, # include all rows in pavlovia database
             by = "participant") 

risk3_joined <- risk3_prolific %>% 
  select(participant_id, time_taken) %>%
  rename(participant = participant_id) %>%
  right_join(y = risk3_database, # include all rows in pavlovia database
             by = "participant") 

anonymise <- function(database) {
  
  database %>%
  filter(outcome == "ACCEPT") %>%
  mutate(participant = match(participant, 
                             unique(participant))) %>%
  select(- `__participant`) %>%
  assign(paste0(unique(database$expName), "_anon"),
         value = ., envir = .GlobalEnv) %>%
  write_csv(paste0(unique(database$expName), "_anon.csv"))
  
}

map(list(risk1_joined,
         risk2_joined,
         risk3_joined),
    anonymise)
