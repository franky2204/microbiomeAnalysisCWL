import sys

def divide_fastq(file_path):
    with open(file_path, 'r') as fastq_file, open(sys.argv[2], 'w') as file_1, open(sys.argv[3], 'w') as file_2:
        line_count = 0
        read_id = None
        for line in fastq_file:
            line = line.strip()
            line_count += 1
            if line_count % 4 == 1:  # Inizio di una nuova read
                read_id = line
                if '/1' in read_id:
                    current_file = file_1
                elif '/2' in read_id:
                    current_file = file_2
                else:
                    raise ValueError(f"Invalid read ID format in line {line_count}: {read_id}")
            current_file.write(line + '\n')

        print("File divisi con successo.")

# Esempio di utilizzo
divide_fastq(sys.argv[1])

