#!/usr/bin/env nextflow

include {FASTQC} from './modules/fastqc'
include {PARSE_GTF} from './modules/parse_gtf'
include {INDEX} from './modules/star'
include {ALIGN} from './modules/star_align'
include {MULTIQC} from './modules/multiqc'
include {VERSE} from './modules/verse'
include {CONCAT} from './modules/concat'


workflow {

    Channel.fromFilePairs(params.reads).transpose().set{ fastqc_channel }
    Channel.fromFilePairs(params.reads).set{ align_ch }
       
    PARSE_GTF(params.gtf)
    FASTQC(fastqc_channel) 
    
    INDEX(params.genome, params.gtf) 
    
    ALIGN(align_ch, INDEX.out.index)
   
    FASTQC.out.zip
        .collect()
    | set { fastqc_out }
    
    ALIGN.out.log
        .mix(fastqc_out)
        .flatten()
        .collect()
    | set { multiqc_channel }
     
    MULTIQC(multiqc_channel)

    VERSE(params.gtf, ALIGN.out.bam)

    VERSE.out.counts
        .collect()
    | set{ concat_ch }

    CONCAT(concat_ch)
        view()

}
