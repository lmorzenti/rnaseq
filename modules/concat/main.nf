#!/usr/bin/env nextflow

process CONCAT {
    label 'process_medium'
    container 'ghcr.io/bf528/pandas:latest'
    publishDir params.outdir

    input:
    path(counts)

    output:
    path('verse_concat.csv'), emit: concat

    script:
    """
    count.py -i ${counts.join(' ')} -o verse_concat.csv
    """

    stub:
    """
    touch verse_concat.csv
    """




}