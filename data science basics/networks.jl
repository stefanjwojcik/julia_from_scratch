using CSV, DataFrames, SparseArrays
## Load the Birdwdatch public data 
notes = CSV.read("data/notes-00000.tsv")
ratings = CSV.read("data/ratings-00000.tsv")
unique_participants = []
pids = Dict(x => y for (x,y) in zip(unique(ratings.participantId), 1:length(unique(ratings.participantId))))
nids = Dict(x => y for (x,y) in zip(unique(ratings.noteId), 1:length(unique(ratings.noteId))))
ratings.pid = [pids[x] for x in ratings.participantId]
ratings.nid = [nids[x] for x in ratings.noteId]
affmat = sparse(ratings.pid, ratings.nid, ratings.helpful)
out = affmat*affmat' # symmetrical adjacency matrix from dot product 
out = dropzeros(out)
# NOW, need an edgelist of nonzero entries from the sparse matrix 
i, j = findnz(out) # the edgelist
edgelist = DataFrame(Source = i, Target=j, Weight=1)
# now, upload to gephi and plot the beautiful result! 