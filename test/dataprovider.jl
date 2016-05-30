dir_name = "sample1"
l1fq1 = joinpath(dir_name, "l1fq1.fq.gz")
l1fq2 = joinpath(dir_name, "l1fq2.fq.gz")
l2fq1 = joinpath(dir_name, "l2fq1.fq.gz")
l2fq2 = joinpath(dir_name, "l2fq2.fq.gz")
files = [l1fq1, l1fq2, l2fq1, l2fq2]
try
    mkdir(dir_name)
    map(touch, reverse(files))

    d = @task dataprovider(dir_name)

    i = 1
    while true
        fq = consume(d)
        if fq == "END"
            break
        end
        fq1, fq2 = fq
        fq1 = files[i]
        fq2 = files[i+1]
        i += 2
    end
finally
    rm(dir_name, recursive=true)
end


