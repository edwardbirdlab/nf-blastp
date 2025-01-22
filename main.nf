#!/usr/bin/env nextflow

nextflow.enable.dsl=2

ch_db_proteins = Channel.fromPath(params.prot_db)

ch_fasta = Channel.fromPath(params.prot_query).splitFasta( by: params.chunksize ).view()


include { BLASTP as BLASTP } from './workflows/BLASTP.nf'


workflow {


    if (params.workflow_opt == 'blastp') {

        BLASTP(ch_db_proteins, ch_fasta)

        }

}