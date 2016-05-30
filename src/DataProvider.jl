module DataProvider

function __init__()
    if !in("BasePlus", keys(Pkg.installed()))
        Pkg.clone("https://github.com/zhmz90/BasePlus.jl.git")
    end
end

using BasePlus

include("dataprovider.jl")

end # module
