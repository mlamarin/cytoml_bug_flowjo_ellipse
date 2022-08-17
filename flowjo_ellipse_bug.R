# marc.R
library(CytoML)
library(devtools)
library(dplyr)
library(ggcyto)

wsp_trol <- "cytotrol.wsp"
fcs_trol1 <- "CytoTrol_CytoTrol_1.fcs"

ws_trol <- CytoML::open_flowjo_xml(wsp_trol) 
CytoML::fj_ws_get_samples(ws_trol)
#   sampleID                    name  count pop.counts
# 1        1 CytoTrol_CytoTrol_1.fcs 119531          2

gs_trol <- CytoML::flowjo_to_gatingset(ws_trol, name = "All Samples", 
      path = dirname(fcs_trol1),
      extend_val = -Inf,
      extend_to = -4000,
      subset = 1,
      execute = TRUE)

gh_trol <- gs_trol[[1]]

# No openCytoCounts due to wrong ellipses location 
gh_pop_compare_stats(gh_trol, path = "full")
#    openCyto.freq  xml.freq openCyto.count xml.count   node
# 1:             1 1.0000000         119531    119531   root
# 2:             0 0.5334850              0     63768 /Elli1
# 3:             0 0.2189976              0     26177 /Elli2

pop1 <- '/Elli1'
pop2 <- '/Elli2'
ga <- gh_pop_get_gate(gh_trol, pop1)
str(ga)
# Possibly a scaling problem ?
head(ga@boundaries)
#          FSC-A     SSC-A
# [1,] 0.5378150 0.4049080
# [2,] 0.5288197 0.4125057
# [3,] 0.5191565 0.4192131
# [4,] 0.5089321 0.4249802
# [5,] 0.4982603 0.4297791
# [6,] 0.4872573 0.4336035
ggcyto(gs_trol, aes(x = "FSC-A", y = "SSC-A"),
    subset = dirname(pop1)) + 
    geom_hex(bins = 128) +
    geom_gate(pop1) +
    geom_gate(pop2)


