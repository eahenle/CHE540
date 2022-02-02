### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ be529a68-c026-43cb-922a-43b158de9b0b
using DataFrames

# ╔═╡ 346a8cb8-83cd-11ec-0b47-9789dadf6790
md"""## Problem 5-13

Wouldn't it be much easier to sabotage the methylamine by adding bleach?  Just a thought.

Chemical reaction: $2A\rightleftharpoons B+C$

Gas-phase, elementary rate law.

 $k_1=4.25*10^{-6} \frac{mol}{atm^2g_{cat}s}$ and $K_e=2.5$

Inlet conditions $F_{A0}=23.6\frac{mol}{s}$ and $P_0=18atm$

Initially, assume no pressure drop or temperature change across the reactor.
"""

# ╔═╡ f33d8bda-8be8-496e-937a-0225753773d2
md"### (a)

Write the mole balance.
"

# ╔═╡ 29f464ed-37b9-4d9f-9e2f-49de4d118a34
md"
$\frac{dC_A}{dW}=-2\frac{dC_B}{dW}=-2\frac{dC_C}{dW}$

or

$\frac{dP_A}{dW}=-2\frac{dP_B}{dW}=-2\frac{dP_C}{dW}$

and

$\frac{dX}{dW}=\frac{-{r_A}^\prime}{F_{A0}}$
"

# ╔═╡ 436c0e19-6aa2-4a71-91eb-b3e40eb292fd
md"### (b)

Write the rate law in terms of partial pressures.
"

# ╔═╡ 986ae795-cbd6-412b-9440-10851850ce64
md"
$-r_A = k_1P_A^2 - k_2P_BP_C$

$k_2=\frac{k_1}{K_e}$

$P_B=P_C$

$-r_A=k_1\left(P_A^2-\frac{P_B^2}{K_e}\right)$
"

# ╔═╡ 24ff79d8-62ef-4939-b5b1-c70c7dbe00fa
md"### (c)

Set up a stoichiometric table for this reaction.
"

# ╔═╡ 958b42b7-465c-4ce8-b621-fe928f54e78a
begin
	local species = [md"$methylamine$", md"$dimethylamine$", md"$ammonia$"]
	local symbol  = [md"$A$", md"$B$", md"$C$"]
	local initial = [md"$N_{A0}$", md"$N_{B0}=0$", md"$N_{C0}=0$"]
	local change  = [
		md"$-XN_{A0}$", 
		md"$\frac{1}{2}XN_{A0}$", 
		md"$\frac{1}{2}XN_{A0}$"
	]
	local net     = [
		md"$N_A=N_{A0}(1-X)$", 
		md"$N_B=\frac{1}{2}XN_{A0}$", 
		md"$N_C=\frac{1}{2}XN_{A0}$"
	]
	
	DataFrame(
		:Species => species, 
		:Symbol => symbol, 
		:Initial => initial, 
		:Change => change,
		:Net => net
	)
end

# ╔═╡ cddb2657-28b8-415f-a75a-17ebd037f2dd
md"### (d)

Write the partial pressures in terms of conversion.
"

# ╔═╡ 991c17ea-3e1b-4cc8-a81b-20c0e860f446
md"
$P_A=P_0(1-X)$
$P_B=P_C=\frac{1}{2}XP_0$
"

# ╔═╡ 55c5c429-9d8e-44ad-9b7e-16e7390159e9
md"### (e)

Write the rate law solely in terms of conversion.
"

# ╔═╡ ac25e899-72b8-4061-81a7-2b4ba389718a
md"
$-r_A=k_1\left(P_A^2-\frac{P_B^2}{K_e}\right)$

$-r_A=k_1\left((P_0(1-X))^2-\frac{(\frac{1}{2}XP_0)^2}{K_e}\right)$

$-r_A=k_1P_0^2\left(1-2X+X^2\left(1-\frac{1}{4K_e}\right)\right)$
"

# ╔═╡ 0a8ddc1c-155b-4685-92b2-5500c2987eef
md"### (f)

What is the equilibrium conversion $X_e$?
"

# ╔═╡ 0144a85f-8bd0-4c10-b747-9ed2838788a0
md"
$-r_A=k_1P_0^2\left(1-2X_e+X_e^2\left(1-\frac{1}{4K_e}\right)\right)=0$

$\left(1-\frac{1}{4K_e}\right)X_e^2-2X_e+1=0$

Solving the quadratic and taking the physical root (i.e. $X\le 1$):
"

