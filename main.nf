#!/usr/bin/env nextflow

nextflow.enable.dsl=2

ch_db_proteins = params.prot_db
Channel.fromPath(params.query).splitFasta(by: params.chunkSize, file:true).set { ch_fasta }


include { BLASTP as BLASTP } from './workflows/BLASTP.nf'


workflow {


    if (params.workflow_opt == 'blastp') {

        BLASTP(ch_db_proteins, ch_fasta)

        }

}