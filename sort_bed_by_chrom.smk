chrom_selection  = [l.strip() for l in open ("metadata/chrom_selection.tsv")] 
rule split_by_chrom:
    input:
        bedlist = lambda wildcards: config["alias"][wildcards.alias]
    params:
        chrom_list = ",".join(chrom_selection)
    output:
        all_chrom_files = temp(expand("splitted/{{alias}}_chrom_{chrom}.bed", chrom = chrom_selection))
    shell:
        "sh scripts/split.sh {input.bedlist} {params.chrom_list} \"splitted/\"{wildcards.alias}"  

rule sort_individual_chrom_files:
    input:
        indiv_chrom_file = "splitted/{alias}_chrom_{chrom}.bed"
    output:
        sorted_file = temp("split_sorted/{alias}_chrom_{chrom}.bed") 
    shell:
        "sort -S4G  --parallel=4 -k2,2n -k3,3n {input.indiv_chrom_file} > {output.sorted_file}" # no need to short by chrom because there is only one chrom
def collect_files (wildcards): 
    flist = []
    for c in chrom_selection:
        flist.append("split_sorted/{alias}_chrom_{chrom}.bed".format(alias = wildcards.alias, chrom = c))
    return flist
rule combine_sorted_files:
    input:
        list_of_sorted_files = lambda wildcards: collect_files(wildcards)      
    output:
        final_sorted = "sorted/{alias}.bed.gz"
    shell:
        "cat {input.list_of_sorted_files} | gzip - > {output.final_sorted}"
