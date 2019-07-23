library(tidyverse)
library(broom)
library(kableExtra)
library(ggpmisc)

biome_names = read_csv('wwf_ecoregion_biomes.csv')

biomass_and_cover = read_csv('biome_data_from_random_points.csv') %>%
  mutate(above_ground_carbon = agb*0.5) %>%
  mutate(total_carbon = above_ground_carbon + soc) %>%
  gather(biomass_type, biomass, above_ground_carbon, soc, total_carbon) %>%
  left_join(biome_names, by='biome_id') %>%
  filter(complete.cases(.))

biome_counts = biomass_and_cover %>%
  count(biome_name)

bastin_carbon = read_csv('bastin_carbon_potential.csv') %>%
  #mutate(biomass =  (bastin_carbon_stock *(1-percent_soc))) %>%
  mutate(biomass = bastin_carbon_stock) %>%
  mutate(tree_cover = 100)
# Add in 0,0 points for drawing the line on the figures
# and copy it to all 3 biomass types for faceting
bastin_carbon = bastin_carbon %>%
  bind_rows(mutate(., biomass=0, tree_cover=0)) %>%
  full_join(expand.grid(biome_name = bastin_carbon$biome_name, biomass_type = c('above_ground_carbon','soc','total_carbon')),
                        by = 'biome_name')

#############################################
# large plot of all 3 biomass types x ecoregion
large_plot = ggplot(biomass_and_cover, aes(x=tree_cover, y=biomass)) + 
  geom_point(alpha=0.5, color='grey60', shape=1) + 
  #scale_fill_viridis_c() + 
  #geom_smooth(color='#0072B2') +
  geom_smooth(method = 'gam', color = 'black', size=1) + 
  stat_poly_eq(aes(label =  paste(stat(eq.label), stat(adj.rr.label), sep = "~~~~")),
               formula = y~x, rr.digits = 3, coef.digits = 3, parse = TRUE,
               size=1.5) + 
  geom_line(data = bastin_carbon, color='#D55E00', size=1) + 
  facet_grid(str_wrap(biome_name, 20)~biomass_type, scales = 'free_y') +
  theme_bw(5) +
  labs(x='Percent Tree Cover',y='Tonnes C/Ha')
ggsave('biomass_plots.png', plot = large_plot, width = 10, height = 25, units = 'cm', dpi=400)

# Just total carbon and a single biome
focal_biome = 'Tropical & Subtropical Dry Broadleaf Forests'
biomass_and_cover %>%
  filter(biome_name == focal_biome, biomass_type=='total_carbon') %>%
  ggplot(aes(x=tree_cover, y=biomass)) + 
  geom_point(alpha=0.5, color='grey60', shape=1, size=4) + 
  stat_poly_eq(aes(label =  paste(stat(eq.label), stat(adj.rr.label), sep = "~~~~")),
               formula = y~x, rr.digits = 3, coef.digits = 2, parse = TRUE,
               size=5) + 
  #scale_fill_viridis_c() + 
  geom_smooth(color='#0072B2') +
  #geom_smooth(method = 'lm', color = 'black', size=3) + 
  geom_line(data = filter(bastin_carbon,biome_name ==focal_biome, biomass_type=='total_carbon'), color='#D55E00', size=3) + 
  scale_y_continuous(breaks=seq(0,500,100)) + 
  #ylim(0,500) + 
  coord_cartesian(ylim=c(0,500)) + 
  facet_wrap(~biome_name , scales = 'free_y', ncol=3) +
  theme_bw(base_size=25) +
  labs(x='% Tree Cover', y='Tonnes C/Ha')

##########
# mean carbon totals per biome
mean_values = biomass_and_cover %>%
  group_by(biome_name, biomass_type) %>%
  summarise(mean_carbon = mean(biomass))

########################################################
biome_coefficients = biomass_and_cover %>%
  #sample_frac(0.3) %>%
  group_by(biome_name, biomass_type) %>%
  do(tidy(lm(biomass ~ tree_cover, data = .))) %>%
  ungroup() %>%
  filter(term == 'tree_cover', biomass_type %in% c('above_ground_carbon','total_carbon')) %>%
  select(biome_name, biomass_type, carbon_coef = estimate, carbon_coef_std_error = std.error) %>%
  mutate(source = 'Current Estimates')

