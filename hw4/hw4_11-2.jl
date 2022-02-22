### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ b919eb40-83f8-11ec-19dc-9dd78406e0bb
md"## Problem 11-2"

# ╔═╡ 2d8865e3-7a7c-4853-90b4-c200743dfc42
md"
Elementary reaction:

$A\leftrightharpoons B$

 $X_e=0.8$ at $T=127 ^\circ C$

 $X_e=0.5$ at $T=227 ^\circ C$

What is $\Delta H^\circ$?
"

# ╔═╡ 4162a064-7ed4-49b5-b907-031b7fe2fdc6
md"
$T_1=400K$

$T_2=500K$

Van't Hoff equation:

$\frac{d}{dT}\ln K_{eq}=\frac{\Delta H^\circ}{RT^2}$

$K_{eq}=\exp\left(\frac{3\Delta H^\circ T^3}{R}\right)$

$\frac{0.8}{0.5}=\exp\left(\frac{3\Delta H^\circ(400^3-500^3)}{R}\right)$

$\Delta H^\circ=\frac{\frac{R}{3}\ln\left(\frac{0.8}{0.5}\right)}{400^3-500^3}$
"

# ╔═╡ 7fa38964-3e43-4185-aa56-b7d71cfbadec
ΔH° = 1.987 * log(0.8 / 0.5) / 3 / (400^3 - 500^3)

# ╔═╡ 081723e2-4758-47ed-b98b-573017b786a0
begin
	local ans = round(ΔH°, digits=10)
	md"The enthalpy is $ans cal/mol"
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.7.0"
manifest_format = "2.0"

[deps]
"""

# ╔═╡ Cell order:
# ╟─b919eb40-83f8-11ec-19dc-9dd78406e0bb
# ╟─2d8865e3-7a7c-4853-90b4-c200743dfc42
# ╟─4162a064-7ed4-49b5-b907-031b7fe2fdc6
# ╠═7fa38964-3e43-4185-aa56-b7d71cfbadec
# ╟─081723e2-4758-47ed-b98b-573017b786a0
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
