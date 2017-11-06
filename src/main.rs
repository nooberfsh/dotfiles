use std::io;
use std::env;
use std::fs;
use std::process::Command;
use std::path::PathBuf;

fn create_soft_links() -> io::Result<()> {
    let mut config_dir: PathBuf = env::current_dir().unwrap();
    config_dir.push("config");

    let mut config_files = vec![];

    for entry in fs::read_dir(&config_dir)? {
        let entry = entry?;
        let path = entry.path();
        let name = path.file_name().unwrap();
        config_files.push(name.to_os_string());
    }

    println!("found {:?}\n", config_files);

    let dst: PathBuf = env::home_dir().unwrap();
    for config in config_files {
        let mut dst = dst.clone();
        dst.push(&config);

        if dst.exists() {
            println!("exist {:?}, delete it", dst);
            fs::remove_file(&dst)?;
        }

        let mut src = config_dir.clone();
        src.push(&config);

        let output = Command::new("ln")
            .arg("-s")
            .arg(&src)
            .arg(&dst)
            .output()
            .unwrap();
        let st = output.status;
        if st.success() {
            println!("create {:?} success", dst);
        } else {
            println!("create {:?} failed, code: {:?}", dst, st.code());
        }

        println!();
    }

    Ok(())
}

fn main() {
    let r = create_soft_links();
    println!("{:?}", r);
}
