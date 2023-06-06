### A Pluto.jl notebook ###
# v0.19.19

using Markdown
using InteractiveUtils

# ╔═╡ 692c08de-a0ba-11ed-305a-3ba25318db34
begin
	using Pkg
	Pkg.activate("/home/aureliano/Documentos/git/julia_modsoc/test01")
	using Revise
end

# ╔═╡ 206b44a8-0adb-4458-94c1-8809554dab65
using test01, Plots, CSV, DataFrames

# ╔═╡ 3767cad8-4749-4d76-928e-bdef8a66485a
test01.greet()

# ╔═╡ 7b259494-52bc-4edc-8162-73d8da076772
test01.lol(1)

# ╔═╡ 2e666f4e-3965-4d31-8d60-2e4df74dca52
test01.lmao(2)

# ╔═╡ 81a5079f-b64a-47c9-ab02-503275dc2d5a
countries = DataFrame( CSV.File("life_expectancy_years.csv") )

# ╔═╡ ae8f086d-5f97-49a4-8088-d98d798835f9
complete_countries = countries[completecases(countries), :]

# ╔═╡ 19c25843-40a3-4480-80d6-9900b05c3e48
countries_1800 = complete_countries[:, "1800"]

# ╔═╡ 75c4c4b9-d22c-449e-93b5-a0e263593903
histogram(
	countries_1800,
	xlab="life expectancy in the year 1800",
	ylab="number of countries",
	legend=false
)

# ╔═╡ 34908973-7771-4746-a258-5a1b22ba06b3
countries_1900 = complete_countries[:, "1900"]

# ╔═╡ 5a68a867-8b04-4809-93e4-a5ac91508c85
begin
	scatter(
		countries_1800, 
		countries_1900,
		xlab="life expectancy in 1800",
		ylab="life expectancy in 1900",
		legend=false,
		alpha=0.5
	)
	plot!( x -> 31 + 1.1(x-30) )
end

# ╔═╡ dd2e0414-e6b2-4d64-b4a7-4f5e91fc2895


# ╔═╡ Cell order:
# ╠═692c08de-a0ba-11ed-305a-3ba25318db34
# ╠═206b44a8-0adb-4458-94c1-8809554dab65
# ╠═3767cad8-4749-4d76-928e-bdef8a66485a
# ╠═7b259494-52bc-4edc-8162-73d8da076772
# ╠═2e666f4e-3965-4d31-8d60-2e4df74dca52
# ╠═81a5079f-b64a-47c9-ab02-503275dc2d5a
# ╠═ae8f086d-5f97-49a4-8088-d98d798835f9
# ╠═19c25843-40a3-4480-80d6-9900b05c3e48
# ╟─75c4c4b9-d22c-449e-93b5-a0e263593903
# ╠═34908973-7771-4746-a258-5a1b22ba06b3
# ╠═5a68a867-8b04-4809-93e4-a5ac91508c85
# ╠═dd2e0414-e6b2-4d64-b4a7-4f5e91fc2895
