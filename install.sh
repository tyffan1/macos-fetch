#!/bin/zsh
# Installs the `macos` command to ~/.local/bin and adds PATH to ~/.zshrc and ~/.bashrc.
set -e

src_dir=${0:A:h}
bin_dir=$HOME/.local/bin

if [[ ! -f $src_dir/macos ]]; then
    print -u2 "Error: script $src_dir/macos not found"
    exit 1
fi

chmod +x "$src_dir/macos"
mkdir -p "$bin_dir"
ln -sf "$src_dir/macos" "$bin_dir/macos"
print "✓ Symlink: $bin_dir/macos -> $src_dir/macos"

# List of config files for different shells
rc_files=($HOME/.zshrc $HOME/.bashrc)

for rc in "${rc_files[@]}"; do
    if ! grep -qE '^[[:space:]]*export[[:space:]]+PATH=.*\.local/bin' "$rc" 2>/dev/null; then
        print >> "$rc"
        print '# User commands (macos fetch)' >> "$rc"
        print 'export PATH="$HOME/.local/bin:$PATH"' >> "$rc"
        print "✓ PATH added to $rc"
    else
        print "• PATH already configured in $rc"
    fi
done

print
print 'Done. Open a new terminal or run:'
print '  source ~/.zshrc   # for zsh'
print '  source ~/.bashrc  # for bash'
print 'Check:  macos'
