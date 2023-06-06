### A Pluto.jl notebook ###
# v0.19.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ acda237b-0f60-4aeb-a8f9-1770535cd2f4
using Pipe, Random, Distributions, PlutoUI

# ╔═╡ 53a69a82-ee12-4eb2-9dbb-ba7b863e2b3b
using Gadfly

# ╔═╡ c1750374-9588-11eb-1508-3b118006b44f
md"""
### a small presentation of the julia language
###### written for MODSOC by Alejandro Pérez Velilla
"""

# ╔═╡ 22f15be9-79d8-4dea-8719-b19ea07f6472
md"""
julia: what's the hype all about?
"""

# ╔═╡ 73ffed0d-da7e-4ae7-af7e-093f4ff5f9c7
md"""
a broad (and kind of outdated) concept used for categorizing programming languages (or rather, their implementations) is that of __compiled__ vs. __interpreted__.

classic example: C++/Java (compiled) vs. Python/R (interpreted)

"Julia features optional typing, multiple dispatch, and good performance, achieved using type inference and just-in-time (JIT) compilation, implemented using LLVM. It is multi-paradigm, combining features of imperative, functional, and object-oriented programming. Julia provides ease and expressiveness for high-level numerical computing, in the same way as languages such as R, MATLAB, and Python, but also supports general programming. To achieve this, Julia builds upon the lineage of mathematical programming languages, but also borrows much from popular dynamic languages, including Lisp, Perl, Python, Lua, and Ruby."
-https://docs.julialang.org/en/v1/

The language's release "manifesto" is a nice read on the subject: https://julialang.org/blog/2012/02/why-we-created-julia/

So, why julia?

"In short, because we are greedy."
"""

# ╔═╡ 26a58a85-fc56-4b5b-927b-27cfdc24b569
md"""
#### let's jump in!
"""

# ╔═╡ 6efcd05a-493e-4955-9d02-fe342516851e
md"""
__arrays__
"""

# ╔═╡ 3cf4b6f9-92b0-4928-8397-349552bb79ca
[1, 2, 3]

# ╔═╡ 3e51692c-a02e-45b0-8382-62dc457a005a
typeof( [1, 2, 3] )

# ╔═╡ 4eb9b37c-8ff6-4211-b72d-513f703436f7
[1.0, 2.0, 3.0]

# ╔═╡ ac69f968-fe9f-4286-a49a-c02e7511ab49
modsoc = ["paul", "matt", "ket", "cody", "amin"]

# ╔═╡ d21bfe50-a146-47f2-8e98-494657dbe403
modsoc[3]

# ╔═╡ b20b7728-ea7a-4fea-8f6c-c7962c6fdb12
modsoc[1]

# ╔═╡ 5fb60509-9cb0-40da-8bd8-9ab6c176d615
ones(10)

# ╔═╡ 8a474440-340b-48ec-9171-0500e483a638
my_zero_array = zeros(10)

# ╔═╡ feb40e7a-a11c-473a-8d86-50eea06f35e5
typeof(my_zero_array)

# ╔═╡ b34032ab-587d-46ae-b7fe-1066bfad71e4
eltype(my_zero_array)

# ╔═╡ 0b888dae-3961-4109-a9b9-40493bb2a11e
[1, "paul"]

# ╔═╡ bcb93797-4e18-40ee-ac14-28b67599f70a
Array{Float64, 1}(undef, 3) #create an array of a particular type and dim, and populate it

# ╔═╡ 0b9dc6ca-b415-4099-ada9-1e851feb7fb5
altered_array = copy(my_zero_array)

# ╔═╡ b33c8428-e2c5-4e14-84d6-7e47dcfd53a7
altered_array[4:7]

# ╔═╡ 723fefea-755e-49e6-a04d-6ef9c723d9c0
altered_array[5:6] .= 1 #broadcasting

# ╔═╡ bbcd8634-dfee-4682-a84e-dc1a27de8568
altered_array[4:7]

# ╔═╡ 95e101fe-1e9b-4921-a7dc-bc9234c324ff
altered_array

# ╔═╡ a4b87675-0d44-462c-a1b8-fb2c3423c5a8
my_zero_array

# ╔═╡ 5b562504-1360-458c-8c8f-b4b0ef3c03ac
md"""
other convenient ways of generating arrays:
"""

# ╔═╡ 88d07fa4-3a06-4e8f-82c8-4526c75f9f65
trues(10)

# ╔═╡ e9478737-b7aa-420b-a2d2-6337b9ead277
falses(10)

# ╔═╡ 3e05a58a-5843-455e-b325-5de661519546
md"""
ranges are important:
"""

# ╔═╡ 6dd6bfdd-761c-4401-a1f9-e8f7338b6065
1:10 #iterator object representing integers from 1 to 10

# ╔═╡ 5f9a6c06-ef80-4192-ad93-ae8771bd36ec
0:2:100 #start-stop-step

# ╔═╡ ec993ea1-e3b2-40d0-9b0f-87d1af1123db
typeof(1:10)

# ╔═╡ 2d9a0f87-9e26-4811-9d34-04fab13eab7a
md"""
you can evaluate iterators (such as ranges) using `collect()`:
"""

