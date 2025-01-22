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

        ch_blastp = query_prots.combine(BLASTP_DB.out.db)

        BLASTP(ch_blastp)

        BLASTP.out.result.collectFile(name: '${params.project_name}_blastp_of6.txt', storeDir:   params.launchDir).subscribe { file -> println "Entries are saved to file: $file"}
}