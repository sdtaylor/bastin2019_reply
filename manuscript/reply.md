---
csl: csl.csl
output:
  pdf_document:
    keep_tex: true
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

# Abstract
*Key Message* 
Bastin et al. 2019 used flawed assumptions in calculating the carbon storage of restored forests worldwide, resulting in a gross overestimate.

*Context* 
Bastin et al. 2019 use two flawed assumptions: 1) that the area suitable for restoration did not contain any carbon currently, and 2) that soil organic carbon (SOC) from increased canopy cover will accumulate quickly enough to mitigate anthropogenic carbon emissions. 

*Aims* 
We re-evaluated the potential carbon storage worldwide using empirical relationships of tree cover and carbon.

*Methods and Results* 
We use global datasets of tree cover, soil organic carbon, and above ground biomass to estimate the empirical relationships of tree cover and carbon stock storage. A more realistic range of global carbon storage potential is between 71.7 and 75.7 GtC globally, with a large uncertainty associated with SOC. This is less than half of the original 205 GtC estimate.

*Conclusion* 
The potential global carbon storage of restored forests is much less than that estimated by Bastin et al. 2019. While we agree on the value of assessing global reforestation potential, we suggest caution in considering it the most effective strategy to mitigate anthropogenic emissions.

# Main
-@bastin2019 (hereafter referred to as Bastin 2019) use a novel machine learning based method to model global tree canopy cover potential. After accounting for current tree canopy cover and areas already occupied by urban and agricultural land they estimate 900 Mha of potential tree canopy cover available worldwide for reforestation. Using biome specific estimates of Tonnes C/ha they calculate the global carbon storage potential of this 900 Mha of tree canopy cover. The Tonnes/C ha-1 values for each biome are derived from average estimates of total carbon storage from two studies of forest [@pan2011] and tropical grassland [@grace2006] carbon stock. Thus from their calculation a hectare of restored tree canopy is equivalent to adding a full hectare of carbon stock potential regardless of the vegetation already in place, and results in an overestimate of the global carbon stock potential of restored trees.

To better estimate the relationship between total carbon stock density and tree cover we randomly sampled locations from four global datasets of 1) above ground biomass  [@ABG2019], 2) soil organic carbon (SOC) to 1-meter [@hengl2017], 3) percent tree cover [@hansen2013], and 4) the corresponding biome [@olson2001]. We further subset these locations to those within protected areas (Levels I-V, @protected_areas) to minimize human influence on vegetation development and better represent the full carbon storage potential. Across all biomes there is already ample carbon stock at all levels of tree cover, and the relationship is weak in several biomes due to the contribution of SOC (Fig. 1). The slope of this relationship is a more accurate representation of the potential carbon stock gained with tree cover. For example in Tropical Grasslands Bastin 2019 estimate that an additional 0.5 ha of canopy cover (an additional 50% canopy cover) will add 141.25 Tonnes C. The empirical relationship shows an additional 50% tree cover in this biome means an additional 25.6 Tonnes C/Ha on average. Further, the Boreal Forest and Tundra biomes have a negative relationship between carbon stock and tree canopy cover, potentially resulting in a net carbon source if tree canopy cover was added in these biomes. Applying the updated estimates across all 14 biomes results in 28.4 GtC of potential carbon stock if the additional 900 Mha of global tree canopy potential was realized, and 71.7 GtC if the negative contribution from Boreal and Tundra biomes are removed.

This calculation is further complicated by SOC. SOC makes up the majority of carbon stock in all biomes, and in seven biomes it has no relationship with tree cover (*p > 0.05*, see Supplemental Fig. S1). In boreal regions (the biome for 19.8% of the potential canopy area estimated by Bastin 2019) afforestation can cause a temporary increase of greenhouse gas emissions due to quicker SOC mineralization, which can take several decades to recover [@karhu2011]. SOC also forms at rates of less than 0.5 Mg Ha\textsuperscript{-1} year\textsuperscript{-1} in many areas [@trumbore1997; @gaudinski2000; @lichter2008], though sometimes up to 1.5 Mg Ha\textsuperscript{-1} year\textsuperscript{-1} [@shi2014], and it is unreasonable to assume increased tree cover would lead to SOC accumulation at a rate quick enough to effectively mitigate carbon emissions [@he2016]. To explore the potential carbon storage of increased global tree cover without considering the complexities of SOC we adjusted all estimates by removing the contribution of SOC. For the Bastin 2019 estimates we re-calculated the carbon stock potential minus the SOC fraction using the original sources [@grace2006; @pan2011]. For our own estimates, we considered only aboveground carbon and its slope with respect to tree cover. With these estimates the global carbon storage potential is 104 GtC using the re-calculated estimates from Bastin 2019, and 75.7 GtC using the empirical relationships from the global datasets.

Bastin 2019 state that global tree restoration is "the most effective solution" for mitigating climate change. This conclusion uses simple assumptions which ignore complex carbon dynamics, potential feedback loops, societal costs, and carbon saturation as forests mature (see -@ipcc2018ch4 sec. 4.3.7.2 and references therein). For example, some authors consider afforestation and reforestation as an effective mitigation solution only in the tropics since it would reduce albedo in high latitudes [@fuss2018]. Yet, increasing forested areas in the tropics would compete for agriculture and other land use, triggering a number of socio-economic impacts [@fuss2018]. It is also difficult to place the 205 GtC estimate in the context of other mitigation options without a quantitative estimate of the timescale of global forest regrowth, which requires local studies using more nuanced analysis of carbon uptake [et. @requena2019]. Several other comments to Bastin 2019 have raised similar concerns. Namely that the original analysis does not adequately consider SOC, currently in place vegetation, or feedback loops such as fire and changed albedo [@veldman2019; @lewis2019; @friedlingstein2019]. -@veldman2019 re-analyzed the Bastin 2019 results using literature derived values of carbon storage and arrived at a potential 107 GtC from the original 900 Mha of canopy cover. Here, by using biome specific empirically derived relationships of carbon storage and canopy cover from global datasets, we show the potential global carbon storage of restored forests ranges between 71.7 - 75.7 GtC, less than 40% of the original estimate. Along with the other comments this demonstrates that the original Bastin 2019 estimate was clearly overestimated.



