use std::io;
use std::env;
use std::fs;
use std::process::Command;
use std::path::PathBuf;

fn create_soft_link() -> io::Result<()> {
    let config_dir: PathBuf = "config".into();

    let mut config_files = vec![];

    for entry in fs::read_dir(&config_dir)? {
        let entry = entry?;
        let path = entry.path();
        let name = path.file_name().unwrap();
        config_files.push(name.to_os_string());
    }

    println!("found {:?}", config_files);

    let dst: PathBuf = env::home_dir().unwrap();
    for config in config_files {
        let mut dst = dst.clone();
        dst.push(&config);

        if dst.exists() {
            println!("exist {:?}, delete it", dst);
            fs::remove_file(&dst)?;
        }

        let mut src = env::current_dir().unwrap();
        src.push(&config_dir);
        src.push(&config);
        let mut cmd = Command::new("ln");
        cmd.arg("-s").arg(&src).arg(&dst);
        println!("execute {:?}", cmd);

        let output = cmd.output().unwrap();
        println!("{:?}", output);
    }

    Ok(())
}

fn main() {
    let r = create_soft_link();
    println!("{:?}", r);
}
