### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ a340cb16-83f0-11ec-190e-8934e726715b
md"## Problem 5-11"

# ╔═╡ 9260c4e9-61fa-4858-a944-1e829d084b85
md"
Reaction (gas-phase, elementary, irreversible):

$A+B\rightarrow C+D$

PBR, isothermal.

 $T=305K$, $W=100kg$, $P_0=20atm$, $P=2atm$, $F_{A0}=F_{B0}=10\frac{mol}{min}$, $C_{A0}=0.4\frac{mol}{L}$

$X=0.8$

What would be $X^\prime$ if catalyst particle size were doubled?
"

# ╔═╡ 2ec52be5-c162-4f23-a087-80753d67339e
md"
Ergun equation:

$\frac{dP}{dz}=-\beta\frac{P_0TF_T}{PT_0F_{T0}}$

$X^\prime=\frac{\beta}{\beta^\prime}X$

With $\epsilon=0$:

$\beta=\frac{R_e}{\rho_0g_cD_p}\left(\frac{1-\phi}{\phi^3}\right)\left[\frac{150(1-\phi)\mu}{D_p}+1.75R_e\right]$

Doubling the catalyst particle diameter:

$\beta^\prime=\frac{R_e}{2\rho_0g_cD_p}\left(\frac{1-\phi}{\phi^3}\right)\left[\frac{150(1-\phi)\mu}{2D_p}+1.75R_e\right]$

Taking the ratio and multiplying top and bottom by $D_p$:

$\frac{\beta}{\beta^\prime}=\frac{1}{2}\frac{150(1-\phi)\mu+1.75R_eD_p}{75(1-\phi)\mu+1.75R_eD_p}$

For turbulent flow, $R_e\ge3500$, and for a gas-phase reaction, $\mu\approx 10^{-5}$.  Therefore:

$\frac{\beta}{\beta^\prime}\approx\frac{1}{2}\frac{0+1.75R_eD_p}{0+1.75R_eD_p}$

$X=\frac{1}{2}X^\prime=0.4$
"

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
# ╟─a340cb16-83f0-11ec-190e-8934e726715b
# ╟─9260c4e9-61fa-4858-a944-1e829d084b85
# ╟─2ec52be5-c162-4f23-a087-80753d67339e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
