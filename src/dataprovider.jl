
export dataprovider

abstract Provider

# The layout of Fastq directory
# fastq/
# ├── read1.fq
# └── read2.fq
# assume data_dir is shared by all the workers
immutable FastqProvider <: Provider
    sample_dir::String
end

function dataprovider{T<:AbstractString}(sample_dir::T)
    fqs = readdirpath(sample_dir, sorted=true)
    fqs = filter(file->endswith(file, ".fq.gz"), fqs)
    len = length(fqs)
    @assert len % 2 == 0
    num_fq = div(len, 2)
    fqs_pe = reshape(fqs, 2, num_fq)
    for i in 1:num_fq
        @show fqs_pe[:,i]
        produce(fqs_pe[:, i])
    end
    produce("END")
end

dataprovider(fastq_provider::FastqProvider) = dataprovider(fastq_provider.sample_dir)
