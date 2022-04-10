# This is a julia version inspired by: https://mccormickml.com/2019/05/14/BERT-word-embeddings-tutorial/
using Pkg; Pkg.activate("/home/swojcik/github/julia_from_scratch/data science basics/nlp_embeddings")

using Transformers
using Transformers.Basic
using Transformers.Pretrain
using Plots
using Distances 

ENV["DATADEPS_ALWAYS_ACCEPT"] = true

bert_model, wordpiece, tokenizer = pretrain"bert-uncased_L-12_H-768_A-12"
vocab = Vocabulary(wordpiece)

text = "After stealing money from the bank vault, the bank robber was seen fishing on the Mississippi river bank" 

ktext = "king man woman queen"

tokenized_text = ["[CLS]"; (text |> tokenizer |> wordpiece); "[SEP]"]

token_indices = vocab(tokenized_text)

segment_indices = fill(1, length(tokenized_text))

sample = (tok = token_indices, segment = segment_indices)

bert_embedding = sample |> bert_model.embed
feature_tensors = bert_embedding |> bert_model.transformers

# Comparing the use of 'book' in this context vs that
1- evaluate(CosineDist(), feature_tensors[:, 7], feature_tensors[:, 11]) # bank vault and bank robber
1- evaluate(CosineDist(), feature_tensors[:, 7], feature_tensors[:, 20]) # bank vault and bank of the river


# Compare the look of the two vectors 
plot([feature_tensors[:, 11] .- feature_tensors[:, 7]; bert_embedding = sample |> bert_model.embed