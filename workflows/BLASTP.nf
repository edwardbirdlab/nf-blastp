/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { BLASTP_SW as BLASTP_SW } from '../subworkflows/BLASTP_SW.nf'


workflow BLASTP {
    take:
        
        db_prots    //    channel: [ val(sample), fasta]
        query_prots //    channel: [ val(sample), fasta]

    main:
        BLASTP_SW(db_prots, query_prots)


}