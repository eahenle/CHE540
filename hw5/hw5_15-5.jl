### A Pluto.jl notebook ###
# v0.17.5

using Markdown
using InteractiveUtils

# ╔═╡ a71eca2a-8e23-11ec-2c14-7580b8f43ec3
md"## Problem 15-5"

# ╔═╡ cb2d6283-088b-4adc-89dc-ae758558b420
md"
For the first-order irreversible reaction $A\rightarrow B$ in a spherical catalyst pellet, $C_A(R/2)=\frac{1}{10}C_{A,s}$.  $C_{A,s}=10^{-6}$ mol/cm³, $R=0.001$ cm, and $D=0.1$ cm²/s.
"

# ╔═╡ f143cf88-7335-4252-abc4-09629dcd643d
begin
	# constants used throughout
	D = 0.1
	R₁ = 0.001
	Cₐₛ = 1e-6
	# range of possible ϕ values to consider (0 to 10 by 0.0001)
	ϕ_range = 1e-4:1e-4:10
end;

# ╔═╡ 7e3059d8-2a83-4df1-92ac-94c10582f726
md"**(a)** What is the concentration of reactant at $r=3*10^{-4}$ cm?"

# ╔═╡ 96a6443d-3a1f-4b83-be5c-faaf97565fae
md"
$\frac{C_A}{C_{A,s}}=\frac{R\sinh(r\phi/R)}{r\sinh\phi}$

Solving numerically for $\phi$ such that $(r=\frac{1}{2}R)\rightarrow\left( \frac{C_A}{C_{A,s}}=\frac{1}{10} \right)$:
"

# ╔═╡ 6f0a264f-62f5-4f8a-9e58-1dcb14a8bf57
begin
	# radial position
	local r = R₁/2
	# expression for right-hand side of equation above
	f(ϕ) = R₁ * sinh(r * ϕ / R₁) / r / sinh(ϕ)
	# find the value of ϕ that gives the ratio closest to 1/10
	local i = argmin(abs.(f.(ϕ_range) .- 0.1))
	ϕ₁ = ϕ_range[i]
	

md"
 $\phi=$ $(round(ϕ₁, digits=2))
"
end

# ╔═╡ 3a2e7a8a-a384-4a76-bf1d-3976922545e1
md"
$C_A=C_{A,s}\frac{R\sinh(r\phi/R)}{r\sinh\phi}$
"

# ╔═╡ 75ae4832-ad18-4a73-94b0-01104f6c28c9
begin
	# radial position
	local r = 3e-4
	# calculate the concentration using the calculated ϕ
	Cₐ = Cₐₛ * R₁ * sinh(r * ϕ₁ / R₁) / r / sinh(ϕ₁)

md"
 $C_A=$ $(round(Cₐ, digits=10)) M
"
end

# ╔═╡ 012e6fa9-157d-4d1f-962d-db2e4b3f7650
md"**(b)** What diameter of pellet should be used to obtain an effectiveness factor of $\eta=0.8$?"

# ╔═╡ ed765d53-39f6-4c82-8c18-0159961646b5
md"
$\phi=R\sqrt{\frac{k}{D}}$

$k=D\left( \frac{\phi}{R} \right)^2$

Using the value for $\phi$ calculated above:
"

# ╔═╡ 555b4819-c04d-49f2-a666-1ee7ed7e35a2
k = D * (ϕ₁ / R₁)^2

# ╔═╡ 8981f25e-d308-405d-a92c-a31c0e757ac3
md"
$\eta=\frac{3}{\phi^2}(\phi\coth\phi-1)$

Calculating the value of $\phi$ needed for the new catalyst particle:
"

# ╔═╡ 6110d2c7-e492-4f04-8653-b041239197e4
begin
	# expression for η
	η(ϕ) = 3 * (ϕ * coth(ϕ) - 1) / ϕ^2
	# find the ϕ that puts η closest to 0.8
	local i = argmin(abs.(η.(ϕ_range) .- 0.8))
	ϕ₂ = ϕ_range[i]

md"
 $\phi=$ $(round(ϕ₂, digits=2))
"
end

# ╔═╡ 4cdb372f-5dd3-4835-8dc1-a2aeb3348210
md"
Combining:

$R=\phi\sqrt{\frac{D}{k}}=0.9187\sqrt{\frac{0.1}{3.58*10^6}}$
"

# ╔═╡ 2b3babb3-b504-4a06-8b20-3eb676b44358
begin
	# calculate radius
	R = ϕ₂ * √(D / k)
	# convert to diameter, in nm
	dₚ = Int(round(2*R, digits=5)*1e6)
end

# ╔═╡ 7c1e06ea-97f4-4171-bd3d-59ec34b6e349
md"
The new particle should be $dₚ nm in diameter. That is extremely small! Grinding particles to sub-micron sizes is effort-intensive, and a packed bed of such a powder produces very high resistance to fluid flow.
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
# ╟─a71eca2a-8e23-11ec-2c14-7580b8f43ec3
# ╟─cb2d6283-088b-4adc-89dc-ae758558b420
# ╠═f143cf88-7335-4252-abc4-09629dcd643d
# ╟─7e3059d8-2a83-4df1-92ac-94c10582f726
# ╟─96a6443d-3a1f-4b83-be5c-faaf97565fae
# ╠═6f0a264f-62f5-4f8a-9e58-1dcb14a8bf57
# ╟─3a2e7a8a-a384-4a76-bf1d-3976922545e1
# ╠═75ae4832-ad18-4a73-94b0-01104f6c28c9
# ╟─012e6fa9-157d-4d1f-962d-db2e4b3f7650
# ╟─ed765d53-39f6-4c82-8c18-0159961646b5
# ╠═555b4819-c04d-49f2-a666-1ee7ed7e35a2
# ╟─8981f25e-d308-405d-a92c-a31c0e757ac3
# ╠═6110d2c7-e492-4f04-8653-b041239197e4
# ╟─4cdb372f-5dd3-4835-8dc1-a2aeb3348210
# ╠═2b3babb3-b504-4a06-8b20-3eb676b44358
# ╟─7c1e06ea-97f4-4171-bd3d-59ec34b6e349
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
