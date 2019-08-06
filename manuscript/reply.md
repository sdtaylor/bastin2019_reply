---
title: "Rethinking global carbon storage potential of trees. A comment on Bastin et. al 2019"

author:
- Shawn D. Taylor$^1$ (corresponding author), shawntaylor@weecology.org
- Sergio Marconi$^1$

csl: csl.csl
output:
  pdf_document:
    keep_tex: false
  html_document: false
  latex_engine: xelatex
geometry: left=3.5cm, right=3.5cm, top=2.25cm, bottom=2.25cm, headheight=12pt, letterpaper
header-includes:
- \usepackage{times}
- \usepackage{setspace}
- \usepackage{booktabs}
- \doublespacing
- \usepackage{lineno}
- \linenumbers
fontsize: 12pt
bibliography: refs.bib
---
\raggedright

\small
$^1$ School of Natural Resources and Environment, University of Florida Gainesville, FL, United States  

\normalsize
\newpage

# Abstract
In calculating the potential carbon storage potential stemming from global tree restoration Bastin et al. 2019 use two flawed assumptions: 1) that a hectare of additional canopy is equivalent to gaining the full potential of a hectare in carbon stock, and 2) that soil organic carbon (SOC) from increased canopy cover will accumulate quickly enough to mitigate anthropogenic carbon emissions. We use global datasets of tree cover, soil organic carbon, and above ground biomass to estimate the empirical relationships of tree cover and carbon stock storage. A more realistic range is between 73 and 85 GtC globally, with a large uncertainty associated with SOC. This is roughly half of the original 205 GtC estimate, and just around twice the annual anthropogenic emissions globally. While we agree on the value of assessing global reforestation potential, we suggest caution in considering it the most effective strategy to mitigate anthropogenic emissions.

# Main
-@bastin2019 (hereafter referred to as Bastin 2019) use a novel machine learning based method to model global tree canopy cover potential. After accounting for current tree canopy cover and areas already occupied by urban and agricultural land they estimate 900 Mha of potential tree canopy cover available worldwide for reforestation. Using biome specific estimates of Tonnes C/ha they calculate the global carbon storage potential of this 900 Mha of tree canopy cover. The Tonnes/C ha-1 values for each biome are derived from average estimates of total carbon storage from two studies of forest [@pan2011] and tropical grassland [@grace2006] carbon stock. Thus from their calculation a hectare of restored tree canopy is equivalent to adding a full hectare of carbon stock potential regardless of the vegetation already in place, and results in an overestimate of the global carbon stock potential of restored trees. 

To better estimate the relationship between total carbon stock density and tree cover we randomly sampled one million locations from four global datasets of 1) above ground biomass  [@baccini2012; @ABG2019], 2) soil organic carbon to 1-meter [@hengl2017], 3) percent tree cover [@hansen2013], and 4) the corresponding biome [@olson2001]. Across all biomes there is already ample carbon stock at all levels of tree cover, and the slope of this relationship is a more accurate representation of the potential carbon stock gained with tree cover (Figure 1). For example in Tropical Grasslands Bastin 2019 estimate that an additional 0.5 ha of canopy cover (an additional 50% canopy cover) will add 141.25 Tonnes C. The empirical relationship shows an additional 50% tree cover in this biome means an additional 76.9 Tonnes C/Ha on average. Further, the Boreal Forest and Tundra biomes have a negative relationship between carbon stock and tree canopy cover, potentially resulting in a net carbon source if tree canopy cover was added in these biomes. Applying the updated estimates across all 14 biomes results in 25 GtC of potential carbon stock if the additional 900 Mha of global tree canopy potential was realized, and 85 GtC if the negative contribution from Boreal and Tundra biomes are removed. 

This calculation is further complicated by soil organic carbon (SOC). SOC makes up the majority of carbon stock in all biomes, and in 4 biomes has a negative relationship with tree cover (Boreal, Tundra, Flooded Grasslands, and Temperate Conifer). In boreal regions (the biome for 19.8% of the potential canopy area estimated by Bastin 2019) afforestation can cause a temporary increase of greenhouse gas emissions due to quicker SOC mineralization, which can take several decades to recover [@karhu2011]. SOC also forms at rates of less than 0.5 Mg/Ha-1/year-1 in many areas [@trumbore1997; @gaudinski2000; @lichter2008, but see -@shi2014] and it is potentially unreasonable to assume increased tree cover would lead to SOC accumulation at a rate quick enough to effectively mitigate carbon emissions [@he2016]. To explore the potential carbon storage of increased global tree cover without considering the complexities of SOC we adjusted all estimates by removing the contribution of SOC. For the Bastin 2019 estimates we re-calculated the carbon stock potential minus the SOC fraction using the original sources [@grace2006; @pan2011]. For our own estimates we considered only above ground carbon and it’s slope with respect to tree cover. With these estimates the global carbon storage potential is 104 GtC using the re-calculated estimates from Bastin 2019, and 73 GtC using the empirical relationships from the global datasets. 

