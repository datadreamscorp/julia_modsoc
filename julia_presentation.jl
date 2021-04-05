### A Pluto.jl notebook ###
# v0.14.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ dd624eae-a305-4bde-90f1-387e5a7792ea
begin
	using Pkg
	Pkg.activate( mktempdir() ) #activates a temporal directory for the session
								#very convenient for other users running your scripts
	Pkg.add(["Pipe", "Distributions", "PlutoUI", "Random"])
end

# ╔═╡ 53a69a82-ee12-4eb2-9dbb-ba7b863e2b3b
begin
	Pkg.add("Gadfly")
	using Gadfly
end

# ╔═╡ acda237b-0f60-4aeb-a8f9-1770535cd2f4
using Pipe, Random, Distributions, PlutoUI

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
typeof([1, 2, 3])

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
Array{Float64, 1}(undef, 3)

# ╔═╡ 0b9dc6ca-b415-4099-ada9-1e851feb7fb5
altered_array = copy(my_zero_array)

# ╔═╡ b33c8428-e2c5-4e14-84d6-7e47dcfd53a7
altered_array[4:7]

# ╔═╡ 723fefea-755e-49e6-a04d-6ef9c723d9c0
altered_array[5:6] .= 1

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
	my_arr = zeros(5)
	my_arr[5] = 1
	setdiff( my_arr, zeros(5) )
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
	return x + y
end

# ╔═╡ 09d9bcfd-5489-4c35-8cfd-8e005e1b4784
g1(2, 3) == g2(2, 3)

# ╔═╡ 1c476dac-cfeb-4aff-989e-0ff8218d907e
md"""
keyword arguments (name matters)
"""

# ╔═╡ f6ca774b-0272-4d11-b350-3c2ad65b31f0
function t(x, y; meow="meow")
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
x = 1; y = 2

# ╔═╡ 2213d948-2f08-4e4a-9f9d-1089b1915c83
if x > y
	"yes!"
else
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

# ╔═╡ 6f2a11a5-4aed-4e10-8066-67ceac34b39c
md"""
time to plot it:
"""

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
# ╠═dd624eae-a305-4bde-90f1-387e5a7792ea
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
# ╟─b70d58a5-a82b-4451-9158-5485f2d2a96d
# ╠═99a4bfef-48e4-46eb-87b7-1771dc6b69a2
# ╟─f2f6dcb6-e234-46cf-831f-e3f9f9e494c7
# ╠═47cdefa0-83b7-41eb-8b5d-bfcb2a068e68
# ╟─6f2a11a5-4aed-4e10-8066-67ceac34b39c
# ╠═53a69a82-ee12-4eb2-9dbb-ba7b863e2b3b
# ╠═564fbfe6-dac0-4a97-9470-7df05a0e470a
# ╠═cead43a5-f979-42e7-88bc-9186d7978dd0
# ╠═0e0d7e41-4677-4c0a-bb9b-c4e5845ffa04
# ╟─34c79f6c-7ab9-4f49-9916-7ee37fb30b8c
# ╟─01fb9250-48ef-40ee-9203-194783d16715
