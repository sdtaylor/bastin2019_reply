library(tidyverse)
library(broom)
library(kableExtra)
library(ggpmisc)

biome_names = read_csv('wwf_ecoregion_biomes.csv')

biomass_and_cover = read_csv('biome_data_from_random_points_with_protected_areas.csv') %>%
  #filter(!is.na(protected_area_status)) %>%
  filter(protected_area_status %in% c("Ia","Ib","II", "III","IV","V" )) %>%
  select(-protected_area_status) %>%
  mutate(above_ground_carbon = agb*0.5) %>%
  mutate(total_carbon = above_ground_carbon + soc) %>%
  gather(biomass_type, biomass, above_ground_carbon, soc, total_carbon) %>%
  left_join(biome_names, by='biome_id') %>%
  filter(complete.cases(.))


biome_counts = biomass_and_cover %>%
  count(biome_name)

bastin_carbon = read_csv('bastin_carbon_potential.csv') %>%
  rename(biomass = bastin_carbon_stock) %>%
  mutate(tree_cover = 100)
# Add in 0,0 points for drawing the line on the figures
# and copy it to all 3 biomass types for faceting
bastin_carbon = bastin_carbon %>%
  bind_rows(mutate(., biomass=0, tree_cover=0)) %>%
  full_join(expand.grid(biome_name = bastin_carbon$biome_name, biomass_type = c('above_ground_carbon','total_carbon')),
                        by = 'biome_name')

# Adjust the carbon storage/ha potential from Bastin estimates to remove the fraction that is SOC
bastin_carbon = bastin_carbon %>%
  mutate(biomass = case_when(
    biomass_type == 'above_ground_carbon' ~ biomass *(1-percent_soc),
    TRUE ~ biomass
  ))

# Pretty names for the different carbon pools
base_levels = c('above_ground_carbon','soc','total_carbon')
nice_names = c('Above Ground Carbon','Soil Organic Carbon','Total Carbon')
bastin_carbon$biomass_type = factor(bastin_carbon$biomass_type, levels = base_levels,labels = nice_names)
biomass_and_cover$biomass_type = factor(biomass_and_cover$biomass_type, levels = base_levels,labels = nice_names)
#############################################
# large plot of all 3 biomass types x ecoregion

large_plot_biomes = c('Boreal Forests/Taiga','Tropical Grasslands, Savannas & Shrublands',
                      'Temperate Broadleaf & Mixed Forests', 'Deserts & Xeric Shrublands',
                      'Tropical Moist Broadleaf Forests','Temperate Grasslands, Savannas & Shrublands')

large_plot = ggplot(filter(biomass_and_cover,biome_name %in% large_plot_biomes), aes(x=tree_cover, y=biomass)) + 
  geom_point(alpha=0.5, color='grey60', shape=1) + 
  #scale_fill_viridis_c() + 
  #geom_smooth(color='#0072B2') +
  geom_smooth(method = 'gam', color = 'black', size=1) + 
  stat_poly_eq(aes(label =  paste(stat(eq.label), stat(adj.rr.label), sep = "~~~~")),
               formula = y~x, rr.digits = 3, coef.digits = 3, parse = TRUE,
               size=2.5) + 
  geom_line(data = filter(bastin_carbon,biome_name %in% large_plot_biomes), color='#D55E00', size=1) + 
  facet_wrap(biome_name~biomass_type, scales = 'free_y', ncol=3) +
  theme_bw() +
  theme(strip.text = element_text(size=7),
        axis.text = element_text(size=8),
        axis.title = element_text(size=10)) + 
  labs(x='Percent Tree Cover',y='Tonnes C/Ha')
ggsave('manuscript/fig1_carbon_stock_plots.png', plot = large_plot, width = 20, height = 26, units = 'cm', dpi=400)

