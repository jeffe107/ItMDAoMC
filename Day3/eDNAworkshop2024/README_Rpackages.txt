First install R and RStudio following these links:
https://posit.co/download/rstudio-desktop/

Enter RStudio and type the following commands to get the required packages

Install ideally R 4.4.+ and BiocManager 3.20
Or 
R 4.5 and BiocManager 3.21 but in this case one package must be installed without BiocManager (see below).

# these commands should be run once
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.21")

install.packages("devtools")

BiocManager::install("dada2")
BiocManager::install("phyloseq")
BiocManager::install("Biostrings")BiocManager::install("ggplot2")
BiocManager::install("magrittr")
BiocManager::install("vegan")BiocManager::install("gridExtra")
BiocManager::install("microbiomeMarker")
devtools::install_github("zachcp/phylogeo")

# These might require some recompilation and ask for additional packages, please answer Yes to the questions.

# You can then check for each library if they load with these commands:
library(dada2, quietly = TRUE)
library(phyloseq, quietly = TRUE)library(Biostrings, quietly = TRUE)library(ggplot2, quietly = TRUE)library(magrittr, quietly = TRUE)library(vegan, quietly = TRUE)
library(gridExtra, quietly = TRUE)library(phylogeo, quietly = TRUE)

library(microbiomeMarker, quietly = TRUE)

#problem if microbiomeMarker not for Bioc 3.21...
  install.packages("remotes")
remotes::install_github("yiluheihei/microbiomeMarker")


# sessionInfo() lists all packages and their versions:
# here are mine

> sessionInfo()## R version 4.5.0 (2025-04-11)
## Platform: x86_64-apple-darwin20
## Running under: macOS Sequoia 15.3.1
## 
## Matrix products: default
## BLAS:   /Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/lib/libRblas.0.dylib 
## LAPACK: /Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.1
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## time zone: Europe/Zurich
## tzcode source: internal
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] dada2_1.35.8 Rcpp_1.0.14 
## 
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.37.0 gtable_0.3.6               
##  [3] xfun_0.52                   bslib_0.9.0                
##  [5] hwriter_1.3.2.1             ggplot2_3.5.2              
##  [7] latticeExtra_0.6-30         Biobase_2.67.0             
##  [9] lattice_0.22-7              vctrs_0.6.5                
## [11] tools_4.5.0                 bitops_1.0-9               
## [13] generics_0.1.3              stats4_4.5.0               
## [15] parallel_4.5.0              tibble_3.2.1               
## [17] pkgconfig_2.0.3             Matrix_1.7-3               
## [19] RColorBrewer_1.1-3          S4Vectors_0.45.4           
## [21] RcppParallel_5.1.10         lifecycle_1.0.4            
## [23] GenomeInfoDbData_1.2.14     farver_2.1.2               
## [25] stringr_1.5.1               deldir_2.0-4               
## [27] compiler_4.5.0              Rsamtools_2.23.1           
## [29] Biostrings_2.75.4           munsell_0.5.1              
## [31] codetools_0.2-20            GenomeInfoDb_1.43.4        
## [33] htmltools_0.5.8.1           sass_0.4.10                
## [35] yaml_2.3.10                 pillar_1.10.2              
## [37] crayon_1.5.3                jquerylib_0.1.4            
## [39] BiocParallel_1.41.5         cachem_1.1.0               
## [41] DelayedArray_0.33.6         ShortRead_1.65.0           
## [43] abind_1.4-8                 tidyselect_1.2.1           
## [45] digest_0.6.37               stringi_1.8.7              
## [47] reshape2_1.4.4              dplyr_1.1.4                
## [49] labeling_0.4.3              fastmap_1.2.0              
## [51] grid_4.5.0                  colorspace_2.1-1           
## [53] cli_3.6.4                   SparseArray_1.7.7          
## [55] magrittr_2.0.3              S4Arrays_1.7.3             
## [57] withr_3.0.2                 scales_1.3.0               
## [59] UCSC.utils_1.3.1            rmarkdown_2.29             
## [61] pwalign_1.3.3               XVector_0.47.2             
## [63] httr_1.4.7                  matrixStats_1.5.0          
## [65] jpeg_0.1-11                 interp_1.1-6               
## [67] png_0.1-8                   evaluate_1.0.3             
## [69] knitr_1.50                  GenomicRanges_1.59.1       
## [71] IRanges_2.41.3              rlang_1.1.6                
## [73] glue_1.8.0                  formatR_1.14               
## [75] BiocGenerics_0.53.6         rstudioapi_0.17.1          
## [77] jsonlite_2.0.0              plyr_1.8.9                 
## [79] R6_2.6.1                    MatrixGenerics_1.19.1      
## [81] GenomicAlignments_1.43.0