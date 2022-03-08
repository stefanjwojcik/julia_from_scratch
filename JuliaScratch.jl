### A Pluto.jl notebook ###
# v0.12.7

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

# ╔═╡ 3107f7d2-6e63-11eb-0df3-a99d3b6dc30b
using Pkg

# ╔═╡ 85148a4a-4a37-11eb-3f0a-b78496a7e0f1
using Gadfly, RDatasets, ImageMagick

# ╔═╡ bf1ccad2-6e62-11eb-1cc0-f13e5463c8bd
using Images, LinearAlgebra, Pluto, PlutoUI

# ╔═╡ 2cf3d6c2-6e63-11eb-2d66-edac4ed385e8


# ╔═╡ b109bd0a-4a37-11eb-3410-db2cdd7bcffe
iris = dataset("datasets", "iris")

# ╔═╡ c1f3fe14-4a37-11eb-287d-dd7ac32f1dc1
p = plot(iris, x=:SepalLength, y=:SepalWidth, color=:Species, Geom.point)

# ╔═╡ c7fdc588-4a37-11eb-08f5-ed6fcbd73d02
file = download("https://uploads6.wikiart.org/images/salvador-dali/the-persistence-of-memory-1931.jpg!Large.jpg")

# ╔═╡ 18896c42-6e63-11eb-2dbb-a5c77deef2c3
img = load(file)

# ╔═╡ 829d8078-4a39-11eb-1920-27fcc0cabe34
channels = Float64.(channelview(img))

# ╔═╡ 89fe203c-4a39-11eb-055c-ef44930511f4
function rank_approx(M, k)
    U, S, V = svd(M)
    
    M = U[:, 1:k] * Diagonal(S[1:k]) * V[:, 1:k]'
    
    #M = min.(max.(M, 0.0), 1.)
end

# ╔═╡ 11b6d268-6e62-11eb-2508-933baa12d392
n = 100

# ╔═╡ 5a24a83a-6e63-11eb-20a8-d3e80ada44b1
@bind k1 Slider(1:n)

# ╔═╡ 5a28155e-6e63-11eb-188b-83851ff6cf07
@bind k2 Slider(1:n)

# ╔═╡ 5a297750-6e63-11eb-1c44-2f6085f4dec5
@bind k3 Slider(1:n)

# ╔═╡ a3268534-6e62-11eb-10ec-7b7a1203ae00
colorview(  RGB, 
            rank_approx(channels[1,:,:], k1),
            rank_approx(channels[2,:,:], k1),
            rank_approx(channels[3,:,:], k1)
)

# ╔═╡ af1516a8-6e62-11eb-314a-5ba685a6668e
U, S, V = svd(channels[1,:,:])

# ╔═╡ b7a160c4-6e62-11eb-041e-ab77e4cc56c6
k = 20

# ╔═╡ ae0597a0-6e63-11eb-1834-cf5536d79485
M = U[:, 1:k] * Diagonal(S[1:k]) * V[:, 1:k]'

# ╔═╡ ae07e886-6e63-11eb-365e-3f6b80523fac
max.([1,2,3], [3,5,6])

# ╔═╡ ae114a0a-6e63-11eb-2b67-613c4a1627ae
max.(M, 0.0)

# ╔═╡ ae12194e-6e63-11eb-0476-5ff67d701ef6
min.(max.(M, 0.0), 1.)

# ╔═╡ Cell order:
# ╠═3107f7d2-6e63-11eb-0df3-a99d3b6dc30b
# ╟─2cf3d6c2-6e63-11eb-2d66-edac4ed385e8
# ╠═85148a4a-4a37-11eb-3f0a-b78496a7e0f1
# ╠═bf1ccad2-6e62-11eb-1cc0-f13e5463c8bd
# ╠═b109bd0a-4a37-11eb-3410-db2cdd7bcffe
# ╠═c1f3fe14-4a37-11eb-287d-dd7ac32f1dc1
# ╠═c7fdc588-4a37-11eb-08f5-ed6fcbd73d02
# ╠═18896c42-6e63-11eb-2dbb-a5c77deef2c3
# ╠═829d8078-4a39-11eb-1920-27fcc0cabe34
# ╠═89fe203c-4a39-11eb-055c-ef44930511f4
# ╠═11b6d268-6e62-11eb-2508-933baa12d392
# ╠═5a24a83a-6e63-11eb-20a8-d3e80ada44b1
# ╠═5a28155e-6e63-11eb-188b-83851ff6cf07
# ╠═5a297750-6e63-11eb-1c44-2f6085f4dec5
# ╠═a3268534-6e62-11eb-10ec-7b7a1203ae00
# ╠═af1516a8-6e62-11eb-314a-5ba685a6668e
# ╠═b7a160c4-6e62-11eb-041e-ab77e4cc56c6
# ╠═ae0597a0-6e63-11eb-1834-cf5536d79485
# ╠═ae07e886-6e63-11eb-365e-3f6b80523fac
# ╠═ae114a0a-6e63-11eb-2b67-613c4a1627ae
# ╠═ae12194e-6e63-11eb-0476-5ff67d701ef6