# ╔═╡ 55e9cb1f-2ad7-4215-b085-05f35f2d896d
begin
	# set up coefficients
	Kₑ = 2.5
	local a = 1 - 0.25 / Kₑ
	local b = -2
	local c = 1
	# solve quadratic
	X_partf = 0.5 .* (-b .+ [1, -1] .* √(b^2 - 4*a*c)) ./ a
	# record roots for subsequent parts
	p, q = X_partf

	md"The roots are $p and $q"
end

# ╔═╡ 006f3c4e-e9c1-4751-9ebc-1255afcc1211
begin
	# take the root that is within [0, 1]
	local X = X_partf
	Xₑ = round(X[X .≤ 1][1], digits=4)
	
	md"The conversion is $Xₑ"
end

# ╔═╡ 725ddbb1-d5b5-417b-95b6-b6aff03ad9d3
md"### (g)

Write out your algorithm in terms of conversion.
"

# ╔═╡ 4ad98170-2c5f-48a7-976c-664464982cc7
md"
I think this means: express $W$ in terms of $X$ (or vice-versa).

$\frac{dX}{dW}=\frac{{-r_A}^\prime}{F_{A0}}$

$\frac{dX}{dW}=\frac{k_1P_0^2}{F_{A0}}\left(1-2X_e+X_e^2\left(1-\frac{1}{4K_e}\right)\right)\left(\frac{P}{P_0}\right)^2$

$\frac{P}{P_0}=1$

$dW=\frac{F_{A0}}{k_1P_0^2}\frac{dX}{1-2X_e+X_e^2\left(1-\frac{1}{4K_e}\right)}$

$\int dW=\frac{F_{A0}}{k_1P_0^2}\int\frac{dX}{1-2X_e+X_e^2\left(1-\frac{1}{4K_e}\right)}$

 $p,q\equiv$ quadratic roots from previous part.  Applying the integral formula from Fogler (A-11):

$W=\frac{F_{A0}}{k_1P_0^2}\frac{1}{(1-\frac{1}{4K_e})(p-q)}\ln\left(\frac{q(X-p)}{p(X-q)}\right)$
"

# ╔═╡ 1b057c98-7919-444e-9745-5fde0262001d
md"### (h)

How much catalyst is needed in a PBR to obtain 75 % and 90 % of equilibrium conversion?
"

# ╔═╡ 95d9741c-ec01-4569-a0eb-1ffc2c839629
begin
	# set up coefficients
	P₀ = 18 # atm
	Fₐ₀ = 23.6 # mol/s
	k₁ = 4.25e-6 # mol/atm²/g_cat/s

	# weight expression
	W_PBR(X) = 
		Fₐ₀ * log(q * (X - p) / p / (X - q)) / k₁ / P₀^2 / (1 - 1 / 4 / Kₑ) / (p - q)
end;

# ╔═╡ 28a12f0f-9381-4893-a3db-ce46dc4302db
begin
	# solve for X = 0.75Xₑ
	local Wₓ = W_PBR(0.75 * Xₑ)
	# convert to kg and round
	local Wₓ = round(Wₓ / 1e3, digits=1)
	md"The catalyst weight to achieve 75 % of equilibrium conversion is $Wₓ kg"
end

# ╔═╡ f08452de-7dd4-4a96-af22-672e4a2450e6
begin
	# solve for X = 0.9Xₑ
	local Wₓ = W_PBR(0.9 * Xₑ)
	# convert to kg and round
	local Wₓ = round(Wₓ / 1e3, digits=1)
	md"The catalyst weight to achieve 90 % of equilibrium conversion is $Wₓ kg"
end

# ╔═╡ 8c7cf5f2-3e5f-4b3c-90d9-bf46253cb1ef
md"### (i)

How much catalyst would be needed to obtain 90 % of equilibrium conversion in a fluidized-bed reactor?  How can the weight be reduced?
"

# ╔═╡ a57cd095-d83d-4e10-8cef-1b30f15f12bd
md"
Fluidized-bed reactor performance equation:

$W=\frac{F_{A0}X}{-r_A}$

Catalyst weight expression:

$W=\frac{F_{A0}X}{k_1P_0^2\left(1-2X_e+X_e^2\left(1-\frac{1}{4K_e}\right)\right)}$
"

# ╔═╡ 08585b44-6455-440f-82c8-48d26cba2e3b
begin
	# weight expression
	W_FBR(X) = Fₐ₀ * X / k₁ / P₀^2 / (1 - 2 * Xₑ + Xₑ^2 * (1 - 1 / 4 / Kₑ))
	# solve for the catalyst weight
	local Wₓ = W_FBR(0.9 * Xₑ)
	# convert to tonnes and round
	local Wₓ = Int(round(Wₓ / 1e6, digits=0))
	
