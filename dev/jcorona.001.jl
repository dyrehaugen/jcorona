# ~/znb/corona/corona.jl  -- downloaded from ~/znb/corona/corona.ipynb
# 200422 002
                                                                    
#=
We start out by getting the data running debian/linux bash shell:
$ clone https://github.com/bumbeishvili/covid19-daily-data

# These are the files we get:                                                                                                 
$ ls covid19-daily-data
misc  README.md  time_series_19-covid-Confirmed.csv  time_series_19-covid-Deaths.csv  time_series_19-covid-Recovered.csv

Now we can look into the time series of confirmed cases, running Julia:                                                      
=#


using CSV, DataFrames, Dates, Printf, Plots

df_cfm_src = CSV.read("covid19-daily-data/time_series_19-covid-Confirmed.csv")

countries = df_cfm_src[:,2]

# Specify which countries to extract:
clist  = ["Argentina" "Belgium" "Brazil" "Norway" "Spain" "Sweden" "Thailand"]


# Extracting the epidemic data:
cindx = Array{Int64}(undef, length(clist))
cfm   = zeros(size(df_cfm_src)[2]-4, length(clist)); # Data starts in column 4
for i in 1:length(clist)
    indx = findall(x->x==clist[i], df_cfm_src[:,2])  
    cfm[:,i] = convert(Array, df_cfm_src[indx,5:end])
end
df_cfm = DataFrame(cfm)
for i in 1:length(clist)
     rename!(df_cfm, names(df_cfm)[i] => Symbol(clist[i])); 
end                  
df_cfm


# Converting the Dates:
colstring = Array{Union{Nothing, String}}(nothing, length(names(df_cfm_src))-4,2)
coldates  = Array{Date,length(names(df_cfm_src))-4}
for i in 1:length(names(df_cfm_src))-4 colstring[i,1] = String(names(df_cfm_src)[i+4])*"20" end #  adding 20 to get 2020  
colstring2=colstring
for i=1:length(colstring[:,1]) colstring2[i,1]=replace(colstring[i,1], "/" => "-") end
coldates=Date.(colstring2[:,1], Dates.DateFormat("mm-dd-yyyy"))
df_00 = DataFrame([coldates])
rename!(df_00, :x1 => :Date)

# Joining Dates and Data:
df_cfm = hcat(df_00, df_cfm)

CSV.write("df_cfm.csv", df_cfm)

plot(df_cfm[:,1], cfm[:,2:end],
     label = clist,
     legend=:outertopright, xrotation=45,
     title = "Corona 2020\nConfirmed Cases - Selected Countries")


savefig("cfm_01.png") 


