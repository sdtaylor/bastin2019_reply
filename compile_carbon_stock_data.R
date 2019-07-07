library(raster)
library(tidyverse)

base_data_folder = '/home/shawn/data/global_biomass_and_treecover/'

############################################
ecoregions = rgdal::readOGR(paste0(base_data_folder,'wwf_terrestrial_biomes'),'wwf_terr_ecos')

aboveground_biomass_raster_files = list.files(paste0(base_data_folder,'aboveground_carbon') ,pattern = 'aboveground_biomass_ha_2000', full.names = T)
tree_cover_raster_files = list.files(paste0(base_data_folder,'tree_cover') ,pattern = 'Hansen_GFC', full.names = T)
belowground_carbon_file = paste0(base_data_folder,'belowground_carbon/OCSTHA_M_100cm_250m_ll.tif')
################################################
# Use the WWF Ecoregion dataset to generate a global set of random points from which
# to extract biomass and cover data with. These will be restricted to land.

set.seed(208)
random_point_count = 1000
points_spatial = sp::spsample(ecoregions, n=random_point_count, type='random')
points_spatial = SpatialPointsDataFrame(points_spatial, data=data.frame(point_id = 1:random_point_count))
points_df = as_tibble(points_spatial)

##############################################
# Get ecoregions for all point
points_df$biome_id =sp::over(points_spatial, ecoregions)$BIOME


##############################################

final_data = tibble()


# Iterate over each 10 deg. x 10 deg. grid cell raster and extract data from it
# points falling outside the raster grid cell will be NA and thus discarded. 
progress = 1
for(raster_file in tree_cover_raster_files){
  r = raster::raster(raster_file)
  this_raster_point_data = points_df %>%
    mutate(data_value = raster::extract(r, points_spatial)) %>%
    filter(!is.na(data_value)) %>%
    mutate(data_type = 'tree_cover')
  
  final_data = final_data %>%
    bind_rows(this_raster_point_data)
  
  print(paste('tree_cover: ',progress, 'of ', length(tree_cover_raster_files), 'files'))
  progress = progress + 1
  
}

progress = 1
for(raster_file in aboveground_biomass_raster_files){
  r = raster::raster(raster_file)
  this_raster_point_data = points_df %>%
    mutate(data_value = raster::extract(r, points_spatial)) %>%
    filter(!is.na(data_value)) %>%
    mutate(data_type = 'agb')
  
  final_data = final_data %>%
    bind_rows(this_raster_point_data)
  
  print(paste('aboveground_biomass: ',progress, 'of ', length(aboveground_biomass_raster_files), 'files'))
  progress = progress + 1
}

# belowground is a single tif
r = raster::raster(belowground_carbon_file)
this_raster_point_data = points_df %>%
  mutate(data_value = raster::extract(r, points_spatial)) %>%
  filter(!is.na(data_value)) %>%
  mutate(data_type = 'soc')

final_data = final_data %>%
  bind_rows(this_raster_point_data)

###################################################################

final_data = final_data %>%
  spread(data_type, data_value)

write_csv(final_data, 'biome_data_from_random_points.csv')