md"
The mass of catalyst is $Wₓ tonnes (which would cost in the neighborhood of 10M USD!)
	
To reduce the required mass (without changing reactor type), either the inlet pressure must be increased or the molar flow rate decreased.
"
end

# ╔═╡ 9a67247d-ea70-499e-94cc-98d0aedc04bf
md"### (j)

What conversion is achieved in a 100 kg PBR, accounting for pressure drop with $\alpha=0.0098 kg^{-1}$?  What mass of catalyst is needed to keep the exit pressure ≥ 1 atm?
"

# ╔═╡ 45ac293d-c40e-4d62-9cfd-75742bb33c3b
md"
$\frac{dX}{dW}=\frac{{-r_A}^\prime}{F_{A0}}$

$\frac{dX}{dW}=\frac{k_1P_0^2}{F_{A0}}\left(1-2X_e+X_e^2\left(1-\frac{1}{4K_e}\right)\right)\left(\frac{P}{P_0}\right)^2$

$\frac{P}{P_0}=\sqrt{1-\alpha W}$

$\int(1-\alpha W)dW=\frac{F_{A0}}{k_1P_0^2}\int\frac{dX}{1-2X_e+X_e^2\left(1-\frac{1}{4K_e}\right)}$

$W-\frac{\alpha}{2}W^2=\frac{F_{A0}}{k_1P_0^2}\frac{1}{(1-\frac{1}{4K_e})(p-q)}\ln\left(\frac{q(X-p)}{p(X-q)}\right)$
"

# ╔═╡ 94c66ce8-69cf-4016-91c0-bd6217f1f6e5
begin
	# set weight
	W = 100 # kg
	# left- and right-hand terms of above expression
	lefthand_term(α) = W - α * W^2 / 2
	righthand_term(X) = 
		Fₐ₀ * log(q * (X - p) / p / (X - q)) / k₁ / P₀^2 / (1 - 1 / 4 / Kₑ) / (p - q)
end;

# ╔═╡ bf4c8ebe-f1c3-4175-a0d6-119441e5a35e
function X_with_P_drop(α)
	# calcualte the left-hand term
	L = lefthand_term(α)
	# calculate the right-hand term over the interval X ∈ [0, 1]
	X_range = Complex.(0:0.01:1) # complex nums to avoid log(x < 0) errors
	R = righthand_term.(X_range)
	# find the index of the X value giving the minimum error between L and R
	i = argmin(abs.(R .- L))
	# get the corresponding X value
	return real(X_range[i])
end;

# ╔═╡ 2727bdbb-f2f5-4988-a5bd-b4c1cac2c791
begin
	local X = X_with_P_drop(0.0098)
md"
The calculation above gives a conversion of $X
	
This does not seem correct...
"
end

# ╔═╡ 6e2e43e3-b80b-48ab-90b8-f9504c8d9f80
md"
$\frac{P}{P_0}=\sqrt{1-\alpha W}$

Catalyst weight to achieve a specific outlet pressure:

$W=\frac{1}{\alpha}\left(1-\frac{P^2}{P_0^2}\right)$
"

# ╔═╡ 8dbf0195-cfcf-4ffe-95cf-c0b560167211
W_for_P_out(P, α) = (1 - P^2 / P₀^2) / α;

# ╔═╡ b0d005b5-8b6b-46c8-8664-09b4f3d8e45b
begin
	# calculate catalyst weight for given P, α
	local W = W_for_P_out(1, 0.0098)
	# round
	local W = round(W, digits=1)
md"
To maintain atmospheric pressure at the outlet of the reactor, no more than $W kg of catalyst may be used.
"
end

# ╔═╡ a92d1f1b-9a5c-44d5-b03a-2f8318405087
md"### (k)

Repeat **(j)** with $\alpha=6*10^{-4}$
"

# ╔═╡ 0626a76c-2ea4-4111-8767-1597dc349505
begin
	local X = X_with_P_drop(6e-4)
md"
The conversion calculated is $X

Again, this result is suspiciously tiny...
"
end

# ╔═╡ 2c06c678-19cd-4e27-8afc-aa831d2caeb3
begin
	local W = W_for_P_out(1, 6e-4)
	W = Int(round(W, digits=0))
md"
To maintain atmospheric pressure at the outlet of the reactor, no more than $W kg of catalyst may be used.
"
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"