# ╔═╡ fb54571b-181d-46df-a980-01f469b3b063
collect(1:10)

# ╔═╡ 51089be0-f60e-41df-a939-2264e0cc4326
md"""
in general, you also want to use `collect()` to "unpack" lazy iterators and make immutable copies of lists (evaluating them in the process). In an ABM context, this will help you gather data from structures that are changing as the models run.
"""

# ╔═╡ 74c45eab-7f77-4c86-80a0-f4466d3e4835
md"""
__operations with arrays__ can be element-wise:
"""

# ╔═╡ fb05530a-d448-428c-8409-29cfc277dcc4
collect(1:5) + collect(1:5)

# ╔═╡ f3bab895-776f-454d-ae13-373ba7e7ea6c
md"""
in this case elements are added by index. We can also operate on the array by broadcasting:
"""

# ╔═╡ 0c8711b9-91ab-462f-a43a-c2246dc3b130
collect(1:5) .* 2

# ╔═╡ edd1ed1e-15f7-4723-9a45-40483d3c9764
md"""
this is equivalent to
"""

# ╔═╡ 6db3f2dd-9d07-4f4d-81a5-8ba8583b4dc9
[n*2 for n in 1:5] #this is an array comprehension

# ╔═╡ 2e6f4de1-dcf0-4600-86b6-3d20c9ff818d
md"""
and also to
"""

# ╔═╡ eb56f4f2-750a-420e-8c31-dd0680ba2eec
begin
	local arr = Array{Int64, 1}()
	
	for n in 1:5
		push!(arr, n*2) #functions that end with ! modify one 
	end 				#or several of their arguments
		 				#they are called "in-place"
	arr
end

# ╔═╡ d0fe6856-5dcb-4cb7-a8ba-4b0434f466f8
begin
	local arr = Array{Int64, 1}()
	
	local n = 1
	while n <= length(1:5)
		push!(arr, n*2)
		n += 1
	end
	
	arr
end

# ╔═╡ bca794b5-c530-4bcd-b802-bb242092cbb7
md"""
loops!
"""

# ╔═╡ 814c2871-e446-4f77-ab9c-f8dcc5c51052
md"""
there are __many__ useful functions for working with arrays. An example is the `setdiff(a, itrs)` function, which returns the elements in `a` that are not in `itrs`, where the latter can be a single iterator or a list of iterators:
"""

# ╔═╡ a8ddf15c-5f52-4ab6-8f67-6b2e34643b63
begin
	my_arr = zeros(5) #define a vector of zeros
	my_arr[5] = 1 #change last element to 1
	setdiff( my_arr, zeros(5) ) #compare to a pristine zero vector 
								#and extract difference
end

# ╔═╡ c7b696ef-2382-4595-8949-bf19bf5ea3a9
md"""
again, there are many of these, and if we stop to look at all of them we will take a long time. So look in the documentation/tutorials section.
"""

# ╔═╡ 17b20ee9-7afd-4d7b-aad3-0121776d982a
md"""
arrays also have concatenation:
"""

# ╔═╡ 1ce9212f-9501-4f7b-9a61-e00e453caefd
[falses(5), trues(5)]

# ╔═╡ 4bd875a1-9211-4c5a-bedc-7ea1f40d7f20
md"""
this is just an array of arrays. What if we wanted to concatenate two arrays?
"""

# ╔═╡ 5c656a6a-5ff2-4175-8c0b-9d354feb8721
[falses(5); trues(5)]

# ╔═╡ ddb69c54-4036-44d0-be06-4f558cd82681
md"""
vectors in julia are assumed to be column vectors by default, so you can read `[a; b]` as "vertically concatenate `a` and `b`". And we already know how to concatenate horizontally:
"""

# ╔═╡ 0e8d5146-a802-4154-9e36-19034829dda4
[falses(5) trues(5)]

# ╔═╡ 5aca49d6-df0e-40e1-829a-b8818468885c
[falses(5) trues(5)] .== false #another example of broadcasting

# ╔═╡ 44d2cc30-71f3-4c8c-b0cf-db8fa737583c
md"""
__matrices__ (same as type Array, but with more than one dimension)
"""

# ╔═╡ ad8ec88b-d7d5-46c8-98ee-a82bfcc00888
my_matrix = [1 2;
			 3 4]

# ╔═╡ 9735a384-ea4e-4e45-b551-4298f70356d6
my_matrix[2, 1]

# ╔═╡ 84229915-c336-4cfb-8420-f15756cacb97
[1:5 1:5] #read as "horizontally concatenate these two ranges"

# ╔═╡ bf15ffc9-e144-4641-b938-9848db689032
md"""
the library `LinearAlgebra` has most of the tools for generating matrices and performing algebraic operations with vectors and matrices, check the documentation!
"""

# ╔═╡ 96b2a92a-f78e-410f-879e-2136c556387f
md"""
__dictionaries__
"""

# ╔═╡ a631a9c3-1017-477e-939a-30a04f75ebda
my_dict = Dict(
	:one => 1,
	:two => 2.0,
	:three => true,
	:four => "lol",
)

