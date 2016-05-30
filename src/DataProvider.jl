module DataProvider

@static in("BasePlus", keys(Pkg.installed())) ? nothing : Pkg.clone("https://github.com/zhmz90/BasePlus.jl.git")

using BasePlus 

include("dataprovider.jl")

end # module
