#Docker container for tblastx for PPARG_PIG to human

FROM debian

MAINTAINER Hiromasa Ono, hiromasa.ono@gmail.com

# Install packages
RUN apt-get update && \
    apt-get install -y wget gzip ncbi-blast+ &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

RUN wget ftp://ftp.ensembl.org/pub/current_fasta/homo_sapiens/cdna/Homo_sapiens.GRCh38.cdna.all.fa.gz && gunzip -f Homo_sapiens.GRCh38.cdna.all.fa.gz
RUN wget http://togows.org/entry/ncbi-nuccore/723266032.fasta -O pigPPARG.fasta

RUN makeblastdb -in Homo_sapiens.GRCh38.cdna.all.fa -dbtype nucl -hash_index

CMD ["tblastx", "-query", "pigPPARG.fasta",  "-db", "Homo_sapiens.GRCh38.cdna.all.fa", "-outfmt", "6", "-max_target_seqs", "1", "-evalue", "1e-10", "-num_threads", "4"]
