#!/usr/bin/env nextflow

process ALIGN {
    label 'process_high'
    container 'ghcr.io/bf528/star:latest'
    publishDir params.outdir

    input:
    tuple val(sample_id), path(reads)
    path(index)
    

    output:
    tuple val(sample_id), path('*.Aligned.out.bam'), emit: bam
    path('*.Log.final.out'), emit: log

    script:
    """
    STAR --runThreadN $task.cpus --genomeDir star --readFilesIn ${reads[0]} ${reads[1]} --readFilesCommand zcat --outFileNamePrefix $sample_id. --outSAMtype BAM Unsorted 2>${sample_id}.Log.final.out
    """

    stub: 
    """
    touch ${sample_id}.Log.final.out
    touch ${sample_id}.Aligned.out.bam
    """
}