# the large plot again but all biomes
large_plot_all_biomes = ggplot(biomass_and_cover, aes(x=tree_cover, y=biomass)) + 
  geom_point(alpha=0.5, color='grey60', shape=1) + 
  #scale_fill_viridis_c() + 
  #geom_smooth(color='#0072B2') +
  geom_smooth(method = 'gam', color = 'black', size=1) + 
  stat_poly_eq(aes(label =  paste(stat(eq.label), stat(adj.rr.label), sep = "~~~~")),
               formula = y~x, rr.digits = 3, coef.digits = 3, parse = TRUE,
               size=2.5) + 
  geom_line(data = bastin_carbon, color='#D55E00', size=1) + 
  facet_wrap(biome_name~biomass_type, scales = 'free_y', ncol=3) +
  theme_bw() +
  theme(strip.text = element_text(size=7),
        axis.text = element_text(size=8),
        axis.title = element_text(size=10)) + 
  labs(x='Percent Tree Cover',y='Tonnes C/Ha')
ggsave('manuscript/figS1_carbon_stock_plots_all_biomes.png', plot = large_plot_all_biomes, width = 20, height = 60, units = 'cm', dpi=300)

# Just total carbon and a single biome for diagnostic plots
focal_biome = 'Temperate Grasslands, Savannas & Shrublands'
biomass_and_cover %>%
  filter(biome_name == focal_biome) %>%
  ggplot(aes(x=tree_cover, y=biomass)) + 
  geom_point(alpha=0.5, color='grey60', shape=1, size=4) + 
  stat_poly_eq(aes(label =  paste(stat(eq.label), stat(adj.rr.label), sep = "~~~~")),
               formula = y~x, rr.digits = 3, coef.digits = 2, parse = TRUE,
               size=5) + 
  geom_smooth(method = 'lm', color = 'black', size=3) + 
  geom_line(data = filter(bastin_carbon,biome_name ==focal_biome), color='#D55E00', size=3) + 
  facet_wrap(biome_name~biomass_type , scales = 'free_y', ncol=3) +
  theme_bw(base_size=25) +
  labs(x='% Tree Cover', y='Tonnes C/Ha')

########################################################
# Calculate the estimate of slopes from Figure 1
biome_coefficients = biomass_and_cover %>%
  group_by(biome_name, biomass_type) %>%
  do(tidy(lm(biomass ~ tree_cover, data = .))) %>%
  ungroup() %>%
  filter(term == 'tree_cover', biomass_type %in% c('Above Ground Carbon','Total Carbon')) %>%
  select(biome_name, biomass_type, carbon_coef = estimate, carbon_coef_std_error = std.error) %>%
  mutate(source = 'Current Estimates')

bastin_carbon_coefficients = read_csv('bastin_carbon_potential.csv') %>%
  mutate(total_carbon= bastin_carbon_stock / 100,
         above_ground_carbon = (bastin_carbon_stock *(1-percent_soc)) / 100) %>%
  select(-bastin_carbon_stock, -percent_soc) %>%
  gather(biomass_type, carbon_coef, total_carbon, above_ground_carbon) %>%
  mutate(carbon_coef_std_error = 0,
         source = 'Bastin Estimates - Original') %>%
  mutate(biomass_type = factor(biomass_type, levels = base_levels,labels = nice_names))

biome_coefficients = biome_coefficients %>%
  bind_rows(bastin_carbon_coefficients) 

biome_coefficients$biome_name = forcats::fct_reorder(biome_coefficients$biome_name, -biome_coefficients$carbon_coef)

##################################################
bastin_tree_potential = read_csv('bastin_restoration_potential.csv')

biome_coefficients = biome_coefficients %>%
  left_join(bastin_tree_potential, by='biome_name')


biome_carbon_potential = biome_coefficients %>%
  mutate(T_C_ha_potential = carbon_coef*100,
         GtC_potential = ((carbon_coef*100 * 10**6) * restoration_potential_Mha)/10**9) %>%
  select(-carbon_coef, -carbon_coef_std_error)


##################################
# Table 1 data
table_data = biome_carbon_potential %>%
  select(-restoration_potential_Mha) %>%
  gather(value_type, value, T_C_ha_potential, GtC_potential) %>%
  mutate(value = round(value,1)) %>%
  mutate(col_header = paste(biomass_type, value_type, source)) %>%
  select(-biomass_type, -value_type, -source) %>%
  spread(col_header, value) 
