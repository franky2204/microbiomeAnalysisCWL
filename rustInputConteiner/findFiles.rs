use std::env;
use std::fs;
use std::path::Path;

const SEARCH_STRING: &str = "R1.f";
const REPLACE_STRING: &str = "R1.f";
const REPLACE_WITH_STRING: &str = "R2.f";

fn main() -> std::io::Result<()> {
    // Ottieni il percorso della cartella dalla riga di comando
    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
        eprintln!("Uso: {} <percorso_cartella>", args[0]);
        std::process::exit(1);
    }
    let folder_path = &args[1];

    let mut string = String::new();
    let mut count = 0;

    // Scansiona i file nella directory
    for entry in fs::read_dir(folder_path)? {
        let entry = entry?;
        let path = entry.path();
        if path.is_file() && path.to_string_lossy().contains(SEARCH_STRING) {
            // Crea il nome del file R2
            let r2_filename = path.file_name().unwrap().to_string_lossy()
                .replace(REPLACE_STRING, REPLACE_WITH_STRING);
            let r2_path = Path::new(folder_path).join(&r2_filename);
            // Controlla se esiste il file R2
            if r2_path.exists() {
                // Aggiungi i nomi dei file alla stringa
                if count > 0 {
                    string.push(',');
                }
                string.push_str(&format!("\"{},{}\"", path.file_name().unwrap().to_string_lossy(), r2_filename));
                count += 1;
            }
        }
    }

    // Stampa la stringa JSON
    println!("{{\"value\": [{}]}}", string);

    Ok(())
}
