
# %%
library(readr)
library(dplyr)
library(tm)
library(SnowballC)
library(e1071)
library(caret)

# %%
spam_raw <- read_csv("code/spam.csv", show_col_types = FALSE)

spam <- spam_raw %>%
  select(label = v1, text = v2) %>%
  filter(!is.na(label), !is.na(text)) %>%
  mutate(label = factor(label))

glimpse(spam)
table(spam$label)


# %% [markdown]
# ## Train/Test Split
# 
# We keep 80% for training and 20% for testing.
# 

# %%
set.seed(5821)

n <- nrow(spam)
train_idx <- sample(seq_len(n), size = 0.8 * n)

train <- spam[train_idx, ]
test <- spam[-train_idx, ]

prop.table(table(train$label))
prop.table(table(test$label))


# %% [markdown]
# ## Text Preprocessing and Document-Term Matrix
# 
# We apply standard text preprocessing:
# - lowercase
# - remove punctuation and numbers
# - remove English stopwords
# - stem words
# 
# Then we build a **Document-Term Matrix (DTM)** from the training set, and reuse its vocabulary for the test set to avoid leakage.
# 

# %%
prep_corpus <- function(text_vec) {
  corpus <- VCorpus(VectorSource(text_vec))
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, removeWords, stopwords("en"))
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, stemDocument)
  corpus
}

corpus_train <- prep_corpus(train$text)
dtm_train <- DocumentTermMatrix(corpus_train, control = list(wordLengths = c(2, Inf)))

# Reduce dimensionality by removing very sparse terms
dtm_train <- removeSparseTerms(dtm_train, 0.99)

corpus_test <- prep_corpus(test$text)
dtm_test <- DocumentTermMatrix(corpus_test, control = list(dictionary = Terms(dtm_train)))

dtm_train
dtm_test


# %% [markdown]
# ## Fit Naive Bayes Model
# 
# We convert the DTM to a data frame and fit a Naive Bayes classifier with Laplace smoothing.
# 

# %%
train_df <- as.data.frame(as.matrix(dtm_train))
test_df <- as.data.frame(as.matrix(dtm_test))

train_df$label <- train$label
test_df$label <- test$label

nb_model <- naiveBayes(label ~ ., data = train_df, laplace = 1)
nb_model


# %% [markdown]
# ## Evaluate Performance
# 
# We compute a confusion matrix and accuracy on the test set.
# 

# %%
pred <- predict(nb_model, newdata = test_df)

conf_mat <- table(Predicted = pred, Actual = test_df$label)
conf_mat

accuracy <- mean(pred == test_df$label)
accuracy

caret::confusionMatrix(pred, test_df$label, positive = "spam")


# %% [markdown]
# ## Inspect Predictions
# 
# Look at a few correct and incorrect classifications.
# 

# %%
results <- test %>%
  mutate(pred = pred,
         correct = pred == label) %>%
  select(text, label, pred, correct)

head(results)
results %>% filter(!correct) %>% head(10)


# %% [markdown]
# ### Notes
# 
# Naive Bayes is fast and surprisingly effective for text classification because word occurrences are informative even under the (strong) conditional independence assumption. More advanced models (logistic regression, SVMs, or transformers) may achieve higher accuracy, but this baseline is excellent for teaching and prototyping.
# 


