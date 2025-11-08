#!usr/bin/env nextflow

process MULTIQC {
    label 'process_low'
    container 'ghcr.io/bf528/multiqc:latest' // the environment to run to run the tools 
    publishDir params.outdir

    input:
    path('*') // this will automatically create an HTML file as an output
    // path and file are interchangable 

    output: // file you expect to exist 
    path('multiqc_report.html')

    script:
    """
    multiqc . -o . -f
    """

    stub:
    """
    touch multiqc_report.html
    """


}