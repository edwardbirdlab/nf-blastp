process BLASTP_DB {
    label 'midmem'
	container 'ncbi/blast:2.16.0'

    input:
        file(fa)

    output:
	   path("./blast_db_nf"), emit: db


    script:

    """
    mkdir blast_db_nf
    makeblastdb -in ${fa} -blastdb_version 5 -dbtype prot -out ./prot_db
    mv prot_db* blast_db_nf
    """
}

process BLASTP {
    label 'low'
    container 'ncbi/blast:2.16.0'

    input:
        tuple file(fa), file(db)

    output:
       path("blast_result"), emit: result


    script:

    """
    blastp -db ./${db}/prot_db -query ${fa} -outfmt 6 > blast_result
    """
}