\newpage
![The relationship between carbon stock and tree cover for 6 of the 14 global biomes using global datasets (black regression line and grey points). The red lines for Total Carbon indicate the assumed increase in Tonnes of C/Ha for every increase in tree cover in the original analysis, while the red lines in Above Ground Carbon represents the original estimates minus the fraction of soil organic carbon. The global datasets were randomly sampled for land points within protected areas globally and querying the above ground biomass, 1-meter soil organic carbon, percent tree cover, and the corresponding biome. Above ground biomass was converted to carbon stock by multiplying by 0.5. Total carbon is above ground carbon plus soil organic carbon for each queried point. Note the difference in scales of the y-axis. See Figure S1 for relationships of all 14 biomes.](fig1_carbon_stock_plots.png)


\newpage
\tiny

|                                                          |                            | Including Soil Organic Carbon         |                  |                               |                  | Without Soil Organic Carbon           |                  |                               |                  |
|----------------------------------------------------------|----------------------------|---------------------------------------|------------------|-------------------------------|------------------|---------------------------------------|------------------|-------------------------------|------------------|
|                                                          |                            | Tonnes C/ha increase with 1 Ha canopy |                  | Total C Stock potential (GtC) |                  | Tonnes C/ha increase with 1 Ha canopy |                  | Total C Stock potential (GtC) |                  |
| **Biome**                                                | **Potential Tree Cover (Mha)** | **Bastin 2019**| **Current Study** | **Bastin 2019** | **Current Study** | **Bastin 2019**   |**Current Study** | **Bastin 2019**   | **Current Study** |
| Boreal Forests/Taiga                                     | 178                        | 239.2                                 | -240.4           | 42.6                          | -42.8            | 86.1                                  | 45.3             | 15.3                          | 8.1              |
| Deserts & Xeric Shrublands                               | 77.6                       | 202.4                                 | 109.2            | 15.7                          | 8.5              | 28.5                                  | 76.9             | 2.2                           | 6                |
| Flooded Grasslands & Savannas                            | 9                          | 202.5                                 | 375.7            | 1.8                           | 3.4              | 28.6                                  | 63.7             | 0.3                           | 0.6              |
| Mangroves                                                | 2.6                        | 282.5                                 | 190.5            | 0.7                           | 0.5              | 198.9                                 | 105.9            | 0.5                           | 0.3              |
| Mediterranean Forests, Woodlands & Scrub                 | 18.8                       | 202.4                                 | 154.6            | 3.8                           | 2.9              | 28.5                                  | 85.2             | 0.5                           | 1.6              |
| Montane Grasslands & Shrublands                          | 19.3                       | 202.4                                 | 136.9            | 3.9                           | 2.6              | 28.5                                  | 120.1            | 0.6                           | 2.3              |
| Temperate Broadleaf & Mixed Forests                      | 109                        | 154.7                                 | 1.7              | 16.9                          | 0.2              | 80.4                                  | 81               | 8.8                           | 8.8              |
| Temperate Conifer Forests                                | 35.9                       | 154.7                                 | 106.6            | 5.6                           | 3.8              | 80.4                                  | 108.6            | 2.9                           | 3.9              |
| Temperate Grasslands, Savannas & Shrublands              | 72.5                       | 154.7                                 | 51.1             | 11.2                          | 3.7              | 80.4                                  | 67.4             | 5.8                           | 4.9              |
| Tropical Coniferous Forests                              | 7.1                        | 282.5                                 | 144.4            | 2                             | 1                | 198.9                                 | 97.9             | 1.4                           | 0.7              |
| Tropical Dry Broadleaf Forests                           | 32.8                       | 282.5                                 | 171.4            | 9.3                           | 5.6              | 198.9                                 | 101.8            | 6.5                           | 3.3              |
| Tropical Grasslands, Savannas & Shrublands               | 189.5                      | 282.5                                 | 137.3            | 53.5                          | 26               | 198.9                                 | 98               | 37.7                          | 18.6             |
| Tropical Moist Broadleaf Forests                         | 97.1                       | 282.5                                 | 139.5            | 27.4                          | 13.5             | 198.9                                 | 150.3            | 19.3                          | 14.6             |
| Tundra                                                   | 50.6                       | 202.4                                 | -9.9             | 10.2                          | -0.5             | 28.5                                  | 38.6             | 1.4                           | 2                |
| Total                                                    |                            |                                       |                  | 204.6                         | 28.4(71.7^1^)      |                                       |                  | 103.2                         | 75.7             |

\normalsize

Table 1: Estimates of the Tonnes C/ha relationship and per biome estimate of total carbon storage potential using the original estimates from Bastin 2019, estimates derived using global datasets in the current study, and all estimates adjusted to exclude soil organic carbon. The biome specific potential tree canopy cover is from Bastin 2019 Table S2. ^1^ 71.7 GtC is the global potential is calculated without considering Boreal Forests or Tundra, as these biomes have a negative relationship between total carbon stock and tree canopy cover. 

\newpage

# Supplemental Material

Supplemental Figure S1, carbon stock relationships for all 14 biomes.

# References

\small
