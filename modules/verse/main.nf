#!/usr/bin/env nextflow

process VERSE {
    label 'process_high'
    container 'ghcr.io/bf528/verse:latest'
    publishDir params.outdir

    input:
    path gtf
    tuple val(sample_id), path(bam)

    output:
    path('*.exon.txt'), emit: counts

    script:
    """
    verse -S -a $gtf -o ${sample_id}.exon.txt $bam
    """

    stub:
    """
    touch ${sample_id}.exon.txt
    """


}