# ╔═╡ d5bba99e-3c14-4743-b01a-2423af1015a2
my_dict[:one]

# ╔═╡ ee4478b5-8db5-4b66-a078-6df4389fdf6f
my_dict[:four]

# ╔═╡ bf737810-9d66-4dcc-a9f0-cdfcdff46e99
md"""
__tuples & named tuples__
"""

# ╔═╡ eb701b07-7d46-45e7-a662-ed40b4a9f715
my_tup = (2, 3, 4, 5)

# ╔═╡ 9400eef5-c56d-427e-b9c7-6a76649a3439
my_tup[2]

# ╔═╡ 3ff8a11f-1634-4c62-83d4-e08a818523a2
my_tup[3] = 2 #immutable!

# ╔═╡ deb54398-06f6-4f5a-8468-76d5dcb8c362
my_named_tup = (a = 1, b = 2, c = 3)

# ╔═╡ a5acaf0d-3ebb-4f9b-8926-3b8c9bf2a825
my_named_tup[1] == my_named_tup.a

# ╔═╡ bce84be6-db02-413f-bf60-263618ec03e4
md"""
__functions__: we have several options to define them
"""

# ╔═╡ 3a5f8d46-a8a5-4a31-9dbb-ee13bcbbd288
g1(x, y) = x + y

# ╔═╡ 17b797a3-6130-4be3-a29f-1d413e5cec16
md"""
which is equivalent to
"""

# ╔═╡ b3777168-e054-4e6e-805d-345aa5a4a27d
function g2(x, y)
	#block of code
	return x + y
end

# ╔═╡ 09d9bcfd-5489-4c35-8cfd-8e005e1b4784
g1(2, 3) == g2(2, 3)

# ╔═╡ 1c476dac-cfeb-4aff-989e-0ff8218d907e
md"""
keyword arguments (name matters)
"""

# ╔═╡ f6ca774b-0272-4d11-b350-3c2ad65b31f0
function t(x, y; meow="meow", woof="woof")
	x = string(x) #convert x to a string
	return meow*x #string concatenation
end

# ╔═╡ 48c80b28-fe38-456c-89c9-3c45d6e19523
t(1, 2)

# ╔═╡ 96b63203-f410-402e-b6db-645cc15c55d2
t(1, 2, meow="lol")

# ╔═╡ f4ddc4eb-0391-42d6-9669-3157ab3c4c71
md"""
Multiple dispatch:
"""

# ╔═╡ 2e834f9a-5027-4b24-8f1b-1f5625282976
f(x::Number, y::Number) = 2*x + y

# ╔═╡ b40961bf-f2d7-4941-ac85-6526f02e935e
f(x::Float64, y::Float64) = 2*x - y

# ╔═╡ 7fae45ca-488d-4d94-9808-caf70a5ac125
f(2, 3)

# ╔═╡ 4ce99c97-df1d-4f48-bc09-277fc84ac7a4
f(2.0, 3)

# ╔═╡ ac387ea7-853d-4d21-9f4c-32b9c4cb969c
f(2.0, 3.0)

# ╔═╡ da719d14-eacf-4186-a031-82b219b82d45
md"""
functions can also be anonymous:
"""

# ╔═╡ 607c83a3-dd35-42c0-beef-dff0bed87dbd
x -> 2*x

# ╔═╡ 50fc4b79-5075-4419-917e-618278b98bd5
md"""
this is useful in many cases. One such case is when we want to use `filter()` to select only certain elements from an iterable based on some criterion. Our anonymous function will be the criterion, receiving the array element and returning a Boolean value:
"""

# ╔═╡ bae76492-2603-482f-b220-1bba3fd3a512
filter( x -> x == 2, [1, 2, 3] )

# ╔═╡ 6928044a-3cf8-40da-87ee-07015e73a1b1
md"""
we can return a tuple in a function when we want to return multiple things:
"""

# ╔═╡ 8a82babe-e536-4a33-9463-1f956b64dd4a
begin
	function whatever(x, y)
		return (2*x, 2*y)
	end
	
	q, r = whatever(1, 2) #tuple unpacking
end

# ╔═╡ 1c6b4e94-e6ab-4783-bfbc-11fded86ec95
q

# ╔═╡ ea2d4ce1-2c84-415f-a407-e568f6d04382
md"""
__control flow__: if, else, ternary operator
"""

# ╔═╡ dc22e15b-c273-4cbc-91e5-d709e96451e1
x = 3; y = 2

# ╔═╡ 2213d948-2f08-4e4a-9f9d-1089b1915c83
if x > y
	"yes!"
else 		#can do more complex decision trees with elseif
	"no!"
end

# ╔═╡ 6a2aa3fe-21ec-40ae-9001-e06a468e335f
md"""
if our conditional expression is simple enough, we can express it using the ternary operator:
"""

# ╔═╡ d2682377-e205-4faf-a262-205121cb5837
x > y ? "yes!" : "no!"

# ╔═╡ 63f08a0b-197c-44f9-9f9a-8128cf6e2361
md"""
we use `&&` and `||` as And and Or logical operators:
"""

# ╔═╡ 087621ce-90ac-4969-9de2-0e66a8ddc7be
x > y && true

