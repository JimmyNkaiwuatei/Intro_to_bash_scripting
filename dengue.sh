#!/bin/bash

#How many files are there in the zip file
unzip -l dengue.zip | wc -l

#How many lines are in each file?
find /home/eanbit11/Desktop/dengue/deng/deng1 -type f -exec wc -l {} + | awk '{print $1, "lines in", $2}'

#How many lines are in all the files combined?
find /home/eanbit11/Desktop/dengue/deng/deng1 -type f -exec cat {} + | wc -l

#Merge the files into one file and name it dengue_merged.fasta
cat /home/eanbit11/Desktop/dengue/*.fasta >/home/eanbit11/Desktop/dengue/dengue_merged.fasta

#How many headers does the new file have?
grep -c "^>" /home/eanbit11/Desktop/dengue/dengue_merged.fasta

#How many sequences does the new file have?
grep -c "^>" /home/eanbit11/Desktop/dengue/dengue_merged.fasta

#Extract the headers, and put them in a new file called dengue_headers.txt
grep -c "^>" /home/eanbit11/Desktop/dengue/dengue_merged.fasta > /home/eanbit11/Desktop/dengue/dengue_headers.txt

#Extract only the names of the viruses, and create a new file called viruses.txt.
grep "^>" /home/eanbit11/Desktop/dengue/dengue_headers.txt | awk '{print $1}' | sed 's/>//' > /home/eanbit11/Desktop/dengue/viruses.txt

#Create a file for only the sequences. Name it dengue_seq.txt
grep -v "^>" /home/eanbit11/Desktop/dengue/merged_dengue.fasta > /home/eanbit11/Desktop/dengue/dengue_seq.txt

#Replace the values in dengue_seq.txt with small letters.
tr '[:upper:]' '[:lower:]'< /home/eanbit11/Desktop/dengue/dengue_seq.txt > /home/eanbit11/Desktop/dengue/dengue_seq_lower.txt

#Which organism has the highest number of bases and the one with the least number of bases
awk '/^>/ {if (seq) print name, seq_length; name=$0; seq=""; seq_length=0; next} {seq=seq$0; seq_length+=length($0)} END {if (seq) print name, seq_length}' dengue_merged.fasta | sort -k2,2n