bastin_carbon_coefficients = read_csv('bastin_carbon_potential.csv') %>%
  mutate(total_carbon= bastin_carbon_stock / 100,
         above_ground_carbon = (bastin_carbon_stock *(1-percent_soc)) / 100) %>%
  select(-bastin_carbon_stock, -percent_soc) %>%
  gather(biomass_type, carbon_coef, total_carbon, above_ground_carbon) %>%
  mutate(carbon_coef_std_error = 0,
         source = 'Bastin Estimates - Original')

biome_coefficients = biome_coefficients %>%
  bind_rows(bastin_carbon_coefficients) 

biome_coefficients$biome_name = forcats::fct_reorder(biome_coefficients$biome_name, -biome_coefficients$carbon_coef)

ggplot(biome_coefficients, aes(x=str_wrap(biome_name, 30), y=carbon_coef * 100, fill=source)) +
  #geom_errorbarh(data = filter(biome_coefficients, source=='Current Estimates'),  
  #               aes(xmin = (carbon_coef - (carbon_coef_std_error*1.96)) * 100, 
  #               xmax = (carbon_coef + (carbon_coef_std_error*1.96))*100),
  #               height=0.5, color='grey20', size=1) +
  #geom_point(size=5) +
  geom_col(position = position_dodge(width = 0.5), width = 0.5) + 
  scale_fill_manual(values = c('#D55E00','black')) + 
  #xlim(-5,5) + 
  #geom_vline(xintercept = 0, size=1) + 
  theme_bw() +
  theme(axis.text = element_text(size=15),
        axis.title = element_text(size=20),
        axis.text.x = element_text(angle=60, hjust = 1, debug = F),
        panel.grid = element_line(color='grey60'),
        legend.position = c(0.4, 0.8),
        legend.text = element_text(size=20),
        legend.title = element_blank(),
        legend.background = element_rect(color='grey40')) +
  labs(y = 'Tonnes carbon stock potential added\n for every Ha of canopy cover', x='')

##################################################
bastin_tree_potential = read_csv('bastin_restoration_potential.csv')

biome_coefficients = biome_coefficients %>%
  left_join(bastin_tree_potential, by='biome_name')


biome_carbon_potential = biome_coefficients %>%
  mutate(T_C_ha_potential = carbon_coef*100,
         GtC_potential = ((carbon_coef*100 * 10**6) * restoration_potential_Mha)/10**9) %>%
  select(-carbon_coef, -carbon_coef_std_error)


##################################
# Table
table_data = biome_carbon_potential %>%
  select(-restoration_potential_Mha) %>%
  gather(value_type, value, T_C_ha_potential, GtC_potential) %>%
  mutate(value = round(value,0)) %>%
  mutate(col_header = paste(biomass_type, value_type, source)) %>%
  select(-biomass_type, -value_type, -source) %>%
  spread(col_header, value) 

write_csv(table_data, 'derived_data/table_data.csv')
# %>%
#   #filter(!biome_name %in% c('Boreal Forests/Taiga','Tundra')) %>%
#   group_by(source, biomass_type) %>%
#   summarise(global_total = sum(GtC_potential))


# figure of uncertainty of total carbon estimated with current data
biome_coefficients %>%
  group_by(biome_name, biomass_type, source) %>%
  do(tibble(carbon_coef = rnorm(1000, mean = .$carbon_coef, sd = .$carbon_coef_std_error),
            bootstrap = 1:1000)) %>%
  ungroup() %>%
  left_join(bastin_tree_potential, by='biome_name') %>%
  mutate(GtC_potential = ((carbon_coef*100 * 10**6) * restoration_potential_Mha)/10**9) %>%
  filter(!biome_name %in% c('Boreal Forests/Taiga','Tundra')) %>%
  group_by(source, bootstrap) %>%
  summarise(global_total = sum(GtC_potential)) %>%
  filter(source=='the data') %>%
ggplot(aes(global_total, color=source)) + 
  geom_density()

  
#################################