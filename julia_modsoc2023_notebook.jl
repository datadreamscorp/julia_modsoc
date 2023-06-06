### A Pluto.jl notebook ###
# v0.19.19

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

# ╔═╡ 186568b4-6dc8-4167-8d9e-3d939ef19f5b
begin
	using Pkg
	Pkg.activate("./julia_modsoc2023")
end

# ╔═╡ e188d79b-4dc5-49b0-8d3e-e349fe8a7bc0
using Revise

# ╔═╡ 5874ac06-8eb9-4f44-af6a-1fd5ca052d40
using Plots, DataFrames, CSV

# ╔═╡ 54088a26-d4b9-47c3-ab16-3adbea88b678
using julia_modsoc2023

# ╔═╡ bf9879e4-6a1b-4634-a974-501eb9b494ff
using Random, Distributions

# ╔═╡ d75c0fe0-fdad-42d2-b132-c34d94a2862b
using PlutoUI

# ╔═╡ 88d912a3-21de-40ee-aa15-ee9083102d28
julia_modsoc2023.greet()

# ╔═╡ 1c9383d7-9782-4d7b-8900-e47005f52738
julia_modsoc2023.sum_x_y(1,2)

# ╔═╡ c211450b-f15c-45bb-b57b-7332ef05cec0
d = DataFrame( CSV.File("./life_expectancy_years.csv") )

# ╔═╡ f9ac222a-0ddd-450c-ba29-ee82b2848619
d[1,2]

# ╔═╡ fb3882d5-b2bf-46dc-8f61-11f68be40f0f
d_complete = d[ completecases(d), : ]

# ╔═╡ a3153df2-a58b-4607-b836-42e84b60d649
d_complete[:, "1800"]

# ╔═╡ 3c862f14-caa3-442b-bb19-1acb6b87e363
histogram(
	d_complete[:,"1800"],
	xlab="life expectancy",
	ylab="number of countries",
	legend=false
)

# ╔═╡ bb484e30-dec9-4097-8020-0492a38c21f3
vertline = 50

# ╔═╡ c56c17d1-1e64-450c-8f94-5b7ea6851305
begin
	scatter(
		d_complete[:, "1800"], 
		d_complete[:, "1900"],
		xlab="life expectancy 1800",
		ylab="life expectancy 1900",
		legend=false
	)
	plot!( c -> 32 + 1.1*(c - 30) )
	vline!([vertline])
end

# ╔═╡ 91527bd3-fa83-4a1d-917d-6a1c26b37f0a
julia_modsoc2023.blah(2)

# ╔═╡ 96e113f0-758a-4db5-9803-0933b3232598
x -> x + y

# ╔═╡ be471fdc-de54-40b0-ab00-fac083001b2e
julia_modsoc2023.add_all(5)

# ╔═╡ c044f16e-e777-4501-ab60-8f1664a2107f
julia_modsoc2023.add_all_even(5)

# ╔═╡ 61c8e763-e27d-4055-858e-03f6c9f96055
julia_modsoc2023.add_all_even_and_three(10)

# ╔═╡ 5d4a8522-2860-4c37-9993-1bdfb39e2d51
@bind n Slider(10:10000)

# ╔═╡ b00778e2-fa12-40a3-95b8-03787f0a0028
begin
	h = histogram( rand(Normal(0,1), n), legend=false )
	for i in 1:10
		histogram!( rand(Normal(0,1), n*2), legend=false, color="red", alpha=0.2 )
	end
	h
end

# ╔═╡ Cell order:
# ╠═186568b4-6dc8-4167-8d9e-3d939ef19f5b
# ╠═e188d79b-4dc5-49b0-8d3e-e349fe8a7bc0
# ╠═5874ac06-8eb9-4f44-af6a-1fd5ca052d40
# ╠═54088a26-d4b9-47c3-ab16-3adbea88b678
# ╠═88d912a3-21de-40ee-aa15-ee9083102d28
# ╠═1c9383d7-9782-4d7b-8900-e47005f52738
# ╠═c211450b-f15c-45bb-b57b-7332ef05cec0
# ╠═f9ac222a-0ddd-450c-ba29-ee82b2848619
# ╠═fb3882d5-b2bf-46dc-8f61-11f68be40f0f
# ╠═a3153df2-a58b-4607-b836-42e84b60d649
# ╠═3c862f14-caa3-442b-bb19-1acb6b87e363
# ╠═bb484e30-dec9-4097-8020-0492a38c21f3
# ╠═c56c17d1-1e64-450c-8f94-5b7ea6851305
# ╠═91527bd3-fa83-4a1d-917d-6a1c26b37f0a
# ╠═96e113f0-758a-4db5-9803-0933b3232598
# ╠═be471fdc-de54-40b0-ab00-fac083001b2e
# ╠═c044f16e-e777-4501-ab60-8f1664a2107f
# ╠═61c8e763-e27d-4055-858e-03f6c9f96055
# ╠═bf9879e4-6a1b-4634-a974-501eb9b494ff
# ╠═d75c0fe0-fdad-42d2-b132-c34d94a2862b
# ╠═5d4a8522-2860-4c37-9993-1bdfb39e2d51
# ╠═b00778e2-fa12-40a3-95b8-03787f0a0028
