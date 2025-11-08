#!/usr/bin/env nextflow

process PARSE_GTF {
    label 'process_medium'
    container 'ghcr.io/bf528/biopython:latest'
    publishDir params.outdir

    input:
    path gtf

    output:
    path('id2name.txt'), emit: id2name

    script:
    """
    parse_gtf.py -i $gtf -o id2name.txt
    """
    // do you reiterate the input&output from above down below in the script?

    stub:
    """
    touch id2name.txt
    """


}