Bastin 2019 state that global tree restoration is "the most effective solution" for mitigating climate change. This conclusion uses simple assumptions which ignore complex carbon dynamics, potential feedback loops, societal costs, and carbon saturation as forests mature (see IPCC 2018 sec. 4.3.7.2 and references therein). For example afforestation and reforestation is considered a feasible climate mitigation solution only in the tropics since it would reduce albedo in high latitudes [@fuss2018]. Yet, increasing forested areas in the tropics would compete for agriculture and other land use, triggering a number of socio-economic impacts [@fuss2018]. It is also difficult to place the 205 GtC estimate in the context of other mitigation options without a quantitative estimate of the timescale of forest regrowth. Though future studies using more nuanced analysis of carbon uptake could address this [@requena2019]. Regardless, we show that with more precise estimates using the empirical relationship between tree canopy cover and carbon storage, the global carbon stock potential of restored forests is likely between 73-85 GtC, less than 50% of the original estimate.


\newpage
![The relationship between carbon stock and tree cover for 5 of the 14 global biomes using global datasets (black regression line and grey points). The red lines for Total Carbon indicate the assumed increase in Tonnes of C/Ha for every increase in tree cover in the original analysis, while the red lines in Above Ground Carbon represents the original estimates minus the fraction of soil organic carbon. The global datasets were analyzed by randomly sampling 1,000,000 land points globally and querying the above ground biomass, 1-meter soil organic carbon, percent tree cover, and the corresponding biome. Above ground biomass was converted to carbon stock by multiplying by 0.5. Total carbon is above ground carbon plus soil organic carbon for each queired point. Note the difference in scales of the y-axis.](biomass_plots.png)


\newpage
\tiny

|  |  | Including Soil Organic Carbon |  |  |  | Without Soil Organic Carbon |  |  |  |
|----------------------------------------------------------|----------------------------|-------------------------------|------------------|-------------------------------|------------------|-----------------------------|------------------|-------------------------------|------------------|
|  |  | Tonnes C/ha increase with 1 Ha canopy |  | Total C Stock potential (GtC) |  | Tonnes C/ha increase with 1 Ha canopy |  | Total C Stock potential (GtC) |  |
| Biome | Potential Tree Cover (Mha) | Bastin Estimate | Current Estimate | Bastin Estimate | Current Estimate | Bastin Estimate | Current Estimate | Bastin Estimate | Current Estimate |
| Boreal Forests/Taiga | 178 | 239 | -316 | 43 | -56 | 86 | 51 | 15 | 9 |
| Deserts & Xeric Shrublands | 77.6 | 202 | 80 | 16 | 6 | 29 | 73 | 2 | 6 |
| Flooded Grasslands & Savannas | 9 | 202 | 62 | 2 | 1 | 29 | 73 | 0 | 1 |
| Mangroves | 2.6 | 282 | 292 | 1 | 1 | 199 | 95 | 1 | 0 |
| Mediterranean Forests, Woodlands & Scrub | 18.8 | 202 | 135 | 4 | 3 | 29 | 77 | 1 | 0 |
| Montane Grasslands & Shrublands | 19.3 | 202 | 167 | 4 | 3 | 29 | 109 | 1 | 2 |
| Temperate Broadleaf & Mixed Forests | 109 | 155 | 95 | 17 | 10 | 80 | 70 | 9 | 8 |
| Temperate Conifer Forests | 35.9 | 155 | 66 | 6 | 2 | 80 | 101 | 3 | 4 |
| Temperate Grasslands, Savannas & Shrublands | 72.5 | 155 | 68 | 11 | 5 | 80 | 62 | 6 | 5 |
| Tropical & Subtropical Coniferous Forests | 7.1 | 282 | 161 | 2 | 1 | 199 | 91 | 1 | 1 |
| Tropical & Subtropical Dry Broadleaf Forests | 32.8 | 282 | 123 | 9 | 4 | 199 | 98 | 7 | 3 |
| Tropical & Subtropical Grasslands, Savannas & Shrublands | 189.5 | 282 | 154 | 54 | 29 | 199 | 97 | 38 | 18 |
| Tropical & Subtropical Moist Broadleaf Forests | 97.1 | 282 | 206 | 27 | 20 | 199 | 144 | 19 | 14 |
| Tundra | 50.6 | 202 | -76 | 10 | -4 | 29 | 39 | 1 | 2 |
|  |  |  |  | 206 | 25 (85^1^) |  |  | 104 | 73 |

\normalsize

Table 1: Estimates of the Tonnes C/ha relationship and per biome estimate of total carbon storage potential using the original estimates from Bastin 2019, estimates derived using global datasets in the current study, and all estimates adjusted to exclude soil organic carbon. The biome specific potential tree canopy cover is from Bastin 2019 Table S2. ^1^ 85 GtC here is the global potential is calculated without considering Boreal Forests or Tundra, as these biomes have a negative relationship between carbon stock and tree canopy cover. 

\newpage
# References

\small