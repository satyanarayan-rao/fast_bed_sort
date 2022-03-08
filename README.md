# fast_bed_sort
Sorting large bed files by chromosome splitting

```
snakemake -np  --snakefile sort_bed_by_chrom.smk sorted/reps_combined.bed.gz --configfile configs/config.yaml -j3
```

## Chromosome order

It is important to note that chromosome order in `metadata/chrom_selection.tsv` should be exactly in a way `sort` command works on chromosome names.
