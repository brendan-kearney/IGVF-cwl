class: Workflow
cwlVersion: v1.2
doc: 'RNA-seq pipeline - reads: PE'
requirements:
 - class: ScatterFeatureRequirement
 - class: SubworkflowFeatureRequirement
 - class: StepInputExpressionRequirement
inputs:
   input_fastq_read1_files:
     doc: Input read1 fastq files
     type: File[]
   input_fastq_read2_files:
     doc: Input read2 fastq files
     type: File[]
   end_type: 
     doc: paired or single reads
     type: string     
   bamtools_forward_filter_file:
     doc: JSON filter file for forward strand used in bamtools (see bamtools-filter command)
     type: File
   bamtools_reverse_filter_file:
     doc: JSON filter file for reverse strand used in bamtools (see bamtools-filter command)
     type: File
   genome_sizes_file:
     doc: Genome sizes tab-delimited file (used in samtools)
     type: File
   nthreads_qc:
     doc: Number of threads - qc.
     type: int
   nthreads_quant:
     doc: Number of threads - quantification.
     type: int
   default_adapters_file:
     doc: Adapters file
     type: File
   trimmomatic_java_opts:
     doc: JVM arguments should be a quoted, space separated list (e.g. "-Xms128m -Xmx512m")
     type: string?
   rsem_reference_files:
     doc: RSEM genome reference files - generated with the rsem-prepare-reference command
     type: Directory
   nthreads_trimm:
     doc: Number of threads - trim.
     type: int
   STARgenomeDir:
     doc: STAR genome reference/indices directory.
     type: Directory
   nthreads_map:
     doc: Number of threads - map.
     type: int
   annotation_file:
     doc: GTF annotation file
     type: File
   genome_fasta_files:
     doc: STAR genome generate - Genome FASTA file with all the genome sequences in FASTA format
     type: File[]
   trimmomatic_jar_path:
     doc: Trimmomatic Java jar file
     type: string
   sjdbOverhang:
     doc: Length of the genomic sequence around the annotated junction to be used in constructing the splice junctions database.
     type: string
outputs:
   output_fastqc_report_files_read1:
     doc: FastQC reports in zip format for paired read 1
     type: File[]
     outputSource: qc/output_fastqc_report_files_read1
   output_fastqc_data_files_read1:
     doc: FastQC data files for paired read 1
     type: File[]
     outputSource: qc/output_fastqc_data_files_read1
   output_count_raw_reads_read1:
     outputSource: qc/output_count_raw_reads_read1
     type: File[]
   output_custom_adapters_read1:
     outputSource: qc/output_custom_adapters_read1
     type: File[]
   output_diff_counts_read1:
     outputSource: qc/output_diff_counts_read1
     type: File[]
   output_fastqc_report_files_read2:
     doc: FastQC reports in zip format for paired read 2
     type: File[]
     outputSource: qc/output_fastqc_report_files_read2
   output_fastqc_data_files_read2:
     doc: FastQC data files for paired read 2
     type: File[]
     outputSource: qc/output_fastqc_data_files_read2
   output_count_raw_reads_read2:
     outputSource: qc/output_count_raw_reads_read2
     type: File[]
   output_custom_adapters_read2:
     outputSource: qc/output_custom_adapters_read2
     type: File[]
   output_diff_counts_read2:
     outputSource: qc/output_diff_counts_read2
     type: File[]
steps:
   qc:
     in:
       input_fastq_read1_files: input_fastq_read1_files
       input_fastq_read2_files: input_fastq_read2_files
       default_adapters_file: default_adapters_file
       nthreads: nthreads_qc
       end_type: end_type
     run: 01-qc.cwl
     out:
     - output_fastqc_report_files_read1
     - output_fastqc_data_files_read1
     - output_custom_adapters_read1
     - output_count_raw_reads_read1
     - output_diff_counts_read1
     - output_fastqc_report_files_read2
     - output_fastqc_data_files_read2
     - output_custom_adapters_read2
     - output_count_raw_reads_read2
     - output_diff_counts_read2
