### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# ╔═╡ bdbb293e-4fc5-4ffc-ad25-1f09b4991d08
begin
	import Pkg
	Pkg.activate( mktempdir() )
	Pkg.add("Agents")
end

# ╔═╡ 9e5e64a6-17d0-47ba-a84e-191572311203
begin
	Pkg.add(["LightGraphs", "GraphPlot"])
	using LightGraphs, GraphPlot
end

# ╔═╡ 5d44e336-9594-11eb-1fc5-4beacd3d030f
using Agents

# ╔═╡ 1e9ea6e7-146e-4f11-a15f-deef225bb825
md"""
#### a small taste of Agents.jl: the Schelling model
"""

# ╔═╡ 04c06589-6554-40bf-928e-5ef275111fa4
md"""
to create a model in `Agents.jl`, we only need to think about a few things:

- The model space and model properties

- Our agents and their properties

- A function (or functions) to initialize our model

- Model-stepping functions that we define

- Data collection
"""

# ╔═╡ 5949cdcd-bdf6-479c-952c-85050c932ced
space = GridSpace( (10, 10); periodic = false ) #define our space

# ╔═╡ 79662fea-3b87-49c2-b1c3-42dbc7827bca
mutable struct SchellingAgent <: AbstractAgent #we create a composite type,
											   #subtype of AbstractAgent
    id::Int             # The identifier number of the agent
    pos::NTuple{2, Int} # The x, y location of the agent on a 2D grid
    mood::Bool          # whether the agent is happy in its position. (true = happy)
    group::Int          # The group of the agent, determines mood as it interacts with 
						# neighbors
end

# ╔═╡ 258650d7-9e70-4294-b04a-cd45aef14a6c
begin
	using Random # for reproducibility
	
	function initialize(;
			numagents = 320, 
			griddims = (20, 20), 
			min_to_be_happy = 3, 
			seed = 125
		)
		
	    space = GridSpace(griddims, periodic = false) #define the space
		
	    properties = Dict(:min_to_be_happy => min_to_be_happy) #our model properties
		
	    rng = Random.MersenneTwister(seed) #random number generator to use
		
	    model = ABM(
	        SchellingAgent, space;
	        properties,
			rng,
			scheduler = random_activation #agents activate randomly
	    )
	
	    # populate the model with agents, adding equal amount of the two types of 
		# agents at random positions in the model
	    for n in 1:numagents
	        agent = SchellingAgent(n, (1, 1), false, n < numagents / 2 ? 1 : 2)
	        add_agent_single!(agent, model)
			#add_agent!(agent, model, pos) with pos as a tuple
			#adds agent to a manual position specified by you
	    end
	    return model
	end
end

# ╔═╡ c47a050d-b6c8-429e-8843-9dd2fa2c8d41
function agent_step!(agent, model)
    minhappy = model.min_to_be_happy
    count_neighbors_same_group = 0
    # For each neighbor, get group and compare to current agent's group
    # and increment count_neighbors_same_group as appropriately.
    # Here `nearby_agents` (with default arguments) will provide an iterator
    # over the nearby agents one grid point away, which are at most 8.
    for neighbor in nearby_agents(agent, model)
        if agent.group == neighbor.group
            count_neighbors_same_group += 1
        end
    end
    # After counting the neighbors, decide whether or not to move the agent.
    # If count_neighbors_same_group is at least the min_to_be_happy, set the
    # mood to true. Otherwise, move the agent to a random position.
    if count_neighbors_same_group ≥ minhappy
        agent.mood = true
    else
        move_agent_single!(agent, model)
		#you can also change position manually using agent.pos = new_pos
		#or model[agentID].pos = new_pos
    end
end

# ╔═╡ 98495a1f-4176-4ee3-8721-786ee327fbf2
test_model = initialize()

# ╔═╡ 4ca820f9-2ff5-4a09-b395-cb6384ad466d
step!(test_model, agent_step!, dummystep, 3)

# ╔═╡ abb33376-d4cc-4b23-ab02-172a0304a846
begin
	adata = [:pos, :mood, :group]
	
	model = initialize()
	
	data, _ = run!(model, agent_step!, dummystep, 5; adata)
	
	data[1:10, :] # print only a few rows
end

# ╔═╡ bb300e17-1ed7-4d36-b6d7-cb8858306a21
begin
	model02 = initialize(numagents = 370, griddims = (20, 20), min_to_be_happy = 3)
	data02, _ = run!(model02, agent_step!, 5; adata = adata, replicates = 3)
	data02[(end - 10):end, :]
end

# ╔═╡ 5cd417fb-8ad0-412a-acf3-96954aa89bdc
begin
	happyprop(moods) = count(x -> x == true, moods) / length(moods)
	adata03 = [(:mood, happyprop)] #collect moods and apply function to them
	
	parameters = Dict(
	    :min_to_be_happy => collect(2:5), # expanded
	    :numagents => [200, 300],         # expanded
	    :griddims => (20, 20),            # not Vector = not expanded
	)
	
	data03, _ = paramscan(
		parameters, 
		initialize; 
		adata = adata03, 
		n = 5, 
		agent_step! = agent_step!,
		model_step! = dummystep,
		replicates = 3
	)
	data03
end

# ╔═╡ 2d3411c9-eb16-4cf9-9aeb-264316af46bf
begin
	using DataFrames
	using Statistics: mean
	
	gd = groupby(data03, [:step, :min_to_be_happy, :numagents])
	data_mean = combine(gd, [:happyprop_mood, :replicate] .=> mean)
	
	out = select(data_mean, Not(:replicate_mean))
