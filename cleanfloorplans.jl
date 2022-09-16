using Images, FileIO
using Clustering

function get_dummy_coloring(path; k=5)
    cluster_dummy = Dict(
        1=>(1,0,0),
        2=>(0,1,0),
        3=>(0,0,1),
        4=>(1,1,0),
        5=>(1,0,1)
    )
    img = load(path)
    w,h = size(img)
    data = reshape(channelview(img), (4, :)) .|> Float32 |> collect
    kmeans_result = kmeans(data, k)
    image = kmeans_result.assignments .|>
            x->cluster_dummy[x] .|>
            Float32 
    return reshape(image .|> x->RGB{Float32}(x...), (w,h)), kmeans_result.assignments, (w,h)
end

function color_correctly(assignment, mapping, w_h; k=5)
    colors = Dict()
    for (i,j) in enumerate(mapping)
        colors[i] = j
    end
    image = assignment .|>
        x->colors[x] .|>
        Float32
    return reshape(image .|> x->RGB{Float32}(x...), w_h)
end

floor = "f4"
dummie, assignment, w_h = get_dummy_coloring("res/floorplans/$floor.png")
dummie
cleaned = color_correctly(assignment, [1,1,0,0,0], w_h)
cleaned
save("res/floorplans/cleaned_$floor.png",cleaned)

floor = "f5"
dummie, assignment, w_h = get_dummy_coloring("res/floorplans/$floor.png")
dummie
cleaned = color_correctly(assignment, [1,1,0,1,0], w_h)
cleaned
save("res/floorplans/cleaned_$floor.png",cleaned)

floor = "f6"
dummie, assignment, w_h = get_dummy_coloring("res/floorplans/$floor.png")
dummie
cleaned = color_correctly(assignment, [1,0,0,1,0], w_h)
cleaned
save("res/floorplans/cleaned_$floor.png",cleaned)

floor = "f7"
dummie, assignment, w_h = get_dummy_coloring("res/floorplans/$floor.png")
dummie
cleaned = color_correctly(assignment, [1,1,0,0,0], w_h)
cleaned
save("res/floorplans/cleaned_$floor.png",cleaned)
# center - dummy  => should be
# 1      - red    
# 2      - green  
# 3      - blue   
# 4      - yellow 
# 5      - purple