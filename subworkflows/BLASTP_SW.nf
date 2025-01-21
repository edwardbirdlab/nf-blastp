/*
Subworkflow for assembly QC using Kraken2, minimap2, and blobtools2
Requries set params:


*/

include { BLASTP_DB as BLASTP_DB } from '../modules/BLASTP.nf'
include { BLASTP as BLASTP } from '../modules/BLASTP.nf'


workflow BLASTP_SW {
    take:
        
        db_prots    //    channel: [ val(sample), fasta]
        query_prots //    channel: [ val(sample), fasta]


    main:

        BLASTP_DB(db_prots)

        BLASTP(query_prots, BLASTP_DB.out.db)

        BLASTP.out.result.collectFile(name: 'blastp_of6.txt').subscribe { file -> println "Entries are saved to file: $file"}
}