end

# ╔═╡ de295479-8e18-440d-9d49-8b0f91ef4986
md"""
#### a couple things to have in mind for your journey
"""

# ╔═╡ b086285d-dbcf-4200-be10-a0c72aa8f08b
md"""
I have run into some problems when trying to change model attributes inside a stepping function passed into `step!()`. If you want to be safe, only change agent attributes inside the stepping function, and wrap this step in a more complex step function, like so:
"""

# ╔═╡ 9565560a-f9e5-4aea-a5e8-6dfd0858224c
function complex_step!(model, n) #takes the model and number of steps
	t = 1
	while t <= n
		step!(model, dummystep, model_step!, 1) #every tick, we step model 1ce
		if t == n #if at end of process, calculate model properties
			calculate_model_data!(model)
		end
		model.tick = t #tiki
		t += 1 #toki
	end
end

# ╔═╡ 6e9cc4b9-0690-47d6-b8e0-8da42920e9c1
md"""
`LightGraphs.jl` is the library that `Agents.jl` uses to power its networks. It is simple and performant, and it is well worth it to read the documentation to learn about it if you want to work with networks.
"""

# ╔═╡ e153fc85-630c-405b-9d5e-d2fa313f9bd8
graph = SimpleGraph(5)

# ╔═╡ e0e24cf5-2281-46a5-b28a-271abdd21678
begin
	add_edge!( graph, 1, 5 )
	add_edge!( graph, 1, 2 )
	add_edge!( graph, 2, 3 )
	add_edge!( graph, 4, 5 )
	add_edge!( graph, 4, 3 )
	add_edge!( graph, 4, 2 )
end

# ╔═╡ 71616730-2837-45e8-b95a-99f70fe8db36
gplot( graph, nodelabel=1:nv(graph) )

# ╔═╡ dea0fc2a-58a9-4121-ae5c-3cd990502518
md"""
__IMPORTANT__: when using a network (as GraphSpace or as a model property): to this date, whenever you remove a node from the model's GraphSpace, all agents in that node are killed. But then, the highest-indexed node in the network will change its index to the removed node's. LightGraphs.jl does this for performance reasons. However, __and this is not currently in the documentation__, agents' positions won't be updated automatically. It must be done manually. 
"""

# ╔═╡ 41fe37aa-61c3-4f9d-85c8-efb7ae19b0b8
rem_vertex!(graph, 3) #if removing from an Agents.jl GraphSpace, use rem_node!()

# ╔═╡ f7d7ce00-073b-452c-9e5b-e1811456fa8f
gplot( graph, nodelabel=1:nv(graph) )

# ╔═╡ 3e74c8bf-0f36-411d-9351-cb83aa794e57
md"""
node 5 is now node 3! If we're using Agents and this is a model's GraphSpace, any agent that was occupying node 3 is automatically killed. BUT! If an agent was linked to node 5 (either because it was occupying the node in a GraphSpace or because the graph is a model property with a node's ID associated to the agent through an agent property) then __we have to manually change the agent's position attribute (or the agent's node ID attribute if the network is not the model's space)__. Take this into account.

`model[5].pos = 3`

"""

# ╔═╡ Cell order:
# ╟─1e9ea6e7-146e-4f11-a15f-deef225bb825
# ╟─04c06589-6554-40bf-928e-5ef275111fa4
# ╠═bdbb293e-4fc5-4ffc-ad25-1f09b4991d08
# ╠═5d44e336-9594-11eb-1fc5-4beacd3d030f
# ╠═5949cdcd-bdf6-479c-952c-85050c932ced
# ╠═79662fea-3b87-49c2-b1c3-42dbc7827bca
# ╠═258650d7-9e70-4294-b04a-cd45aef14a6c
# ╠═c47a050d-b6c8-429e-8843-9dd2fa2c8d41
# ╠═98495a1f-4176-4ee3-8721-786ee327fbf2
# ╠═4ca820f9-2ff5-4a09-b395-cb6384ad466d
# ╠═abb33376-d4cc-4b23-ab02-172a0304a846
# ╠═bb300e17-1ed7-4d36-b6d7-cb8858306a21
# ╠═5cd417fb-8ad0-412a-acf3-96954aa89bdc
# ╠═2d3411c9-eb16-4cf9-9aeb-264316af46bf
# ╟─de295479-8e18-440d-9d49-8b0f91ef4986
# ╟─b086285d-dbcf-4200-be10-a0c72aa8f08b
# ╠═9565560a-f9e5-4aea-a5e8-6dfd0858224c
# ╟─6e9cc4b9-0690-47d6-b8e0-8da42920e9c1
# ╠═9e5e64a6-17d0-47ba-a84e-191572311203
# ╠═e153fc85-630c-405b-9d5e-d2fa313f9bd8
# ╠═e0e24cf5-2281-46a5-b28a-271abdd21678
# ╠═71616730-2837-45e8-b95a-99f70fe8db36
# ╟─dea0fc2a-58a9-4121-ae5c-3cd990502518
# ╠═41fe37aa-61c3-4f9d-85c8-efb7ae19b0b8
# ╠═f7d7ce00-073b-452c-9e5b-e1811456fa8f
# ╟─3e74c8bf-0f36-411d-9351-cb83aa794e57