[compat]
DataFrames = "~1.3.2"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Compat]]
deps = ["Base64", "Dates", "DelimitedFiles", "Distributed", "InteractiveUtils", "LibGit2", "Libdl", "LinearAlgebra", "Markdown", "Mmap", "Pkg", "Printf", "REPL", "Random", "SHA", "Serialization", "SharedArrays", "Sockets", "SparseArrays", "Statistics", "Test", "UUIDs", "Unicode"]
git-tree-sha1 = "44c37b4636bc54afac5c574d2d02b625349d6582"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "3.41.0"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "cc70b17275652eb47bc9e5f81635981f13cea5c8"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.9.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Reexport", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "ae02104e835f219b8930c7664b8012c93475c340"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.3.2"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "3daef5523dd2e769dad2365274f760ff5f282c7d"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.11"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.Downloads]]
deps = ["ArgTools", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "bee5f1ef5bf65df56bdd2e40447590b272a5471f"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.1.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "bf210ce90b6c9eed32d25dbcae1ebc565df2687f"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.0.2"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"

[[deps.OrderedCollections]]
git-tree-sha1 = "85f8e6578bf1f9ee0d11e7bb1b1456435479d47c"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.4.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "db3a23166af8aebf4db5ef87ac5b00d36eb771e2"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "Markdown", "Reexport", "Tables"]
git-tree-sha1 = "dfb54c4e414caa595a1f2ed759b160f5a3ddcba5"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "1.3.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SharedArrays]]
deps = ["Distributed", "Mmap", "Random", "Serialization"]
uuid = "1a1011a3-84de-559e-8e89-a11a2f7dc383"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "b3363d7460f7d098ca0912c69b082f75625d7508"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.0.1"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "TableTraits", "Test"]
git-tree-sha1 = "bb1064c9a84c52e277f1096cf41434b675cd368b"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.6.1"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
"""

# ╔═╡ Cell order:
# ╠═be529a68-c026-43cb-922a-43b158de9b0b
# ╟─346a8cb8-83cd-11ec-0b47-9789dadf6790
# ╟─f33d8bda-8be8-496e-937a-0225753773d2
# ╟─29f464ed-37b9-4d9f-9e2f-49de4d118a34
# ╟─436c0e19-6aa2-4a71-91eb-b3e40eb292fd
# ╟─986ae795-cbd6-412b-9440-10851850ce64
# ╟─24ff79d8-62ef-4939-b5b1-c70c7dbe00fa
# ╟─958b42b7-465c-4ce8-b621-fe928f54e78a
# ╟─cddb2657-28b8-415f-a75a-17ebd037f2dd
# ╟─991c17ea-3e1b-4cc8-a81b-20c0e860f446
# ╟─55c5c429-9d8e-44ad-9b7e-16e7390159e9
# ╟─ac25e899-72b8-4061-81a7-2b4ba389718a
# ╟─0a8ddc1c-155b-4685-92b2-5500c2987eef
# ╟─0144a85f-8bd0-4c10-b747-9ed2838788a0
# ╠═55e9cb1f-2ad7-4215-b085-05f35f2d896d
# ╠═006f3c4e-e9c1-4751-9ebc-1255afcc1211
# ╟─725ddbb1-d5b5-417b-95b6-b6aff03ad9d3
# ╟─4ad98170-2c5f-48a7-976c-664464982cc7
# ╟─1b057c98-7919-444e-9745-5fde0262001d
# ╠═95d9741c-ec01-4569-a0eb-1ffc2c839629
# ╠═28a12f0f-9381-4893-a3db-ce46dc4302db
# ╠═f08452de-7dd4-4a96-af22-672e4a2450e6
# ╟─8c7cf5f2-3e5f-4b3c-90d9-bf46253cb1ef
# ╟─a57cd095-d83d-4e10-8cef-1b30f15f12bd
# ╠═08585b44-6455-440f-82c8-48d26cba2e3b
# ╟─9a67247d-ea70-499e-94cc-98d0aedc04bf
# ╟─45ac293d-c40e-4d62-9cfd-75742bb33c3b
# ╠═94c66ce8-69cf-4016-91c0-bd6217f1f6e5
# ╠═bf4c8ebe-f1c3-4175-a0d6-119441e5a35e
# ╠═2727bdbb-f2f5-4988-a5bd-b4c1cac2c791
# ╟─6e2e43e3-b80b-48ab-90b8-f9504c8d9f80
# ╠═8dbf0195-cfcf-4ffe-95cf-c0b560167211
# ╠═b0d005b5-8b6b-46c8-8664-09b4f3d8e45b
# ╟─a92d1f1b-9a5c-44d5-b03a-2f8318405087
# ╠═0626a76c-2ea4-4111-8767-1597dc349505
# ╠═2c06c678-19cd-4e27-8afc-aa831d2caeb3
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
