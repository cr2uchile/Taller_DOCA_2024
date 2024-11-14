
variables=("2m_temperature" "u_component_of_wind_500" "v_component_of_wind_500")

# Procesamiento de cada variable
for variable in "${variables[@]}"; do
    input_file="./gridded_data/ERA5/raw/${variable}.nc" 
    output_daily="./gridded_data/ERA5/processed/mean/${variable}_daily_mean.nc"
    output_monthly="./gridded_data/ERA5/processed/mean/${variable}_monthly_mean.nc"
    output_yearly="./gridded_data/ERA5/processed/mean/${variable}_year_mean.nc"

    # Calcular promedio diario
    cdo daymean "$input_file" "$output_daily"
    
    # Calcular promedio mensual
    cdo monmean "$output_daily" "$output_monthly"
    
    # Calcular promedio anual
    cdo yearmean "$output_monthly" "$output_yearly"

done

cdo cat ./gridded_data/CR2MET/raw/*.nc ./gridded_data/CR2MET/preprocessed/CR2MET_tmean_2022.nc

cdo daymean ./gridded_data/CR2MET/preprocessed/CR2MET_tmean_2022.nc ./gridded_data/CR2MET/processed/mean/CR2MET_tmean_2022_daily_mean.nc

cdo monmean ./gridded_data/CR2MET/processed/mean/CR2MET_tmean_2022_daily_mean.nc ./gridded_data/CR2MET/processed/mean/CR2MET_tmean_2022_monthly_mean.nc

cdo yearmean ./gridded_data/CR2MET/processed/mean/CR2MET_tmean_2022_monthly_mean.nc ./gridded_data/CR2MET/processed/mean/CR2MET_tmean_2022_yearly_mean.nc
