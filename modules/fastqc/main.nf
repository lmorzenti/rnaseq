#!/usr/bin/env nextflow

process FASTQC {
    label 'process_medium'
    container 'ghcr.io/bf528/fastqc:latest'
    publishDir params.outdir, mode: 'copy'
    
    input:
    tuple val(sample_id), path(reads)

    output:
    path("${reads.simpleName}_fastqc.html"), emit: html
    path("${reads.simpleName}_fastqc.zip"), emit: zip
    // we should have these 2 files that exist after FASTQC runs.
    // one will be a zip and the other will be an html file
    // one FASTQC.out.zip and the other being FASTQC.out.html
    // PLEASE REMEMBER THAT THE EMIT WILL BE A .(WHAT YOU EMITTED)
    // with this notation, we can run only one of files though a later process
    
    script:
    """
    fastqc -t $task.cpus $reads
    """

    stub:
    """
    touch ${reads.simpleName}_fastqc.html
    touch ${reads.simpleName}_fastqc.zip
    """

}


