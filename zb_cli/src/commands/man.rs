use clap::CommandFactory;
use std::path::Path;

pub fn execute(out_dir: &Path) -> Result<(), zb_core::Error> {
    let cmd = crate::cli::Cli::command();
    std::fs::create_dir_all(out_dir)
        .and_then(|_| clap_mangen::generate_to(cmd, out_dir))
        .map_err(|e| zb_core::Error::FileError {
            message: format!("{}: {e}", out_dir.display()),
        })
}
