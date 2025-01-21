process BLASTP_DB {
    label 'midmem'
	container 'ncbi/blast:2.16.0'

    input:
        file(fa)

    output:
	   path("./blast_db_nf"), emit: db


    script:

    """
    makeblastdb -in ${fa} -blastdb_version 5 -title "blast_db_nf" -dbtype prot
    """
}

process BLASTP {
    label 'low'
    container 'ncbi/blast:2.16.0'

    input:
        file(fa)
        file(db)

    output:
       path("blast_result"), emit: result


    script:

    """
    mblastp -db $db/$db_name -query query.fa -outfmt 6 > blast_result
    """
}