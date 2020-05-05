# ~/znb/corona/corona.jl
# 200422 001
# Corresponds to notebook corona.ipynb

#=
We start out by getting the data running debian/linux bash shell:
~/znb/corona$ git clone https://github.com/bumbeishvili/covid19-daily-data 

# These are the files we get:
ls covid19-daily-data 
misc  README.md  time_series_19-covid-Confirmed.csv  time_series_19-covid-Deaths.csv  time_series_19-covid-Recovered.csv

# Now we can look into the time series of confirmed cases, running Julia:
=#

using CSV, DataFrames, Dates, Printf, Plots

df_cfm = CSV.read("covid19-daily-data/time_series_19-covid-Confirmed.csv")

countries = df_cfm[:,2]

ind_ar = findall(x->x=="Argentina", countries)
ind_be = findall(x->x=="Belgium", countries)
ind_br = findall(x->x=="Brazil", countries)
ind_no = findall(x->x=="Norway", countries)
ind_sp = findall(x->x=="Spain", countries)
ind_sw = findall(x->x=="Sweden", countries)
ind_th = findall(x->x=="Thailand", countries)

cfm_ar = convert(Array, df_cfm[ind_ar,5:end]);
cfm_be = convert(Array, df_cfm[ind_be,5:end]);
cfm_br = convert(Array, df_cfm[ind_br,5:end]);
cfm_no = convert(Array, df_cfm[ind_no,5:end]);
cfm_sp = convert(Array, df_cfm[ind_sp,5:end]);
cfm_sw = convert(Array, df_cfm[ind_sw,5:end]);
cfm_th = convert(Array, df_cfm[ind_th,5:end]);

colstring = Array{Union{Nothing, String}}(nothing, length(names(df_cfm))-4,2)
coldates  = Array{Date,length(names(df_cfm))-4}
for i in 1:length(names(df_cfm))-4 colstring[i,1] = String(names(df_cfm)[i+4])*"20" end #  adding 20 to year  
colstring2=colstring
for i=1:length(colstring[:,1]) colstring2[i,1]=replace(colstring[i,1], "/" => "-") end
coldates=Date.(colstring2[:,1], Dates.DateFormat("mm-dd-yyyy"))
df_00 = DataFrame([coldates])
rename!(df_00, :x1 => :Date);

df_ar = DataFrame(cfm_ar'); rename!(df_ar, :x1 => :Argentina);
df_be = DataFrame(cfm_be'); rename!(df_be, :x1 => :Belgium);
df_br = DataFrame(cfm_br'); rename!(df_br, :x1 => :Brazil);
df_no = DataFrame(cfm_no'); rename!(df_no, :x1 => :Norway);
df_sp = DataFrame(cfm_sp'); rename!(df_sp, :x1 => :Spain);
df_sw = DataFrame(cfm_sw'); rename!(df_sw, :x1 => :Sweden);
df_th = DataFrame(cfm_th'); rename!(df_th, :x1 => :Thailand);
df_cfm_sam = hcat(df_00, df_ar, df_be, df_br, df_no, df_sp, df_sw, df_th)

# EOF