# ╔═╡ ec1e47e1-c2e6-49ea-b341-23e27168549a
x < y && true

# ╔═╡ 15f9ad34-5222-47c5-92f0-7454c3cb82e2
x > y || true

# ╔═╡ c5cc45e3-7ccd-4342-afc6-cb2f12c55550
md"""
we can incorporate this for control flow in more complex functions, like so:
"""

# ╔═╡ e3868568-6a02-4736-9b58-a44e59804bbb
function fact(n::Int)
	n >= 0 || error("n must be non-negative") #easily throw errors
	n == 0 && return 1
	n * fact(n - 1)
end

# ╔═╡ a51e58e4-44c8-4329-b572-a8a9ff4e2dea
fact(-1)

# ╔═╡ 8d62fa8e-7dd6-4b4c-9df3-2e790a9f9610
fact(0)

# ╔═╡ 72e52881-a058-43d8-a660-9946a3d48c68
fact(1)

# ╔═╡ e3eee1ef-7c53-4ade-92e6-95c29a19537a
fact(3)

# ╔═╡ a41ab7a9-ec6c-45f5-88cc-b2e5cfd96049
md"""
__extra__: pipes, macros, random numbers, plotting, etc
"""

# ╔═╡ fb8b9535-9180-41d6-abc5-cad967e825c8
rng = RandomDevice() #will use computer's entropy pool

# ╔═╡ 84d67df6-40dd-4c7d-9737-df1a804af35f
rand(rng)

# ╔═╡ 49e30455-2395-4dcf-b59c-cb6845fb7ab1
rand()

# ╔═╡ a54de1b8-8727-47fd-b5e9-0a605780e2a9
rand(rng, [1,2,3])

# ╔═╡ a27b3553-6f73-4148-b4c8-8a78c841340d
rand(rng, [1,2,3], 2)

# ╔═╡ ceeb9e6c-6fcf-4dc3-b018-aa0328ce9548
md"""
let's sample from a normal distribution
"""

# ╔═╡ 33559972-b742-46bd-bcf9-3a6bfcd46a35
@pipe Normal(0, 1) |> rand(rng, _)

# ╔═╡ 50c70cca-3d54-47ab-9864-bcaaea538446
md"""
the macro takes our piped code and re-writes it before the code compiles! It re-writes it to this:
"""

# ╔═╡ 056bee64-ca5a-49c8-8f28-ac62dbf141cd
rand( rng, Normal(0,1) )

# ╔═╡ 6f2a11a5-4aed-4e10-8066-67ceac34b39c
md"""
time to plot it:
"""

# ╔═╡ b70d58a5-a82b-4451-9158-5485f2d2a96d
md"""
more! MORE!
"""

# ╔═╡ 99a4bfef-48e4-46eb-87b7-1771dc6b69a2
@bind n Slider(100:100:1000) #Slider function from PlutoUI library

# ╔═╡ f2f6dcb6-e234-46cf-831f-e3f9f9e494c7
n

# ╔═╡ 47cdefa0-83b7-41eb-8b5d-bfcb2a068e68
random_arr = @pipe Normal(0, 1) |> rand(rng, _, n)

# ╔═╡ 564fbfe6-dac0-4a97-9470-7df05a0e470a
plot(x=random_arr, Geom.histogram)

# ╔═╡ cead43a5-f979-42e7-88bc-9186d7978dd0
random_arr2 = @pipe 2 .* Normal(0, 1) |> rand(rng, _, n)

# ╔═╡ 0e0d7e41-4677-4c0a-bb9b-c4e5845ffa04
plot(
	x=random_arr, y=random_arr2,
	Geom.point,
	Guide.xlabel("x axis"), Guide.ylabel("y axis")
)

# ╔═╡ 34c79f6c-7ab9-4f49-9916-7ee37fb30b8c
md"""
these are the basics, for now. We have made a very superficial treatment of things here, and many things we have not looked at, at all. Data types, for example, is an important subject that requires some time set aside for study. Examples of important subjects we didn't see but you should nevertheless explore: DataFrames, structs, modules, constructors, strings, scope of variables, type conversion and promotion, multithreading... and so much more.

The basics of julia are easy enough that one can get up and running with them. But its large variety of features and the flexibility they bring means this rabbit hole goes deep. For now, this taste of the language should help you, should you choose to embark on a learning journey.
"""

