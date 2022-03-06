# fast_bed_sort
Sorting large bed files by chromosome splitting

```
snakemake -np  --snakefile sort_bed_by_chrom.smk sorted/reps_combined.bed.gz --configfile configs/config.yaml -j3
```