# ╔═╡ 01fb9250-48ef-40ee-9203-194783d16715
md"""
Resources for learning:
1. Julia documentation manual: https://docs.julialang.org/en/v1/
2. Julia documentation tutorials section (https://julialang.org/learning/tutorials/) has a list of good tutorials, like
3. The Julia Express - https://github.com/bkamins/The-Julia-Express
4. A Concise Tutorial - https://syl1.gitbook.io/julia-language-a-concise-tutorial/
5. Julia Academy - https://juliaacademy.com/courses?preview=logged_out
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
Gadfly = "c91e804a-d5a3-530f-b6f0-dfbca275c004"
Pipe = "b98c9c47-44ae-5843-9183-064241ee97a0"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
Distributions = "~0.25.62"
Gadfly = "~1.3.4"
Pipe = "~1.3.0"
PlutoUI = "~0.7.39"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

[[AbstractFFTs]]
deps = ["ChainRulesCore", "LinearAlgebra"]
git-tree-sha1 = "6f1d9bc1c08f9f4a8fa92e3ea3cb50153a1b40d4"
uuid = "621f4979-c628-5d54-868e-fcf4e3e8185c"
version = "1.1.0"

[[AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[Adapt]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "af92965fb30777147966f58acb05da51c5616b5f"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.3.3"

[[ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[AxisAlgorithms]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "WoodburyMatrices"]
git-tree-sha1 = "66771c8d21c8ff5e3a93379480a2307ac36863f7"
uuid = "13072b0f-2c55-5437-9ae7-d433b7a33950"
version = "1.0.1"

[[Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

[[CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "5f5a975d996026a8dd877c35fe26a7b8179c02ba"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.6"

[[ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "9489214b993cd42d17f44c36e359bf6a7c919abf"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.0"

[[ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "1e315e3f4b0b7ce40feded39c73049692126cf53"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.3"

[[ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "417b0ed7b8b838aa6ca0a87aadf1bb9eb111ce40"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.8"

[[Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "924cdca592bc16f14d2f7006754a621735280b74"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.1.0"

[[CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[Compose]]
deps = ["Base64", "Colors", "DataStructures", "Dates", "IterTools", "JSON", "LinearAlgebra", "Measures", "Printf", "Random", "Requires", "Statistics", "UUIDs"]
git-tree-sha1 = "9a2695195199f4f20b94898c8a8ac72609e165a4"
uuid = "a81c6b42-2e10-5240-aca2-a61377ecd94b"
version = "0.9.3"

[[Contour]]
deps = ["StaticArrays"]
git-tree-sha1 = "9f02045d934dc030edad45944ea80dbd1f0ebea7"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.5.7"

[[CoupledFields]]
deps = ["LinearAlgebra", "Statistics", "StatsBase"]
git-tree-sha1 = "6c9671364c68c1158ac2524ac881536195b7e7bc"
uuid = "7ad07ef1-bdf2-5661-9d2b-286fd4296dac"
version = "0.2.0"

[[DataAPI]]
git-tree-sha1 = "fb5f5316dd3fd4c5e7c30a24d50643b73e37cd40"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.10.0"

[[DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[DensityInterface]]
deps = ["InverseFunctions", "Test"]
git-tree-sha1 = "80c3e8639e3353e5d2912fb3a1916b8455e2494b"
uuid = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
version = "0.4.0"

[[Distances]]
deps = ["LinearAlgebra", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "3258d0659f812acde79e8a74b11f17ac06d0ca04"
uuid = "b4f34e82-e78d-54a5-968a-f98e89d6e8f7"
version = "0.10.7"

[[Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[Distributions]]
deps = ["ChainRulesCore", "DensityInterface", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "0ec161f87bf4ab164ff96dfacf4be8ffff2375fd"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.62"

[[DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "b19534d1895d702889b219c382a6e18010797f0b"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.8.6"

[[Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[FFTW]]
deps = ["AbstractFFTs", "FFTW_jll", "LinearAlgebra", "MKL_jll", "Preferences", "Reexport"]
git-tree-sha1 = "505876577b5481e50d089c1c68899dfb6faebc62"
uuid = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
version = "1.4.6"

[[FFTW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c6033cc3892d0ef5bb9cd29b7f2f0331ea5184ea"
uuid = "f5851436-0d7a-5f13-b9de-f02708fd171a"
version = "3.3.10+0"

[[FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "246621d23d1f43e3b9c368bf3b72b2331a27c286"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "0.13.2"

[[FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[Gadfly]]
deps = ["Base64", "CategoricalArrays", "Colors", "Compose", "Contour", "CoupledFields", "DataAPI", "DataStructures", "Dates", "Distributions", "DocStringExtensions", "Hexagons", "IndirectArrays", "IterTools", "JSON", "Juno", "KernelDensity", "LinearAlgebra", "Loess", "Measures", "Printf", "REPL", "Random", "Requires", "Showoff", "Statistics"]
git-tree-sha1 = "13b402ae74c0558a83c02daa2f3314ddb2d515d3"
uuid = "c91e804a-d5a3-530f-b6f0-dfbca275c004"
version = "1.3.4"

[[Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[Hexagons]]
deps = ["Test"]
git-tree-sha1 = "de4a6f9e7c4710ced6838ca906f81905f7385fd6"
uuid = "a1b4810d-1bce-5fbd-ac56-80944d57a21f"
version = "0.2.0"

[[HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "SpecialFunctions", "Test"]
git-tree-sha1 = "cb7099a0109939f16a4d3b572ba8396b1f6c7c31"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.10"

[[Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[IndirectArrays]]
git-tree-sha1 = "012e604e1c7458645cb8b436f8fba789a51b257f"
uuid = "9b13fd28-a010-5f03-acff-a1bbcff69959"
version = "1.0.0"

[[IntelOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "d979e54b71da82f3a65b62553da4fc3d18c9004c"
uuid = "1d5cc7b8-4909-519e-a0f8-d0f5ad9712d0"
version = "2018.0.3+2"

[[InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[Interpolations]]
deps = ["AxisAlgorithms", "ChainRulesCore", "LinearAlgebra", "OffsetArrays", "Random", "Ratios", "Requires", "SharedArrays", "SparseArrays", "StaticArrays", "WoodburyMatrices"]
git-tree-sha1 = "b7bc05649af456efc75d178846f47006c2c4c3c7"
uuid = "a98d9a8b-a2ab-59e6-89dd-64a1c18fca59"
version = "0.13.6"

[[InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "b3364212fb5d870f724876ffcd34dd8ec6d98918"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.7"

[[IrrationalConstants]]
git-tree-sha1 = "7fd44fd4ff43fc60815f8e764c0f352b83c49151"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.1.1"

[[IterTools]]
git-tree-sha1 = "fa6287a4469f5e048d763df38279ee729fbd44e5"
uuid = "c8e1da08-722c-5040-9ed9-7db0dc04731e"
version = "1.4.0"

[[JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[Juno]]
deps = ["Base64", "Logging", "Media", "Profile"]
git-tree-sha1 = "07cb43290a840908a771552911a6274bc6c072c7"
uuid = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
version = "0.8.4"

[[KernelDensity]]
deps = ["Distributions", "DocStringExtensions", "FFTW", "Interpolations", "StatsBase"]
git-tree-sha1 = "591e8dc09ad18386189610acafb970032c519707"
uuid = "5ab0869b-81aa-558d-bb23-cbf5423bbe9b"
version = "0.6.3"

[[LazyArtifacts]]
deps = ["Artifacts", "Pkg"]
uuid = "4af54fe1-eca0-43a8-85a7-787d91b784e3"

[[LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[LinearAlgebra]]
deps = ["Libdl"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[Loess]]
deps = ["Distances", "LinearAlgebra", "Statistics"]
git-tree-sha1 = "46efcea75c890e5d820e670516dc156689851722"
uuid = "4345ca2d-374a-55d4-8d30-97f9976e7612"
version = "0.5.4"

[[LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "09e4b894ce6a976c354a69041a04748180d43637"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.15"

[[Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[MKL_jll]]
deps = ["Artifacts", "IntelOpenMP_jll", "JLLWrappers", "LazyArtifacts", "Libdl", "Pkg"]
git-tree-sha1 = "e595b205efd49508358f7dc670a940c790204629"
uuid = "856f044c-d86e-5d09-b602-aeab76dc8ba7"
version = "2022.0.0+0"

[[MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "3d3e902b31198a27340d0bf00d6ac452866021cf"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.9"

[[Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[Measures]]
git-tree-sha1 = "e498ddeee6f9fdb4551ce855a46f54dbd900245f"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.1"

[[Media]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "75a54abd10709c01f1b86b84ec225d26e840ed58"
uuid = "e89f7d12-3494-54d1-8411-f7d8b9ae1f27"
version = "0.5.0"

[[Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[NaNMath]]
git-tree-sha1 = "737a5957f387b17e74d4ad2f440eb330b39a62c5"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.0"

[[NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[OffsetArrays]]
deps = ["Adapt"]
git-tree-sha1 = "ec2e30596282d722f018ae784b7f44f3b88065e4"
uuid = "6fe1bfb0-de20-5000-8ca7-80f57d26f881"
version = "1.12.6"

[[OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"

[[OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "7f4869861f8dac4990d6808b66b57e5a425cfd99"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.13"

[[Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0044b23da09b5608b4ecacb4e5e6c6332f833a7e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.2"

[[Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8d1f54886b9037091edf146b517989fc4a09efec"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.39"

[[Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

[[QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "78aadffb3efd2155af139781b8a8df1ef279ea39"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.4.2"

[[REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[Random]]
deps = ["Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[Ratios]]
deps = ["Requires"]
git-tree-sha1 = "dc84268fe0e3335a62e315a3a7cf2afa7178a734"
uuid = "c84ed2f1-dad5-54f0-aa8e-dbefe2724439"
version = "0.4.3"

[[Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "bf3188feca147ce108c76ad82c2792c57abe7b1f"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.0"

[[Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "68db32dff12bb6127bac73c209881191bf0efbb7"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.3.0+0"

[[SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "a9e798cae4867e3a41cae2dd9eb60c047f1212db"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.1.6"

[[StaticArrays]]
deps = ["LinearAlgebra", "Random", "Statistics"]
git-tree-sha1 = "2bbd9f2e40afd197a1379aef05e0d85dba649951"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.4.7"

[[Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "2c11d7290036fe7aac9038ff312d3b3a2a5bf89e"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.4.0"

[[StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "8977b17906b0a1cc74ab2e3a05faa16cf08a8291"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.16"

[[StatsFuns]]
deps = ["ChainRulesCore", "HypergeometricFunctions", "InverseFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "5783b877201a82fc0014cbf381e7e6eb130473a4"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.0.1"

[[SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[WoodburyMatrices]]
deps = ["LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "de67fa59e33ad156a590055375a30b23c40299d3"
uuid = "efce3f68-66dc-5838-9240-27a6d6f5f9b6"
version = "0.5.5"

[[Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╟─c1750374-9588-11eb-1508-3b118006b44f
# ╟─22f15be9-79d8-4dea-8719-b19ea07f6472
# ╟─73ffed0d-da7e-4ae7-af7e-093f4ff5f9c7
# ╟─26a58a85-fc56-4b5b-927b-27cfdc24b569
# ╟─6efcd05a-493e-4955-9d02-fe342516851e
# ╠═3cf4b6f9-92b0-4928-8397-349552bb79ca
# ╠═3e51692c-a02e-45b0-8382-62dc457a005a
# ╠═4eb9b37c-8ff6-4211-b72d-513f703436f7
# ╠═ac69f968-fe9f-4286-a49a-c02e7511ab49
# ╠═d21bfe50-a146-47f2-8e98-494657dbe403
# ╠═b20b7728-ea7a-4fea-8f6c-c7962c6fdb12
# ╠═5fb60509-9cb0-40da-8bd8-9ab6c176d615
# ╠═8a474440-340b-48ec-9171-0500e483a638
# ╠═feb40e7a-a11c-473a-8d86-50eea06f35e5
# ╠═b34032ab-587d-46ae-b7fe-1066bfad71e4
# ╠═0b888dae-3961-4109-a9b9-40493bb2a11e
# ╠═bcb93797-4e18-40ee-ac14-28b67599f70a
# ╠═0b9dc6ca-b415-4099-ada9-1e851feb7fb5
# ╠═b33c8428-e2c5-4e14-84d6-7e47dcfd53a7
# ╠═723fefea-755e-49e6-a04d-6ef9c723d9c0
# ╠═bbcd8634-dfee-4682-a84e-dc1a27de8568
# ╠═95e101fe-1e9b-4921-a7dc-bc9234c324ff
# ╠═a4b87675-0d44-462c-a1b8-fb2c3423c5a8
# ╟─5b562504-1360-458c-8c8f-b4b0ef3c03ac
# ╠═88d07fa4-3a06-4e8f-82c8-4526c75f9f65
# ╠═e9478737-b7aa-420b-a2d2-6337b9ead277
# ╟─3e05a58a-5843-455e-b325-5de661519546
# ╠═6dd6bfdd-761c-4401-a1f9-e8f7338b6065
# ╠═5f9a6c06-ef80-4192-ad93-ae8771bd36ec
# ╠═ec993ea1-e3b2-40d0-9b0f-87d1af1123db
# ╟─2d9a0f87-9e26-4811-9d34-04fab13eab7a
# ╠═fb54571b-181d-46df-a980-01f469b3b063
# ╟─51089be0-f60e-41df-a939-2264e0cc4326
# ╟─74c45eab-7f77-4c86-80a0-f4466d3e4835
# ╠═fb05530a-d448-428c-8409-29cfc277dcc4
# ╟─f3bab895-776f-454d-ae13-373ba7e7ea6c
# ╠═0c8711b9-91ab-462f-a43a-c2246dc3b130
# ╟─edd1ed1e-15f7-4723-9a45-40483d3c9764
# ╠═6db3f2dd-9d07-4f4d-81a5-8ba8583b4dc9
# ╟─2e6f4de1-dcf0-4600-86b6-3d20c9ff818d
# ╠═eb56f4f2-750a-420e-8c31-dd0680ba2eec
# ╠═d0fe6856-5dcb-4cb7-a8ba-4b0434f466f8
# ╟─bca794b5-c530-4bcd-b802-bb242092cbb7
# ╟─814c2871-e446-4f77-ab9c-f8dcc5c51052
# ╠═a8ddf15c-5f52-4ab6-8f67-6b2e34643b63
# ╟─c7b696ef-2382-4595-8949-bf19bf5ea3a9
# ╟─17b20ee9-7afd-4d7b-aad3-0121776d982a
# ╠═1ce9212f-9501-4f7b-9a61-e00e453caefd
# ╟─4bd875a1-9211-4c5a-bedc-7ea1f40d7f20
# ╠═5c656a6a-5ff2-4175-8c0b-9d354feb8721
# ╟─ddb69c54-4036-44d0-be06-4f558cd82681
# ╠═0e8d5146-a802-4154-9e36-19034829dda4
# ╠═5aca49d6-df0e-40e1-829a-b8818468885c
# ╟─44d2cc30-71f3-4c8c-b0cf-db8fa737583c
# ╠═ad8ec88b-d7d5-46c8-98ee-a82bfcc00888
# ╠═9735a384-ea4e-4e45-b551-4298f70356d6
# ╠═84229915-c336-4cfb-8420-f15756cacb97
# ╟─bf15ffc9-e144-4641-b938-9848db689032
# ╟─96b2a92a-f78e-410f-879e-2136c556387f
# ╠═a631a9c3-1017-477e-939a-30a04f75ebda
# ╠═d5bba99e-3c14-4743-b01a-2423af1015a2
# ╠═ee4478b5-8db5-4b66-a078-6df4389fdf6f
# ╟─bf737810-9d66-4dcc-a9f0-cdfcdff46e99
# ╠═eb701b07-7d46-45e7-a662-ed40b4a9f715
# ╠═9400eef5-c56d-427e-b9c7-6a76649a3439
# ╠═3ff8a11f-1634-4c62-83d4-e08a818523a2
# ╠═deb54398-06f6-4f5a-8468-76d5dcb8c362
# ╠═a5acaf0d-3ebb-4f9b-8926-3b8c9bf2a825
# ╟─bce84be6-db02-413f-bf60-263618ec03e4
# ╠═3a5f8d46-a8a5-4a31-9dbb-ee13bcbbd288
# ╟─17b797a3-6130-4be3-a29f-1d413e5cec16
# ╠═b3777168-e054-4e6e-805d-345aa5a4a27d
# ╠═09d9bcfd-5489-4c35-8cfd-8e005e1b4784
# ╟─1c476dac-cfeb-4aff-989e-0ff8218d907e
# ╠═f6ca774b-0272-4d11-b350-3c2ad65b31f0
# ╠═48c80b28-fe38-456c-89c9-3c45d6e19523
# ╠═96b63203-f410-402e-b6db-645cc15c55d2
# ╟─f4ddc4eb-0391-42d6-9669-3157ab3c4c71
# ╠═2e834f9a-5027-4b24-8f1b-1f5625282976
# ╠═b40961bf-f2d7-4941-ac85-6526f02e935e
# ╠═7fae45ca-488d-4d94-9808-caf70a5ac125
# ╠═4ce99c97-df1d-4f48-bc09-277fc84ac7a4
# ╠═ac387ea7-853d-4d21-9f4c-32b9c4cb969c
# ╟─da719d14-eacf-4186-a031-82b219b82d45
# ╠═607c83a3-dd35-42c0-beef-dff0bed87dbd
# ╟─50fc4b79-5075-4419-917e-618278b98bd5
# ╠═bae76492-2603-482f-b220-1bba3fd3a512
# ╟─6928044a-3cf8-40da-87ee-07015e73a1b1
# ╠═8a82babe-e536-4a33-9463-1f956b64dd4a
# ╠═1c6b4e94-e6ab-4783-bfbc-11fded86ec95
# ╟─ea2d4ce1-2c84-415f-a407-e568f6d04382
# ╠═dc22e15b-c273-4cbc-91e5-d709e96451e1
# ╠═2213d948-2f08-4e4a-9f9d-1089b1915c83
# ╟─6a2aa3fe-21ec-40ae-9001-e06a468e335f
# ╠═d2682377-e205-4faf-a262-205121cb5837
# ╟─63f08a0b-197c-44f9-9f9a-8128cf6e2361
# ╠═087621ce-90ac-4969-9de2-0e66a8ddc7be
# ╠═ec1e47e1-c2e6-49ea-b341-23e27168549a
# ╠═15f9ad34-5222-47c5-92f0-7454c3cb82e2
# ╟─c5cc45e3-7ccd-4342-afc6-cb2f12c55550
# ╠═e3868568-6a02-4736-9b58-a44e59804bbb
# ╠═a51e58e4-44c8-4329-b572-a8a9ff4e2dea
# ╠═8d62fa8e-7dd6-4b4c-9df3-2e790a9f9610
# ╠═72e52881-a058-43d8-a660-9946a3d48c68
# ╠═e3eee1ef-7c53-4ade-92e6-95c29a19537a
# ╟─a41ab7a9-ec6c-45f5-88cc-b2e5cfd96049
# ╠═acda237b-0f60-4aeb-a8f9-1770535cd2f4
# ╠═fb8b9535-9180-41d6-abc5-cad967e825c8
# ╠═84d67df6-40dd-4c7d-9737-df1a804af35f
# ╠═49e30455-2395-4dcf-b59c-cb6845fb7ab1
# ╠═a54de1b8-8727-47fd-b5e9-0a605780e2a9
# ╠═a27b3553-6f73-4148-b4c8-8a78c841340d
# ╟─ceeb9e6c-6fcf-4dc3-b018-aa0328ce9548
# ╠═33559972-b742-46bd-bcf9-3a6bfcd46a35
# ╟─50c70cca-3d54-47ab-9864-bcaaea538446
# ╠═056bee64-ca5a-49c8-8f28-ac62dbf141cd
# ╟─f2f6dcb6-e234-46cf-831f-e3f9f9e494c7
# ╠═47cdefa0-83b7-41eb-8b5d-bfcb2a068e68
# ╟─6f2a11a5-4aed-4e10-8066-67ceac34b39c
# ╠═53a69a82-ee12-4eb2-9dbb-ba7b863e2b3b
# ╠═564fbfe6-dac0-4a97-9470-7df05a0e470a
# ╟─b70d58a5-a82b-4451-9158-5485f2d2a96d
# ╠═99a4bfef-48e4-46eb-87b7-1771dc6b69a2
# ╠═cead43a5-f979-42e7-88bc-9186d7978dd0
# ╠═0e0d7e41-4677-4c0a-bb9b-c4e5845ffa04
# ╟─34c79f6c-7ab9-4f49-9916-7ee37fb30b8c
# ╟─01fb9250-48ef-40ee-9203-194783d16715
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
